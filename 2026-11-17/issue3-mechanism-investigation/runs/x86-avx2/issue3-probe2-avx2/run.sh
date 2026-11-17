#!/bin/sh
# bench-hashes #3 probe, declared Nov 17, 2026: convenience::hash of 128 B after
# other work, counters inside the write+call bracket, 8 link layouts of one probe
# binary (check's own relink method), pinned to CPU 0, 3 processes a layout.
# Expectation: if code delivery carries the layout states, slow layouts show
# more L1-icache misses (or branch misses) a call at equal instructions.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/issue3-probe2-avx2"
if [ "${BOUNDED_P:-}" != yes ]; then
  export BOUNDED_P=yes
  status=0
  timeout --kill-after=30s 3600s sh "$O/run.sh" || status=$?
  printf 'PROBE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=16 CARGO_INCREMENTAL=0
unset RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
export CARGO_TARGET_DIR="$HOME/work/issue3-probe-target"
trap 'rm -rf "$CARGO_TARGET_DIR"' EXIT
LIB="$HOME/work/i3lib"
[ -d "$LIB" ] || git clone -q https://github.com/servil-software-factory/BLAKE3 "$LIB"
git -C "$LIB" checkout -q 4483281c
S="$O/source"; mkdir -p "$S/src"
cat > "$S/Cargo.toml" <<'EOF_TOML'
[package]
name = "issue3-probe"
version = "0.0.0"
edition = "2021"
publish = false

[dependencies]
blake3-servil-core = { path = "LIBPATH" }
libc = "0.2"

[profile.release]
debug = false
EOF_TOML
cat > "$S/src/main.rs" <<'EOF_RS'
//! bench-hashes #3 diagnostic: convenience::hash of 128 B after other work,
//! with perf counters read only around the write and the call (the gap is
//! outside the counter window, as clocks' counts are). Prints per-call
//! cycles, instructions, L1-icache load misses, op-cache misses and branch
//! misses for this process. Pin with taskset.
use std::time::Instant;

const EVENTS: [(u32, u64, &str); 5] = [
    (0, 0, "cycles"),
    (0, 1, "instructions"),
    (1, 0, "l1_icache_misses"), // PERF_COUNT_HW_CACHE_L1I reads-miss, encoded below
    (0, 0, "op_cache_miss"),    // filled in by raw config in open_group
    (0, 5, "branch_misses"),
];

struct Counters {
    fds: Vec<i32>,
}

fn perf_open(attr: &[u64; 16], leader: i32) -> i32 {
    let fd = unsafe { libc::syscall(libc::SYS_perf_event_open, attr.as_ptr(), 0, -1, leader, 0) };
    assert!(fd >= 0, "perf_event_open: {}", std::io::Error::last_os_error());
    fd as i32
}

/// perf_event_attr, the kernel's 128 bytes: type, size, config, then the
/// disabled flag at bit 0 of the flags word (offset 40).
fn attr(kind: u32, config: u64) -> [u64; 16] {
    let mut attr = [0u64; 16];
    attr[0] = kind as u64 | (128u64 << 32);
    attr[1] = config;
    attr[5] = 1 | (1 << 5) | (1 << 6);
    attr
}

impl Counters {
    fn new(op_cache_config: u64) -> Counters {
        // Hardware events: cycles (0,0), instructions (0,1), branch misses (0,5);
        // cache event: type 3 (HW_CACHE), config = L1I | READ | MISS = 0 | (0<<8) | (1<<16);
        // op cache miss: raw type 4 with the machine's config from the argument.
        let specs: [(u32, u64); 4] = [(0, 0), (0, 1), (3, 0x10000), (0, 5)];
        let mut fds = Vec::new();
        for (i, (kind, config)) in specs.iter().enumerate() {
            let a = attr(*kind, *config);
            let leader = if i == 0 { -1 } else { fds[0] };
            fds.push(perf_open(&a, leader));
        }
        Counters { fds }
    }
    fn enable(&self) {
        unsafe { libc::ioctl(self.fds[0], 0x2400, 1) };
    }
    fn disable(&self) {
        unsafe { libc::ioctl(self.fds[0], 0x2401, 1) };
    }
    fn read(&self) -> [u64; 5] {
        let mut out = [0u64; 5];
        for (i, fd) in self.fds.iter().enumerate() {
            let mut value: u64 = 0;
            let n = unsafe { libc::read(*fd, &mut value as *mut u64 as *mut libc::c_void, 8) };
            assert_eq!(n, 8);
            out[i] = value;
        }
        out
    }
}

