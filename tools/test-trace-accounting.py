"""Synthetic controls for the offline trace/accounting audit."""
import copy
import importlib.util
import os
from pathlib import Path
import unittest

HERE = Path(__file__).parent

def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

checker = load('trace_accounting', HERE / 'check-trace-accounting.py')
samples = load('shared_samples', Path(os.environ['BENCH_SAMPLES_READER']))


def fixture():
    # Two explicit rounds: literal two-participant orders [a,b], [b,a].
    # The two selected points have global indices 0 (OneMessage 64 B)
    # and 1 (LentBatches 16), so their round-rotation offsets are 0/1,
    # respectively 1/0. Nonstop runs before busy.
    roster = ['sha256', 'blake3-servil-st']
    rows = []
    for case, size, offsets in [('LentBatches', 1024, [1, 0]), ('OneMessage', 64, [0, 1])]:
        for r in range(2):
            order = roster if r == 0 else roster[::-1]
            for p, a in enumerate(order):
                rows.append(dict(round=str(r), position=str(offsets[r] * 2 + p), contender=a,
                    size_bytes=str(size), iterations='2', wall_ns='128', use_case=case,
                    duo_ns='256' if case == 'LentBatches' else '',
                    copy0_ns='192' if case == 'LentBatches' else '',
                    copy1_ns='256' if case == 'LentBatches' else '',
                    scenario='solo and shared' if case == 'LentBatches' else 'solo'))
    header = ('# bench-hashes samples v4\n# power: mains\n# load: quiet\n# rounds: 2\n'
              '# contenders: --contenders sha256,blake3-servil-st\n'
              'contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n')
    for a in roster:
        header += f'{a}\tsolo\tOneMessage\t64 B\tB\t128/128,128/128\t0,1\n'
        header += f'{a}\tsolo\tLentBatches\t16\tmsg\t128/32,128/32\t0,1\n'
        header += f'{a}\tshared\tLentBatches\t16\tmsg\t192/32,256/32,192/32,256/32\t0,0,1,1\n'
    return samples.read(header), rows

class TraceAccounting(unittest.TestCase):
    def test_known_complete_design_and_counts(self):
        run, rows = fixture()
        result = checker.check(run, rows, explicit_rounds=True)
        self.assertEqual(result['complete_balanced_points'], 2)
        self.assertEqual(result['trace_dispatches'], 8)
        self.assertEqual(result['sample_cells'], 6)

    def test_rejects_corrupt_trace_and_missing_dispatch(self):
        for field, value in [('iterations', '1'), ('wall_ns', '129'), ('position', '5')]:
            run, rows = fixture()
            rows[0][field] = value
            with self.subTest(field=field), self.assertRaises(AssertionError):
                checker.check(run, rows, True)
        run, rows = fixture()
        with self.assertRaises(AssertionError):
            checker.check(run, rows[:-1], True)

    def test_rejects_sample_corruption_even_if_ratio_unchanged(self):
        run, rows = fixture()
        key = ('sha256', 'solo', 'OneMessage', '64 B')
        run.measured[key][0] = (256, 256)  # ratio is still exactly 1
        self.assertEqual(run.cells[key][0], 1)
        with self.assertRaisesRegex(AssertionError, 'exact wall ns'):
            checker.check(run, rows, True)

    def test_rejects_wrong_participant_order(self):
        run, rows = fixture()
        altered = copy.deepcopy(rows)
        altered[0], altered[1] = altered[1], altered[0]
        with self.assertRaises(AssertionError):
            checker.check(run, altered, True)

if __name__ == '__main__':
    unittest.main()
