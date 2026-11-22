#!/bin/sh
# Declared before running (November 22, 2026): BLAKE3 PR #484, review finding 9.
# Question: does TreeHasher::try_hash_group_on (separately borrowed short
# messages, the Pipeline's member groups) take longer at the candidate
# (NEW, StackVec in place of arrayvec) than at next (OLD)? The review
# measured 2 x 64 B at +5.0% on the candidate's first form.
# Method: one probe program built against each commit; 8 pairs of runs,
# the order alternating (old new, new old, ...), each run pinned to CPU 2,
# each cell the median of 15 rounds of about 20 ms. A probe: Instant
# timing, no load windows, no cycle counts.
set -eu
export PATH="$HOME/.cargo/bin:$PATH" CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
O=$PWD
W="$HOME/work/group-484-probe"
rm -rf "$W"
mkdir -p "$W/src"
cat > "$W/src/main.rs" <<'__PROBE_EOF__'
//! BLAKE3 PR #484, review finding 9: the group call on separately borrowed
//! short messages (`TreeHasher::try_hash_group_on`), timed per group.
//! Built once against each library commit; prints ns per group for each cell.
use blake3_servil_core::thread_support::Platform;
use blake3_servil_core::throughput::TreeHasher;
use std::hint::black_box;
use std::time::Instant;

#[inline(never)]
pub fn group(tree: &TreeHasher, platform: Platform, messages: &[&[u8]], out: &mut [[u8; 32]]) -> bool {
    tree.try_hash_group_on(platform, messages.len(), |i| messages[i], |i, digest| out[i] = digest)
}

fn main() {
    blake3_servil_core::initialize();
    let platform = Platform::detect();
    let tree = TreeHasher::new(blake3_servil_core::Mode::Plain);
    let rounds: usize = std::env::args().nth(1).map_or(15, |a| a.parse().unwrap());
    let mut backing = vec![0u8; 128 * 1024 + 64];
    let mut x = 0x9E37_79B9_7F4A_7C15u64;
    for b in &mut backing {
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        *b = x as u8;
    }
    let cells = [(2usize, 64usize), (3, 64), (4, 64), (8, 64), (16, 64), (64, 64), (2, 128), (2, 1024), (16, 1024)];
    for (count, len) in cells {
        let messages: Vec<&[u8]> = (0..count).map(|i| &backing[i * 1024..][..len]).collect();
        let mut out = vec![[0u8; 32]; count];
        assert!(group(&tree, platform, &messages, &mut out));
        for (i, m) in messages.iter().enumerate() {
            assert_eq!(out[i], *blake3_servil_core::convenience::hash(m).as_bytes());
        }
        // About 20 ms a round.
        let t0 = Instant::now();
        let mut n = 0u64;
        while t0.elapsed().as_millis() < 20 {
            for _ in 0..1000 {
                black_box(group(&tree, platform, black_box(&messages), &mut out));
            }
            n += 1000;
        }
        let iters = n;
        let mut times = Vec::with_capacity(rounds);
        for _ in 0..rounds {
            let t = Instant::now();
            for _ in 0..iters {
                black_box(group(&tree, platform, black_box(&messages), &mut out));
            }
            times.push(t.elapsed().as_nanos() as f64 / iters as f64);
        }
        times.sort_by(f64::total_cmp);
        println!("{count}x{len}\t{:.3}\t{:.3}", times[rounds / 2], times[0]);
    }
}
__PROBE_EOF__
fetch() { # name repository commit
    git clone -q --filter=blob:none --no-checkout "$2" "$W/$1-lib"
    git -C "$W/$1-lib" fetch -q origin "$3"
    git -C "$W/$1-lib" checkout -q --detach "$3"
    mkdir -p "$W/$1"
    cat > "$W/$1/Cargo.toml" <<EOF
[package]
name = "group-probe-$1"
version = "0.0.0"
edition = "2024"
publish = false

[[bin]]
name = "group-probe-$1"
path = "../src/main.rs"

[dependencies]
blake3-servil-core = { path = "../$1-lib" }

[workspace]
EOF
    (cd "$W/$1" && cargo build --release > "$O/build-$1.txt" 2>&1)
}
fetch old https://github.com/servil-software-factory/BLAKE3 0509bc84fc0a7e54a069c582b29f59cacd7a74ca
fetch new https://github.com/devonjonte/BLAKE3 908a50294321fd389cd9b7d3c444a4f5c8beaf71
{ uname -srm; rustc -V; lscpu | grep -m1 'Model name'; echo "old 0509bc84fc0a7e54a069c582b29f59cacd7a74ca"; echo "new 908a50294321fd389cd9b7d3c444a4f5c8beaf71"; } > "$O/provenance.txt"
for pair in 1 2 3 4 5 6 7 8; do
    if [ $((pair % 2)) = 1 ]; then order="old new"; else order="new old"; fi
    for v in $order; do
        taskset -c 2 "$W/$v/target/release/group-probe-$v" 15 > "$O/pair-$pair-$v.tsv"
    done
done
cat "$O/provenance.txt"
for f in "$O"/pair-*.tsv; do echo "== $f"; cat "$f"; done
rm -rf "$W"
