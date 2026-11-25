#!/usr/bin/env python3
"""Unit tests for tools/nightly_drift.py."""

import tempfile
import unittest
from pathlib import Path

import nightly_drift as nd

SHA_A = "e1966b498bc769db3d51451a4ddc8188a19ed593"
SHA_B = "690d2f8726255f777d9e443e6d3767c0a0416b48"


class NightlyDriftTests(unittest.TestCase):
    def test_validate_sha_accepts_40_hex_and_rejects_short_or_dirty(self):
        self.assertEqual(nd.validate_sha(SHA_A, "base"), SHA_A)
        with self.assertRaises(ValueError):
            nd.validate_sha(SHA_A[:12], "base")
        with self.assertRaises(ValueError):
            nd.validate_sha("Z" * 40, "base")

    def test_parse_ls_remote_extracts_exact_ref(self):
        sample = f"{SHA_A}\trefs/heads/main\n{SHA_B}\trefs/heads/next\n"
        self.assertEqual(nd.parse_ls_remote(sample, "refs/heads/main"), SHA_A)
        self.assertEqual(nd.parse_ls_remote(sample, "refs/heads/next"), SHA_B)
        with self.assertRaises(RuntimeError):
            nd.parse_ls_remote(sample, "refs/heads/missing")

    def test_run_name_is_deterministic_from_commit_hashes(self):
        self.assertEqual(nd.run_name(SHA_A, SHA_B), f"drift-{SHA_A[:8]}-{SHA_B[:8]}")

    def test_already_ran_deduplicates_by_completed_summary(self):
        with tempfile.TemporaryDirectory() as td:
            inbox = Path(td)
            self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B))
            run_dir = inbox / "x86-9700x" / nd.run_name(SHA_A, SHA_B)
            run_dir.mkdir(parents=True)
            # Without summary.md, an incomplete folder does not count as done.
            self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B))
            (run_dir / "summary.md").write_text("# done\n", encoding="utf-8")
            self.assertTrue(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B))
            # A different target commit is not deduplicated.
            self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_A))

    def test_render_host_script_contains_exact_commits_check_and_compare(self):
        script = nd.render_host_script(
            bench_url=nd.DEFAULT_BENCH_URL,
            bench_ref="next",
            fork_url=nd.DEFAULT_FORK_URL,
            base_sha=SHA_A,
            target_sha=SHA_B,
            cells="all",
            layouts=8,
        )
        self.assertIn(f"--against {SHA_A}", script)
        self.assertIn(f"--new {SHA_B}", script)
        self.assertIn("--cells all --layouts 8 --when-quiet", script)
        self.assertIn('compare --markdown "$KEEP"/run-*-old.tsv -- "$KEEP"/run-*-new.tsv', script)
        with self.assertRaises(ValueError):
            nd.render_host_script(
                bench_url=nd.DEFAULT_BENCH_URL,
                bench_ref="next",
                fork_url=nd.DEFAULT_FORK_URL,
                base_sha=SHA_A,
                target_sha=SHA_B,
                layouts=2,
            )


if __name__ == "__main__":
    unittest.main()
