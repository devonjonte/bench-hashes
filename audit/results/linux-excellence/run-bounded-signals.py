#!/usr/bin/env python3
"""Bound execution, retain logs, and capture thread stacks on a timeout.

This supervises process liveness; benchmark timing remains in clocks.
Usage: run-bounded.py SECONDS LOG_PREFIX COMMAND [ARG...]
"""
import os
from pathlib import Path
import signal
import subprocess
import sys

def stop_group(child):
    """Terminate the owned group, including descendants after its leader exits."""
    try:
        os.killpg(child.pid, signal.SIGTERM)
    except ProcessLookupError:
        pass
    try:
        child.wait(timeout=5)
    except subprocess.TimeoutExpired:
        pass
    try:
        os.killpg(child.pid, signal.SIGKILL)
    except ProcessLookupError:
        pass
    child.wait()


seconds = int(sys.argv[1])
prefix = Path(sys.argv[2])
prefix.parent.mkdir(parents=True, exist_ok=True)
with prefix.with_suffix('.stdout.txt').open('w') as stdout, prefix.with_suffix('.stderr.txt').open('w') as stderr:
    child = subprocess.Popen(sys.argv[3:], stdout=stdout, stderr=stderr, start_new_session=True)
    def interrupted(number, _frame):
        print(f'Signal {number}; terminating the owned process group.', flush=True)
        stop_group(child)
        raise SystemExit(128 + number)
    for number in (signal.SIGTERM, signal.SIGINT):
        signal.signal(number, interrupted)
    print(f'Running pid {child.pid}, deadline {seconds}s; logs: {prefix}', flush=True)
    try:
        status = child.wait(timeout=seconds)
    except subprocess.TimeoutExpired:
        print('Deadline reached; collecting stacks and terminating this process group.', flush=True)
        try:
            with prefix.with_suffix('.stacks.txt').open('w') as stacks:
                subprocess.run(['gdb', '-p', str(child.pid), '-batch', '-ex', 'set pagination off', '-ex', 'thread apply all bt'],
                               stdout=stacks, stderr=subprocess.STDOUT, timeout=15)
        except (OSError, subprocess.TimeoutExpired) as error:
            print(f'Stack capture: {error}', flush=True)
        stop_group(child)
        status = 124
    print(f'Exit status: {status}', flush=True)
    print(prefix.with_suffix('.stderr.txt').read_text()[-3000:], flush=True)
    sys.exit(status if status >= 0 else 128 - status)
