#!/usr/bin/env python3
"""Bound a Unix process group, retain logs, and capture timeout stacks.

This supervises process liveness; benchmark timing remains in clocks.
Usage: run-bounded.py SECONDS LOG_PREFIX COMMAND [ARG...]
Run with CPython on a Unix exposing waitid/WNOWAIT (PyPy lacks waitid).
Keep the leader unreaped until its group is killed,
so its PID/group ID stays reserved throughout cleanup.
"""
import os
from pathlib import Path
import signal
import subprocess
import sys


def stop_group(child):
    """Kill the owned group, then reap its leader. Its exit status survives."""
    try:
        os.killpg(child.pid, signal.SIGKILL)
    except ProcessLookupError:
        pass
    child.wait()


assert hasattr(os, 'waitid') and hasattr(os, 'WNOWAIT'), 'run with CPython python3 on a Unix with waitid/WNOWAIT'
seconds = int(sys.argv[1])
assert seconds > 0, 'the process-group deadline must be positive'
prefix = Path(sys.argv[2])
prefix.parent.mkdir(parents=True, exist_ok=True)
with prefix.with_suffix('.stdout.txt').open('w') as stdout, prefix.with_suffix('.stderr.txt').open('w') as stderr:
    child = subprocess.Popen(sys.argv[3:], stdout=stdout, stderr=stderr, start_new_session=True)
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
            os.waitid(os.P_PID, child.pid, os.WEXITED | os.WNOWAIT)
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
