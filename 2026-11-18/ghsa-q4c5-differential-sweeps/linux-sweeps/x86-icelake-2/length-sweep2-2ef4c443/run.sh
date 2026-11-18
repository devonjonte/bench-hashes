#!/bin/sh
# Declared before running (November 18, 2026, UTC). Question: does any whole-message call of BLAKE3-Servil
# at the 0.10.0 candidate (2ef4c443) give a hash that differs from official BLAKE3 1.8.7 at any length of a
# dense sweep, on this machine's kernels, for several pool sizes? The test (threads/tests/length_sweep.rs,
# written into the checkout below) tries every length to 256 KiB and around each KiB to 4 MiB on one thread,
# and around each KiB from 500 KiB to 16 MiB (more on a wide machine) over the pool; then batches and
# collections at every message length to 4097 bytes and around each block boundary to 70 KiB. One process a pool size:
# the machine's own, then each of SWEEP_THREADS that the machine has CPUs for. A correctness test, no timing.
# It passes when every line reads "0 wrong"; any other count is a finding to report privately.
set -u
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ "${BOUNDED_SWEEP:-}" != yes ]; then
  export BOUNDED_SWEEP=yes
  status=0
  timeout --kill-after=30s 5400s sh "$0" || status=$?
  printf 'SWEEP_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
M="$HOME/work/lib-release-023"
W="$HOME/work/lib-length-sweep"
NEW=2ef4c4431d56ad838f5260a123a8b03d48e00877
set -e
# A machine with no library checkout clones the public repository.
if [ -d "$M" ]; then
  git -C "$M" cat-file -e "$NEW^{commit}" 2> /dev/null || git -C "$M" fetch -q origin
  [ -d "$W" ] || git -C "$M" worktree add -q --detach "$W" "$NEW"
else
  [ -d "$W" ] || git clone -q https://github.com/servil-software-factory/BLAKE3 "$W"
  git -C "$W" cat-file -e "$NEW^{commit}" 2> /dev/null || git -C "$W" fetch -q origin
fi
git -C "$W" checkout -q --detach "$NEW"
test "$(git -C "$W" rev-parse HEAD)" = "$NEW"
{ uname -srm; nproc; grep -m1 'model name' /proc/cpuinfo || true; rustc --version; } > "$O/machine.txt" 2>&1
cat > "$W/threads/tests/length_sweep.rs" <<'RS'
//! Every whole-message call against official BLAKE3 over a dense sweep of
//! lengths: the calls choose kernels, cuts and merges by length and by
//! the machine, and a test of a few lengths can miss a narrow range.
//! A binary of its own: the pool is the process's.
//!
//! LENGTH_SWEEP_THREADS=N starts the pool with N threads (default: the
//! machine's). LENGTH_SWEEP_MIB=N sets the longest multithreaded message
//! (default: 16 MiB, or 1 MiB past 128 KiB a thread where that is more).
//!
//! The reference costs one pass: official BLAKE3's Hasher takes the input
//! a step at a time, and `finalize` reads the hash of the bytes so far.

use blake3_servil::convenience::Hasher;
use blake3_servil::throughput::{self, Batch, Block};
use blake3_servil::{Mode, convenience};

const KIB: usize = 1024;

fn painted(len: usize) -> Vec<Block> {
    let mut blocks = vec![Block([0; 64]); len.div_ceil(64)];
    let mut x = 0x9E37_79B9_7F4A_7C15u64;
    for chunk in Block::bytes_mut(&mut blocks).chunks_mut(8) {
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        chunk.copy_from_slice(&x.to_le_bytes()[..chunk.len()]);
    }
    blocks
}

/// What a sweep found: how many lengths, and those whose hash was wrong.
#[derive(Default)]
struct Found {
    tried: u64,
    wrong: Vec<usize>,
}

impl Found {
    fn see(&mut self, len: usize, right: bool) {
        self.tried += 1;
        if !right {
            self.wrong.push(len);
        }
    }
    fn report(&self, what: &str) -> bool {
        let (first, last) = (self.wrong.first(), self.wrong.last());
        eprintln!("{what}: {} lengths, {} wrong{}", self.tried, self.wrong.len(), if self.wrong.is_empty() { String::new() } else { format!(" (from {first:?} to {last:?} bytes)") });
        self.wrong.is_empty()
    }
}

/// Calls `each(len, the official hash of the first len bytes)` for every length in `lens` (ascending).
fn against_official(mode: Mode, bytes: &[u8], lens: impl Iterator<Item = usize>, mut each: impl FnMut(usize, [u8; 32])) {
    let mut official = match mode {
        Mode::Plain => blake3::Hasher::new(),
        Mode::Keyed(key) => blake3::Hasher::new_keyed(key),
        Mode::DeriveKey(context) => blake3::Hasher::new_derive_key(context),
        _ => unreachable!("the sweep's modes"),
    };
    let mut at = 0;
    for len in lens {
        assert!(len >= at, "ascending lengths");
        official.update(&bytes[at..len]);
        at = len;
        each(len, *official.finalize().as_bytes());
    }
}

