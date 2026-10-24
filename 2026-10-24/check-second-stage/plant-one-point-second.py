#!/usr/bin/env python3
"""With check's second stage (bench-hashes #66): the one-point planted slowdown, run through `bench-hashes check` at each
rate in turn: hash() of exactly 1536 bytes repeats a whole call whenever a
debt of RATE percent a call reaches one call (the October 20 controls'
plant, at one input length). RATE 0 is the A/A: the plant's line runs and
does nothing. One check at a time, each against HEAD."""
import pathlib
import re
import signal
import subprocess
import sys

# A stop (the supervisor's SIGTERM) still restores src/lib.rs, by the finally below.
signal.signal(signal.SIGTERM, lambda *_: sys.exit(143))

line = pathlib.Path("/home/agent/BLAKE3-line")
out = pathlib.Path("/home/agent/bench-hashes-validation/plant-one-point-second")
lib = line / "src/lib.rs"
original = lib.read_text()
target = "pub fn hash(input: &[u8]) -> Hash {\n    hash_serial(input, IV, 0)\n}\n"
assert target in original, "hash()'s body as expected"
out.mkdir(exist_ok=True)
for run, rate in enumerate(int(r) for r in sys.argv[1:]):
    planted = f"""pub fn hash(input: &[u8]) -> Hash {{
    if input.len() == 1536 {{
        plant(input);
    }}
    hash_serial(input, IV, 0)
}}

/// A planted slowdown (bench-hashes-validation/plant-one-point.py): a whole
/// call again whenever a debt of {rate}% a call reaches one call.
#[inline(never)]
fn plant(input: &[u8]) {{
    use core::sync::atomic::{{AtomicU32, Ordering}};
    static DEBT: AtomicU32 = AtomicU32::new(0);
    if DEBT.fetch_add({rate}, Ordering::Relaxed) + {rate} >= 100 {{
        DEBT.fetch_sub(100, Ordering::Relaxed);
        core::hint::black_box(hash_serial(core::hint::black_box(input), IV, 0));
    }}
}}
"""
    lib.write_text(original.replace(target, planted))
    try:
        done = subprocess.run(["./target/release/bench-hashes", "check", "--keep", str(out / f"run{run}-rate-{rate}-runs")],
                              cwd=line / "bench-hashes", capture_output=True, text=True)
    finally:
        lib.write_text(original)
    (out / f"run{run}-rate-{rate}.stdout.txt").write_text(done.stdout)
    (out / f"run{run}-rate-{rate}.stderr.txt").write_text(done.stderr)
    chosen = re.search(r"^check: (\d+) cells execute", done.stderr, re.M)
    slower = re.findall(r"^\s+SLOWER (.+?): ", done.stdout, re.M)
    suspects = re.search(r"^check: a second stage for (\d+) suspects", done.stderr, re.M)
    print(f"rate {rate}%\texit {done.returncode}\t{chosen.group(1) if chosen else '?'} cells chosen\t{suspects.group(1) if suspects else 0} suspects\t{len(slower)} slower: {', '.join(slower)}", flush=True)
