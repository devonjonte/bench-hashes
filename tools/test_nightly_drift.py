#!/usr/bin/env python3
"""Unit tests for tools/nightly_drift.py."""

import tempfile
import unittest
from pathlib import Path

import nightly_drift as nd

SHA_A = "e1966b498bc769db3d51451a4ddc8188a19ed593"
SHA_B = "690d2f8726255f777d9e443e6d3767c0a0416b48"
BENCH_1 = "8acc6df709d71172b7f40fa48a0d532cb75ecf88"
BENCH_2 = "25cf8885cd1af30bdea4186f48fa931f16b916dd"


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

    def test_run_name_depends_on_bench_scope_and_layouts(self):
        n1 = nd.run_name(SHA_A, SHA_B, bench_sha=BENCH_1, cells="all", layouts=None)
        n2 = nd.run_name(SHA_A, SHA_B, bench_sha=BENCH_2, cells="all", layouts=None)
        n3 = nd.run_name(SHA_A, SHA_B, bench_sha=BENCH_1, cells="blake3-servil-mt|64 B", layouts=None)
        n4 = nd.run_name(SHA_A, SHA_B, bench_sha=BENCH_1, cells="all", layouts=8)
        self.assertTrue(n1.startswith(f"drift-{SHA_A[:8]}-{SHA_B[:8]}-"))
        self.assertEqual(len({n1, n2, n3, n4}), 4)

    def test_already_ran_requires_answered_verdict_and_matching_experiment(self):
        with tempfile.TemporaryDirectory() as td:
            inbox = Path(td)
            key = nd.experiment_key(
                bench_sha=BENCH_1, base_sha=SHA_A, target_sha=SHA_B, cells="all", layouts=None
            )
            name = nd.run_name(SHA_A, SHA_B, bench_sha=BENCH_1, cells="all", layouts=None)
            run_dir = inbox / "x86-9700x" / name
            run_dir.mkdir(parents=True)

            # Missing summary -> not answered.
            self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B, bench_sha=BENCH_1))

            # Abstention (exit 2) preserves evidence without counting as answered.
            (run_dir / "summary.md").write_text(
                f"- Experiment: `{key}`\n- Verdict: **abstained** (exit `2`)\n",
                encoding="utf-8",
            )
            self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B, bench_sha=BENCH_1))

            # Stopped (exit 101) also does not count as answered.
            (run_dir / "summary.md").write_text(
                f"- Experiment: `{key}`\n- Verdict: **stopped** (exit `101`)\n",
                encoding="utf-8",
            )
            self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B, bench_sha=BENCH_1))

            # Exit 0 or 1 counts as answered for that exact experiment only.
            for rc in (0, 1):
                (run_dir / "summary.md").write_text(
                    f"- Experiment: `{key}`\n- Verdict: **done** (exit `{rc}`)\n",
                    encoding="utf-8",
                )
                self.assertTrue(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B, bench_sha=BENCH_1))
                # Different bench SHA, scope, or layout count is a distinct question.
                self.assertFalse(nd.already_ran(inbox, "x86-9700x", SHA_A, SHA_B, bench_sha=BENCH_2))
                self.assertFalse(
                    nd.already_ran(
                        inbox, "x86-9700x", SHA_A, SHA_B, bench_sha=BENCH_1, layouts=8
                    )
                )

    def test_render_host_script_pins_bench_sha_verifies_head_and_reads_stage2(self):
        script = nd.render_host_script(
            bench_url=nd.DEFAULT_BENCH_URL,
            bench_sha=BENCH_1,
            fork_url=nd.DEFAULT_FORK_URL,
            base_sha=SHA_A,
            target_sha=SHA_B,
            cells="all",
            layouts=8,
        )
        self.assertIn(f"checkout --quiet --force --detach {BENCH_1}", script)
        self.assertIn(f'if [ "$ACTUAL_BENCH" != "{BENCH_1}" ]', script)
        self.assertIn(f'if [ "$ACTUAL_TARGET" != "{SHA_B}" ]', script)
        self.assertIn(f"--against {SHA_A}", script)
        self.assertIn(f"--new {SHA_B}", script)
        self.assertIn("--cells all --layouts 8 --when-quiet", script)
        self.assertIn('"$KEEP"/second/run-*-old.tsv', script)
        self.assertIn("Deciding stage: $DECIDING_STAGE", script)
        with self.assertRaises(ValueError):
            nd.render_host_script(
                bench_url=nd.DEFAULT_BENCH_URL,
                bench_sha="next",
                fork_url=nd.DEFAULT_FORK_URL,
                base_sha=SHA_A,
                target_sha=SHA_B,
            )


if __name__ == "__main__":
    unittest.main()