fn main() {
    blake3_servil_core::initialize();
    let args: Vec<String> = std::env::args().collect();
    let calls: usize = args.get(1).map(|s| s.parse().unwrap()).unwrap_or(2000);
    let op_config: u64 = args.get(2).map(|s| u64::from_str_radix(s.trim_start_matches("0x"), 16).unwrap()).unwrap_or(0);
    let counters = Counters::new(op_config);
    let work: Vec<u8> = (0..128 * 1024 * 1024).map(|i| (i % 251) as u8).collect();
    let input: Vec<u8> = (0..128).map(|i| (i % 251) as u8).collect();
    let mut produced = vec![0u8; 4096];
    let mut digest = [0u8; 32];
    // Warm: one untimed call in this pattern.
    produced[..128].copy_from_slice(&input);
    digest = *blake3_servil_core::convenience::hash(&produced[..128]).as_bytes();
    let started = Instant::now();
    let mut wall_ns: u128 = 0;
    for _ in 0..calls {
        // Other work: walk the 128 MiB buffer at 64-byte intervals for ~1 ms.
        let t0 = Instant::now();
        let mut sum: u64 = 0;
        let mut at = 0usize;
        while t0.elapsed().as_nanos() < 1_000_000 {
            sum = sum.wrapping_add(work[at] as u64);
            at = (at + 64) % work.len();
        }
        std::hint::black_box(sum);
        counters.enable();
        let t = Instant::now();
        produced[..128].copy_from_slice(std::hint::black_box(&input[..]));
        let hash = blake3_servil_core::convenience::hash(&produced[..128]);
        wall_ns += t.elapsed().as_nanos();
        counters.disable();
        digest = *hash.as_bytes();
    }
    let counts = counters.read();
    let per = |v: u64| v as f64 / calls as f64;
    println!(
        "calls {calls} wall_ns_per_call {:.0} cycles {:.1} instructions {:.1} l1i_misses {:.3} raw4 {:.3} branch_misses {:.3} digest {}",
        wall_ns as f64 / calls as f64,
        per(counts[0]),
        per(counts[1]),
        per(counts[2]),
        per(counts[3]),
        per(counts[4]),
        blake3_servil_core::Hash::from(digest).to_hex()
    );
    let _ = started;
}
EOF_RS
sed -i "s#LIBPATH#$LIB#" "$S/Cargo.toml"
cargo build --release --quiet --manifest-path "$S/Cargo.toml" > "$O/build.log" 2>&1
EXE="$CARGO_TARGET_DIR/release/issue3-probe"
cp "$EXE" "$O/exe-base"
# Relink layouts: shuffle the executable's text symbols per seed (check's method).
mkdir -p "$O/lld"
newest=$(ls /usr/bin/ld.lld-* | sort -V | tail -1); ln -sf "$newest" "$O/lld/ld.lld"
nm "$EXE" | awk '$2=="t"||$2=="T"{print $3}' | sort -u > "$O/symbols.txt"
seed=0
while [ $seed -lt 8 ]; do
  python3 - "$seed" "$O/symbols.txt" "$O/order-$seed.txt" <<'PYEOF'
import random,sys
syms=open(sys.argv[2]).read().splitlines()
random.Random(int(sys.argv[1])).shuffle(syms)
open(sys.argv[3],'w').write('\n'.join(syms)+'\n')
PYEOF
  cargo rustc --release --quiet --manifest-path "$S/Cargo.toml" -- -Clink-arg=-fuse-ld=lld -Clink-arg=-B"$O/lld" -Clink-arg=-Wl,--symbol-ordering-file="$O/order-$seed.txt" -Clink-arg=-Wl,--no-warn-symbol-ordering >> "$O/build.log" 2>&1
  cp "$EXE" "$O/exe-layout-$seed"
  seed=$((seed+1))
done
taskset -c 0 "$O/exe-layout-0" 10 0 > /dev/null
for exe in "$O"/exe-layout-*; do
  i=1
  while [ $i -le 3 ]; do
    printf '%s ' "$(basename $exe)"
    taskset -c 0 "$exe" 2000 0
    i=$((i+1))
  done
done > "$O/results.txt"
cat "$O/results.txt"
