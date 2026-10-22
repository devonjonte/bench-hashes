"""Linux ownership checks: status preservation and termination of descendants.

Usage: python3 test-run-bounded.py SUPERVISOR EVIDENCE_DIRECTORY
This tests liveness, with no benchmark speed measurements.
"""
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import time
import unittest

SUPERVISOR = Path(sys.argv[1]).resolve()
EVIDENCE = Path(sys.argv[2]).resolve()
sys.argv = sys.argv[:1]
EVIDENCE.mkdir(parents=True, exist_ok=True)


def running(pid):
    try:
        return Path(f'/proc/{pid}/stat').read_text().rsplit(')', 1)[1].split()[0] != 'Z'
    except FileNotFoundError:
        return False


class OwnershipTests(unittest.TestCase):
    def check_case(self, name, action, expected, interrupt=None, seconds=5):
        prefix = EVIDENCE / name
        command = ("import json,os,signal,subprocess,time; "
                   "p=subprocess.Popen(['sleep','120']); "
                   "print(json.dumps([os.getpid(),p.pid]),flush=True); " + action)
        proc = subprocess.Popen([sys.executable, str(SUPERVISOR), str(seconds), str(prefix),
                                 sys.executable, '-u', '-c', command],
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        ids = None
        clean = False
        try:
            if interrupt is not None:
                for _ in range(500):
                    f = prefix.with_suffix('.stdout.txt')
                    if f.exists() and f.read_text().endswith('\n'):
                        break
                    self.assertIsNone(proc.poll(), 'supervisor exited before readiness')
                    time.sleep(0.01)
                else:
                    self.fail('job readiness deadline')
                proc.send_signal(interrupt)
            out, err = proc.communicate(timeout=25)
            (EVIDENCE / (name + '-supervisor.txt')).write_text(out + err)
            self.assertEqual(proc.returncode, expected, out + err)
            ids = json.loads(prefix.with_suffix('.stdout.txt').read_text())
            for _ in range(100):
                if not any(running(pid) for pid in ids):
                    clean = True
                    break
                time.sleep(0.01)
            self.assertTrue(clean, f'leader/descendant still running: {ids}')
        finally:
            if proc.poll() is None:
                proc.kill()
                proc.communicate(timeout=5)
            if not clean:
                f = prefix.with_suffix('.stdout.txt')
                if ids is None and f.exists() and f.read_text().strip():
                    ids = json.loads(f.read_text())
                if ids is not None:
                    try:
                        os.killpg(ids[0], signal.SIGKILL)
                    except ProcessLookupError:
                        pass

    def test_success_cleans_descendant(self):
        self.check_case('success', 'pass', 0)

    def test_failure_keeps_status_and_cleans_descendant(self):
        self.check_case('failure', 'raise SystemExit(7)', 7)

    def test_signaled_leader_keeps_status(self):
        self.check_case('signaled', 'os.kill(os.getpid(), signal.SIGTERM)', 143)

    def test_deadline_cleans_group(self):
        self.check_case('deadline', 'time.sleep(120)', 124, seconds=1)

    def test_interrupt_cleans_group(self):
        self.check_case('interrupt', 'time.sleep(120)', 130, signal.SIGINT)

    def test_terminate_cleans_group(self):
        self.check_case('terminate', 'time.sleep(120)', 143, signal.SIGTERM)


if __name__ == '__main__':
    unittest.main(verbosity=2)
