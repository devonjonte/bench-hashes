#!/usr/bin/env pypy3
"""Collector accounting and Rust-output summarization contract tests; no timing."""
import csv
import importlib.util
from pathlib import Path
import tempfile
import unittest


def module(name):
    spec = importlib.util.spec_from_file_location(name, Path(__file__).with_name(name + '.py'))
    m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    return m


collector = module('run-current-rust-controls')
analyzer = module('analyze-current-rust-controls')


class Contracts(unittest.TestCase):
    def fixture(self, folder, change=None):
        accounts, traces = [], []
        for algorithm in ['sha256', 'blake3-servil-st']:
            for length in [64, 2048, 102400]:
                accounts.append({'contender': algorithm, 'length': length, 'measured_batches': 2,
                    'blocks_per_batch': 10, 'hashes_per_block': 106, 'calls_per_batch': 1000,
                    'completed_including_calibration': 3180})
                for sample in range(2):
                    traces.append({'contender': algorithm, 'length': length, 'sample': sample,
                        'blocks': 10, 'calls': 1000, 'hashes_per_block': 106,
                        'completed_hashes': 1060, 'wall_ns': 2000000})
        if change: change(accounts, traces)
        for name, rows in [('accounting.csv', accounts), ('clocks.csv', traces)]:
            with (folder / name).open('w') as f:
                w = csv.DictWriter(f, fieldnames=list(rows[0])); w.writeheader(); w.writerows(rows)

    def check(self, change=None):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp); self.fixture(folder, change); collector.accounting(folder)

    def test_valid(self):
        self.check()

    def test_calibration_count(self):
        with self.assertRaises(AssertionError):
            self.check(lambda a, t: a[0].update(completed_including_calibration=2120))

    def test_duplicate_batch(self):
        with self.assertRaises(AssertionError):
            self.check(lambda a, t: t[1].update(sample=0))

    def test_completed_work(self):
        with self.assertRaises(AssertionError):
            self.check(lambda a, t: t[0].update(completed_hashes=1059))

    def test_units(self):
        with self.assertRaises(AssertionError):
            self.check(lambda a, t: t[0].update(calls=999))

    def test_rust_text_only(self):
        text = 'blake3-servil-st|solo|PositiveWorkControl|64 B: 42.100 -> 44.200  [fast x1.050, slow x1.050, slow share 0% -> 0%]\n'
        self.assertEqual(analyzer.ratios(text), {'blake3-servil-st|solo|PositiveWorkControl|64 B': 1050})


if __name__ == '__main__':
    unittest.main()
