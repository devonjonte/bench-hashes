"""Fixed accounting anchors and deliberately corrupted work-control records."""
import importlib.util
import os
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('work_check', Path(__file__).with_name('check-work-control.py'))
checker = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checker)

SAMPLES = ('# bench-hashes samples v4\n# power: diagnostic\n# load: quiet\n'
           '# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): 0-1000:0:0\n'
           '# work control version: 2\n# logical requests per block: 100\n'
           '# subject extra per100: 3\n# control extra per100: 0\n'
           'contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n'
           'a\tsolo\tPositiveWorkControl\t64 B\tcall\t128/400,256/400\t0,1\n')
ACCOUNTING = ('contender,length,hashes_per_block,blocks_per_batch,calls_per_batch,measured_batches,completed_including_calibration\n'
              'a,64,103,4,400,2,1236\n')
TRACE = ('contender,length,sample,blocks,calls,hashes_per_block,completed_hashes,wall_ns\n'
         'a,64,0,4,400,103,412,128\na,64,1,4,400,103,412,256\n')


class WorkAccounting(unittest.TestCase):
    def check(self, samples=SAMPLES, accounting=ACCOUNTING, trace=TRACE):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp)
            for filename, content in [('samples.tsv', samples), ('accounting.csv', accounting), ('clocks.csv', trace)]:
                (folder / filename).write_text(content)
            return checker.check(folder, Path(os.environ['BENCH_SAMPLE_READER']))

    def test_valid_anchor(self):
        self.assertEqual(self.check()['completed_including_calibration'], 1236)

    def test_rejects_ratio_preserving_raw_corruption(self):
        with self.assertRaisesRegex(AssertionError, 'recorded ns/work'):
            self.check(samples=SAMPLES.replace('128/400,256/400', '256/800,512/800'))

    def test_rejects_changed_calibration_completion(self):
        with self.assertRaisesRegex(AssertionError, 'including calibration'):
            self.check(accounting=ACCOUNTING.replace(',1236\n', ',1237\n'))

    def test_rejects_wrong_declared_effect(self):
        with self.assertRaisesRegex(AssertionError, 'declared extra work'):
            self.check(samples=SAMPLES.replace('extra per100: 3', 'extra per100: 6'))

    def test_rejects_old_accounting_contract(self):
        with self.assertRaisesRegex(AssertionError, 'contract v2'):
            self.check(samples=SAMPLES.replace('version: 2', 'version: 1'))

    def test_rejects_duplicate_trace_batch(self):
        with self.assertRaisesRegex(AssertionError, 'one trace row'):
            self.check(trace=TRACE + 'a,64,1,4,400,103,412,256\n')


if __name__ == '__main__':
    unittest.main()
