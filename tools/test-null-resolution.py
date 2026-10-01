"""Fixed null-envelope anchors; the speed implementation stays shared."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


class NullResolution(unittest.TestCase):
    def metric(self, values):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            manifest = {'sha256': 'same', 'blocks': [['block', None]],
                        'runs': [{'sha256': 'same', 'exit': 0} for _ in values]}
            (root / 'manifest.json').write_text(json.dumps(manifest))
            for name, value in zip(['old-1', 'new-1', 'new-2', 'old-2'], values):
                path = root / 'block' / name
                path.mkdir(parents=True)
                (path / 'samples.tsv').write_text(
                    '# bench-hashes samples v4\n# power: mains power\n# load: quiet\n'
                    '# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): 0-1000:0:0\n'
                    'contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\n'
                    'a\tsolo\tContinuousBatches\t16\tmsg\t' +
                    ','.join([f'{value}/1'] * 24) + '\t' + ','.join(['0'] * 24) + '\n')
            result = subprocess.run(['python3', str(Path(__file__).with_name('assess-null-resolution.py')),
                                     str(root), '--rules', os.environ['BENCH_SPEED_RULES']],
                                    check=True, capture_output=True, text=True)
            return json.loads(result.stdout)

    def test_identical_processes_have_zero_envelope(self):
        result = self.metric([100, 100, 100, 100])
        self.assertEqual(result['cells'][0]['observed_fast_envelope'], '0')
        self.assertIsNone(result['cells'][0]['observed_slow_envelope'])
        self.assertEqual(result['coverage'][0]['unobserved'], 0)

    def test_known_factor_consumes_exact_margin_budget(self):
        cell = self.metric([100, 200, 100, 100])['cells'][0]
        self.assertEqual(cell['observed_fast_envelope'], '1')
        self.assertEqual(cell['fast_margin_budgets'], '100/3')
        self.assertEqual(cell['split_mismatches'], 0)


if __name__ == '__main__':
    unittest.main()
