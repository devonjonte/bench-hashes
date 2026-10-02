#!/usr/bin/env pypy3
"""Restore the campaign deadline after the interactive tool call was interrupted."""
import os
from pathlib import Path
import signal
import subprocess
import threading

ROOT = 76104
folder = Path(__file__).parent
stop = threading.Event()

def alive():
    path = Path('/proc/%d/stat' % ROOT)
    try:
        return path.read_text().split(') ', 1)[1].split()[0] != 'Z'
    except FileNotFoundError:
        return False

try:
    for _ in range(840):
        if not alive():
            (folder / 'reattached-deadline-status.txt').write_text('Campaign ended before restored deadline. Per-check supervisors retained.\n')
            break
        stop.wait(1)
    else:
        rows = [tuple(map(int, line.split())) for line in subprocess.check_output(['ps','-eo','pid=,ppid=,pgid='],text=True).splitlines()]
        descendants = {ROOT}
        while True:
            added = {pid for pid, parent, group in rows if parent in descendants} - descendants
            if not added: break
            descendants |= added
        groups = {group for pid, parent, group in rows if pid in descendants} - {os.getpgrp()}
        for sig in [signal.SIGTERM, signal.SIGKILL]:
            for group in groups:
                try: os.killpg(group,sig)
                except ProcessLookupError: pass
            if sig == signal.SIGTERM: stop.wait(5)
        (folder / 'reattached-deadline-status.txt').write_text('Restored campaign deadline exceeded; all observed descendant process groups terminated. Preserve partial attempts.\n')
except BaseException as error:
    (folder / 'reattached-deadline-error.txt').write_text(repr(error)+'\n')
    raise
