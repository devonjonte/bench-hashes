"""tools/samples.py reads a v10 file's samples, CPUs and core counts, and
stops on a row whose CPUs or counts don't match its samples."""
import os
import tempfile
import unittest

import samples

HEAD = samples.VERSION + "\n# machine: test\n" + samples.COLUMNS + "\n"
ROW = "blake3-servil-st\tsolo\tManyMessages\t64\tmessage\t{ns}\t1,2\t-\t-\t{cores}\t{cpus}\n"


def run(rows):
    with tempfile.NamedTemporaryFile("w", suffix=".tsv", delete=False) as f:
        f.write(HEAD + rows)
    try:
        return samples.read(f.name)
    finally:
        os.unlink(f.name)


class Read(unittest.TestCase):
    def test_samples_cpus_and_counts(self):
        r = run(ROW.format(ns="300/64,200/64", cores="300:1290:1700:40:3:0:0:0:0:0,200:860:1130:30:2:0:0:0:0:0", cpus="9,42"))
        key = ("blake3-servil-st", "solo", "ManyMessages", "64")
        self.assertEqual(r.cells[key], [(300, 64), (200, 64)])
        self.assertEqual(r.cpus[key], [9, 42])
        self.assertEqual(r.cores[key], [(300, 1290, 1700, 40, 3, 0, 0, 0, 0, 0), (200, 860, 1130, 30, 2, 0, 0, 0, 0, 0)])
        self.assertEqual(samples.mean_ps(r.cells[key]), 3906)

    def test_none_where_the_platform_names_none(self):
        r = run(ROW.format(ns="300/64", cores="-", cpus="-"))
        key = ("blake3-servil-st", "solo", "ManyMessages", "64")
        self.assertIsNone(r.cpus[key])
        self.assertIsNone(r.cores[key])

    def test_a_cpu_or_count_short_of_the_samples_stops_it(self):
        with self.assertRaises(AssertionError):
            run(ROW.format(ns="300/64,200/64", cores="-", cpus="9"))
        with self.assertRaises(AssertionError):
            run(ROW.format(ns="300/64,200/64", cores="300:1290:0:0", cpus="-"))


if __name__ == "__main__":
    unittest.main()