/// Whole KiB from `from` to `to`, each with the byte before and after.
fn around_each_kib(from: usize, to: usize, step: usize) -> impl Iterator<Item = usize> {
    (from / KIB..=to / KIB).step_by(step).flat_map(|k| [k * KIB - 1, k * KIB, k * KIB + 1])
}

#[test]
fn every_length_against_official_blake3() {
    let threads = std::env::var("LENGTH_SWEEP_THREADS").ok().map(|t| t.parse::<usize>().expect("LENGTH_SWEEP_THREADS: a count"));
    blake3_servil::initialize_multithreaded(threads.and_then(core::num::NonZeroUsize::new));
    let threads = threads.unwrap_or_else(|| std::thread::available_parallelism().map_or(1, |n| n.get()));
    let longest = std::env::var("LENGTH_SWEEP_MIB").ok().map_or((16 << 20).max((128 * threads + 1024) * KIB), |m| m.parse::<usize>().expect("LENGTH_SWEEP_MIB: a count") << 20);
    eprintln!("a pool of {threads} threads; multithreaded messages to {} KiB", longest / KIB);
    let blocks = painted(longest + KIB);
    let bytes = Block::bytes(&blocks);
    let key = [0x5a; 32];
    let mut ok = true;

    // One thread: every length to 256 KiB, then around each KiB to 4 MiB.
    let serial = || (0..=256 * KIB + 1).chain(around_each_kib(257 * KIB, 4096 * KIB, 1));
    let (mut slice, mut in_blocks, mut keyed, mut stream) = (Found::default(), Found::default(), Found::default(), Found::default());
    against_official(Mode::Plain, bytes, serial(), |len, want| {
        slice.see(len, *convenience::hash(&bytes[..len]).as_bytes() == want);
        in_blocks.see(len, *throughput::hash(Mode::Plain, &blocks, len).as_bytes() == want);
        if len % 7 == 0 {
            // A stream in two updates, cut at a place that moves with the length.
            let cut = (len / 7 * 3) % (len + 1);
            let mut hasher = Hasher::new(Mode::Plain, None);
            hasher.update(&bytes[..cut]).update(&bytes[cut..len]);
            stream.see(len, *hasher.finalize().as_bytes() == want);
        }
    });
    against_official(Mode::Keyed(&key), bytes, serial().filter(|len| len % 3 == 0), |len, want| {
        keyed.see(len, *convenience::hash_with(Mode::Keyed(&key), &bytes[..len]).as_bytes() == want);
    });
    ok &= slice.report("convenience::hash");
    ok &= in_blocks.report("throughput::hash");
    ok &= keyed.report("convenience::hash_with, keyed");
    ok &= stream.report("Hasher, two updates");

    // Every thread: around each KiB from under the pool's 512 KiB to the longest.
    let (mut whole, mut keyed, mut stream, mut two, mut each) = (Found::default(), Found::default(), Found::default(), Found::default(), Found::default());
    let small = painted(3000);
    against_official(Mode::Plain, bytes, around_each_kib(500 * KIB, longest, 1), |len, want| {
        whole.see(len, *throughput::hash_multithreaded(Mode::Plain, &blocks, len).as_bytes() == want);
        if (len / KIB) % 4 == 0 {
            let mut hasher = Hasher::new(Mode::Plain, None);
            throughput::update_multithreaded(&mut hasher, &bytes[..len]);
            stream.see(len, *hasher.finalize().as_bytes() == want);
        }
        if (len / KIB) % 8 == 1 {
            // A stream in two updates: a short head on this thread, the rest over the pool.
            let cut = [1, KIB, 5 * KIB + 3, 64 * KIB, 300 * KIB + 1][(len / KIB / 8) % 5];
            let mut hasher = Hasher::new(Mode::Plain, None);
            hasher.update(&bytes[..cut]);
            throughput::update_multithreaded(&mut hasher, &bytes[cut..len]);
            two.see(len, *hasher.finalize().as_bytes() == want);
        }
        if (len / KIB) % 8 == 5 {
            // One long item among short ones.
            let mut out = [[0u8; 32]; 3];
            throughput::hash_each_multithreaded(Mode::Plain, &[(&small[..], 3000), (&blocks[..], len), (&small[..], 77)], &mut out);
            each.see(len, out[1] == want && out[0] == *blake3::hash(&Block::bytes(&small)[..3000]).as_bytes() && out[2] == *blake3::hash(&Block::bytes(&small)[..77]).as_bytes());
        }
    });
    against_official(Mode::Keyed(&key), bytes, around_each_kib(500 * KIB, longest, 5), |len, want| {
        keyed.see(len, *throughput::hash_multithreaded(Mode::Keyed(&key), &blocks, len).as_bytes() == want);
    });
    ok &= whole.report("throughput::hash_multithreaded");
    ok &= keyed.report("throughput::hash_multithreaded, keyed");
    ok &= stream.report("update_multithreaded, one update");
    ok &= two.report("update, then update_multithreaded");
    ok &= each.report("hash_each_multithreaded, one long item");
    assert!(ok, "a call's hash differs from official BLAKE3's at some length: see the lines above");
}

