#!/usr/bin/env python3
"""Targeted assertion & handoff mutants for 021bed3d + daef4ba8 (#455 review).
cargo-mutants skips assert!() arguments; this tests every new assertion clause one by one."""
from pathlib import Path
import subprocess

CASES = [
    # (name, file, old, new, crate_dir, test_filter)
    ("halves_bytes_or", "src/throughput.rs",
     "assert!(left.place == a && right.place == b,",
     "assert!(left.place == a || right.place == b,", ".", "pool_halves"),
    ("halves_bytes_left_only", "src/throughput.rs",
     "assert!(left.place == a && right.place == b,",
     "assert!(left.place == a,", ".", "pool_halves"),
    ("halves_bytes_right_only", "src/throughput.rs",
     "assert!(left.place == a && right.place == b,",
     "assert!(right.place == b,", ".", "pool_halves"),
    ("subtree_halves_level_zero", "src/throughput.rs",
     'assert!(level > 0, "a subtree of one chunk has no halves");\n',
     "", ".", "halves"),
    ("subtree_halves_place_check", "src/throughput.rs",
     "        subtree_place(level, index, input.len());\n        assert!(level > 0,",
     "        assert!(level > 0,", ".", "halves"),
    ("subtree_halves_right_place", "src/throughput.rs",
     "[Cv { value: left, place: a }, Cv { value: right, place: b }]",
     "[Cv { value: left, place: a }, Cv { value: right, place: a }]", ".", "halves"),
    ("cohort_plain_flags", "src/each.rs",
     'assert!(alike.len() == 1 || hasher.core.chunk_state.flags == 0, "only plain hashers share a cohort");\n',
     "", ".", "a_shared_cohort_refuses_a_keyed_stage"),
    ("cvstack_equal_row_widths", "src/hasher.rs",
     'assert_eq!(n, right.len(), "two rows merge at one width");\n',
     "", ".", "unequal_rows_stop_before_copying"),
    ("one_block_groups_len_guard", "src/many.rs",
     'assert!(len <= BLOCK_LEN, "an independent short message fits in one block");\n',
     "", ".", "an_independent_batch_refuses_a_multiblock_length"),
    ("pipeline_fold_swapped", "threads/src/pipeline.rs",
     "stack[used - 2] = tree.parent_cv(&stack[used - 2], &stack[used - 1]);",
     "stack[used - 2] = stack[used - 2];", "threads", "the_piece_fold"),
    ("pipeline_fold_len", "threads/src/pipeline.rs",
     "tree.root_hash(first, &last, len)",
     "tree.root_hash(first, &last, (1024 << first.level()) + last.len())", "threads", "the_piece_fold_checks_the_submitted_length"),
    ("pipeline_room_bounds", "threads/src/pipeline.rs",
     'assert!((room_idx as usize) < rooms.count && offset <= ROOM_LEN && len <= ROOM_LEN - offset, "a piece stays within its room");\n',
     "", "threads", "pipeline"),
    ("pipeline_multi_piece_idx", "threads/src/pipeline.rs",
     'assert!(piece_idx < desc.pieces, "the action names a piece of its submission");\n',
     "", "threads", "pipeline"),
]

for name, rel, old, new, crate_dir, filt in CASES:
    p = Path(rel)
    orig = p.read_text()
    assert orig.count(old) == 1, (name, orig.count(old))
    p.write_text(orig.replace(old, new))
    try:
        r = subprocess.run(
            ["cargo", "nextest", "run", "--cargo-quiet", "--release", "--lib", "--tests", "-E", f"test({filt})"],
            cwd=crate_dir, capture_output=True, text=True, timeout=180
        )
        verdict = "SURVIVED" if r.returncode == 0 else "caught"
        print(f"{name:32} {verdict}")
    finally:
        p.write_text(orig)
