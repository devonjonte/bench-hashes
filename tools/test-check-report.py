#!/usr/bin/env python3
"""Run with BENCH_SPEED_RULES=/path/to/the/pinned/fork/tools/speeds.py.

These synthetic records check completeness as well as numerical agreement.
"""
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

CHECKER = Path(__file__).with_name('check-report.py')
RULES = Path(os.environ.get('BENCH_SPEED_RULES', Path(__file__).resolve().parents[2] / 'tools/speeds.py'))


class ReportCompleteness(unittest.TestCase):
    def check(self, rows):
        with tempfile.TemporaryDirectory() as directory:
            record = Path(directory)
            (record / 'bench-hashes.samples.tsv').write_text(
                '# bench-hashes samples v4\n# power: test\n# load: quiet: test\n'
                '# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): 0-1000:0:0\n'
                'contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n'
                'a\tsolo\tOneMessage\t64 B\tB\t64/64,64/64\t0,1\n'
                'a\tsolo\tOneMessage\t128 B\tB\t128/128,128/128\t0,1\n'
                'b\tsolo\tOneMessage\t64 B\tB\t128/64,128/64\t0,1\n'
                'b\tsolo\tOneMessage\t128 B\tB\t256/128,256/128\t0,1\n')
            (record / 'bench-hashes.result.txt').write_text(
                'SOLO: test\n\n  A message in one buffer, after other work (ns/B)\n'
                '  size A B\n' + rows + '\nKERNELS\n')
            return subprocess.run([sys.executable, str(CHECKER), str(record), '--rules', str(RULES)],
                                  capture_output=True, text=True)

    def test_complete_report(self):
        result = self.check('  64 B 1.000 2.000\n  128 B 1.000 2.000\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('all 4 cells', result.stdout)

    def test_missing_row(self):
        result = self.check('  64 B 1.000 2.000\n')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('report omitted 2 sampled cells', result.stderr)

    def test_duplicate_row(self):
        result = self.check('  64 B 1.000 2.000\n  64 B 1.000 2.000\n  128 B 1.000 2.000\n')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('duplicate report cell', result.stderr)

    def test_wrong_number(self):
        result = self.check('  64 B 1.001 2.000\n  128 B 1.000 2.000\n')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('report shows 1.001', result.stdout)


if __name__ == '__main__':
    unittest.main()