/// Batches of equal messages and collections of unequal ones, on one
/// thread and over the pool, at every message length to 4097 bytes and
/// around every block boundary to 70 KiB, for counts on both sides of
/// every kernel's width.
#[test]
fn every_batch_against_official_blake3() {
    let threads = std::env::var("LENGTH_SWEEP_THREADS").ok().map(|t| t.parse::<usize>().expect("LENGTH_SWEEP_THREADS: a count"));
    blake3_servil::initialize_multithreaded(threads.and_then(core::num::NonZeroUsize::new));
    const MOST: usize = 100;
    let longest = 70 * KIB + 2;
    let blocks = painted(longest + MOST * 131);
    let bytes = Block::bytes(&blocks);
    let lens = || (0..=4097).chain((4160 / 64..=70 * KIB / 64).flat_map(|b| [b * 64 - 1, b * 64, b * 64 + 1]));
    let (mut serial, mut pool, mut each, mut each_pool) = (Found::default(), Found::default(), Found::default(), Found::default());
    let mut prefix = Vec::new(); // official hashes of the first 0..=8300 bytes, for the collections
    against_official(Mode::Plain, bytes, 0..=8300, |_, want| prefix.push(want));
    for len in lens() {
        // Message i is the input from byte 131 i: every message differs.
        let message = |i: usize| &bytes[i * 131..i * 131 + len];
        let counts: &[usize] = if len <= 4097 { &[1, 2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 32, 33, 64, 65, MOST] } else { &[1, 2, 3, 5, 8, 17, 33] };
        let most = *counts.last().unwrap();
        let want: Vec<[u8; 32]> = (0..most).map(|i| *blake3::hash(message(i)).as_bytes()).collect();
        for &count in counts {
            let mut batch = Batch::new(len, count);
            for i in 0..count {
                batch.set(i, message(i));
            }
            let mut out = vec![[0u8; 32]; count];
            throughput::hash_many(Mode::Plain, &batch, &mut out);
            serial.see(len, out == want[..count]);
            let mut out = vec![[0u8; 32]; count];
            throughput::hash_many_multithreaded(Mode::Plain, &batch, &mut out);
            pool.see(len, out == want[..count]);
        }
        if len <= 4097 {
            // A collection of unequal messages, each the input's first bytes.
            let lens = [len, len + 1, 0, 1, 2 * len, 63, 64, 65, 1023, 1024, 1025, len, 8300 - len, 3 * len / 2];
            let items: Vec<(&[Block], usize)> = lens.iter().map(|&l| (&blocks[..], l)).collect();
            let want: Vec<[u8; 32]> = lens.iter().map(|&l| prefix[l]).collect();
            let mut out = vec![[0u8; 32]; items.len()];
            throughput::hash_each(Mode::Plain, &items, &mut out);
            each.see(len, out == want);
            let mut out = vec![[0u8; 32]; items.len()];
            throughput::hash_each_multithreaded(Mode::Plain, &items, &mut out);
            each_pool.see(len, out == want);
        }
    }
    let mut ok = serial.report("throughput::hash_many (a batch a count)");
    ok &= pool.report("throughput::hash_many_multithreaded (a batch a count)");
    ok &= each.report("throughput::hash_each (a collection of 14)");
    ok &= each_pool.report("throughput::hash_each_multithreaded (a collection of 14)");
    assert!(ok, "a call's hash differs from official BLAKE3's at some length: see the lines above");
}
RS
cd "$W/threads"
cargo test --release --test length_sweep --no-run > "$O/build.txt" 2>&1
set +e
fail=0
for t in own ${SWEEP_THREADS:-2 3 4 8}; do
  if [ "$t" = own ]; then unset LENGTH_SWEEP_THREADS; else [ "$t" -le "$(nproc)" ] || continue; export LENGTH_SWEEP_THREADS=$t; fi
  start=$(date +%s)
  # A process a test: the pool is the process's.
  cargo test --release --test length_sweep every_length -- --nocapture > "$O/sweep-$t.txt" 2>&1
  s=$?
  cargo test --release --test length_sweep every_batch -- --nocapture >> "$O/sweep-$t.txt" 2>&1 || s=$?
  [ "$s" = 0 ] || fail=1
  printf 'threads %s: exit %s, %s s, %s lines of counts, %s lines with a wrong hash\n' "$t" "$s" "$(( $(date +%s) - start ))" "$(grep -c ' lengths, ' "$O/sweep-$t.txt")" "$(grep ' lengths, ' "$O/sweep-$t.txt" | grep -vc ', 0 wrong')"
done
rm -f "$W/threads/tests/length_sweep.rs"
exit "$fail"
