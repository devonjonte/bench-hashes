#!/usr/bin/env python3
"""Bound a Unix process group, retain logs, and capture timeout stacks.

This supervises process liveness; benchmark timing remains in clocks.
Usage: run-bounded.py [--beside] SECONDS LOG_PREFIX COMMAND [ARG...]
       run-bounded.py --stop   (stop the running job's whole process group)
       run-bounded.py --wait SECONDS   (until the running job ends: exit 0
           when none runs, 1 when one still runs after SECONDS)
Run with CPython on a Unix exposing waitid/WNOWAIT (PyPy lacks waitid).
Keep the leader unreaped until its group is killed,
so its PID/group ID stays reserved throughout cleanup.

One heavy job at a time: the machine has 14 GiB, and two jobs that each
fit alone (a six-shard mutation check and the z3 proof helpers, October
22, 23:03) took the whole sandbox down together. A run holds LOCK while
it lives; a second run refuses to start, naming the first, unless given
--beside, a deliberate choice for a job known to be light.

To stop a running job, `run-bounded.py --stop`: it kills the job's group,
which the lock records, whether or not its supervisor still lives (an
aborted shell took the supervisor down and left a mutation run going,
October 24; `pkill -f PATTERN` then matched the shell that ran it).

To wait for a job, `run-bounded.py --wait SECONDS`: the lock is held
exactly while a job lives, so taking it is the answer. Never `pgrep -f`:
a wait loop's own command line contains the pattern and matches it
(October 25: such a loop waited 15 minutes on a job long finished).
"""
import fcntl
import os
from pathlib import Path
import signal
import subprocess
import sys

LOCK = Path.home() / '.run-bounded.lock'
# The job is killed when the machine's available memory falls under this.
FLOOR_MIB = 1536


def available_mib():
    for line in open('/proc/meminfo'):
        if line.startswith('MemAvailable:'):
            return int(line.split()[1]) // 1024
    raise SystemExit('/proc/meminfo has no MemAvailable line')


def stop_group(child):
    """Kill the owned group, then reap its leader. Its exit status survives."""
    try:
        os.killpg(child.pid, signal.SIGKILL)
    except ProcessLookupError:
        pass
    child.wait()


assert hasattr(os, 'waitid') and hasattr(os, 'WNOWAIT'), 'run with CPython python3 on a Unix with waitid/WNOWAIT'
if sys.argv[1:] == ['--stop']:
    text = LOCK.read_text() if LOCK.exists() else ''
    group = next((int(w) for k, w in zip(text.split(), text.split()[1:]) if k == 'group'), None)
    if group is None:
        sys.exit(f'no job group recorded in {LOCK} ({text.strip() or "empty"})')
    try:
        os.killpg(group, signal.SIGKILL)
        print(f'stopped process group {group} ({text.strip()})')
    except ProcessLookupError:
        print(f'process group {group} has already ended ({text.strip()})')
    sys.exit(0)
if sys.argv[1:2] == ['--wait']:
    import time
    deadline = time.monotonic() + int(sys.argv[2])
    with LOCK.open('a+') as probe:
        while True:
            try:
                fcntl.flock(probe, fcntl.LOCK_EX | fcntl.LOCK_NB)
                probe.seek(0)
                print(f'no job running (last: {probe.read().strip() or "none"})')
                sys.exit(0)
            except BlockingIOError:
                if time.monotonic() >= deadline:
                    probe.seek(0)
                    print(f'still running: {probe.read().strip()}')
                    sys.exit(1)
                time.sleep(5)
beside = sys.argv[1] == '--beside'
arguments = sys.argv[2:] if beside else sys.argv[1:]
seconds = int(arguments[0])
assert seconds > 0, 'the process-group deadline must be positive'
prefix = Path(arguments[1])
command = arguments[2:]
prefix.parent.mkdir(parents=True, exist_ok=True)
lock = LOCK.open('a+')
if not beside:
    try:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except BlockingIOError:
        lock.seek(0)
        sys.exit(f'another bounded job is running ({lock.read().strip()}); one heavy job at a time on this machine. '
                 'Wait for it, or pass --beside for a job known to be light.')
    lock.seek(0)
    lock.truncate()
    lock.write(f'pid {os.getpid()}, logs {prefix}, started {__import__("time").strftime("%H:%M:%S UTC", __import__("time").gmtime())}')
    lock.flush()
with prefix.with_suffix('.stdout.txt').open('w') as stdout, prefix.with_suffix('.stderr.txt').open('w') as stderr:
    child = subprocess.Popen(command, stdout=stdout, stderr=stderr, start_new_session=True)
    if not beside:
        # The job's group, for --stop: its leader's pid (a new session).
        lock.write(f', group {child.pid} ')
        lock.flush()
    try:
        def interrupted(number, _frame):
            print(f'Signal {number}; terminating the owned process group.', flush=True)
            raise SystemExit(128 + number)

        def expired(_number, _frame):
            raise subprocess.TimeoutExpired(child.args, seconds)

        for number in (signal.SIGTERM, signal.SIGINT):
            signal.signal(number, interrupted)
        signal.signal(signal.SIGALRM, expired)
        print(f'Running pid {child.pid}, deadline {seconds}s; logs: {prefix}', flush=True)
        status = None
        signal.setitimer(signal.ITIMER_REAL, seconds)
        try:
            # Kill the job before the machine runs out: MemAvailable under
            # FLOOR (three sandbox deaths, October 22-23, each a job that
            # filled memory faster than anyone was watching).
            while os.waitid(os.P_PID, child.pid, os.WEXITED | os.WNOWAIT | os.WNOHANG) is None:
                if available_mib() < FLOOR_MIB:
                    print(f'Memory floor: {available_mib()} MiB available, under {FLOOR_MIB}; terminating this process group.', flush=True)
                    status = 137
                    break
                __import__('time').sleep(1)
        except subprocess.TimeoutExpired:
            print('Deadline reached; collecting stacks and terminating this process group.', flush=True)
            try:
                with prefix.with_suffix('.stacks.txt').open('w') as stacks:
                    subprocess.run(['gdb', '-p', str(child.pid), '-batch', '-ex', 'set pagination off', '-ex', 'thread apply all bt'],
                                   stdout=stacks, stderr=subprocess.STDOUT, timeout=15)
            except (OSError, subprocess.TimeoutExpired) as error:
                print(f'Stack capture: {error}', flush=True)
            status = 124
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
        stop_group(child)
    if status is None:
        status = child.returncode
    print(f'Exit status: {status}', flush=True)
    print(prefix.with_suffix('.stderr.txt').read_text()[-3000:], flush=True)
    sys.exit(status if status >= 0 else 128 - status)
