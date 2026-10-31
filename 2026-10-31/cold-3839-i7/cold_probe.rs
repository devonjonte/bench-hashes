// Measurement probe (not committed), BLAKE3 #119: one message of LEN bytes
// hashed on the calling thread after other work, as the bench's OneMessage
// cell does: hash, read EVICT MiB of memory (the caches go cold), write the
// input, then time one call with the TSC. ROUNDS such calls; prints each
// call's cycles, one a line. HASH selects the crate's one-message call.
use std::hint::black_box;

#[inline(never)]
fn hash(input: &[u8]) -> [u8; 32] {
    *HASH(input).as_bytes()
}

fn main() {
    let a: Vec<usize> = std::env::args().skip(1).map(|s| s.parse().unwrap()).collect();
    let (len, rounds, evict_mib) = (a[0], a[1], a[2]);
    blake3_servil::initialize();
    let mut input = vec![0u8; len];
    let mut other = vec![1u8; evict_mib << 20];
    let mut sink = 0u64;
    let mut out = Vec::with_capacity(rounds);
    for r in 0..rounds {
        // Other work: read and write the eviction buffer, a line at a time.
        for line in other.chunks_mut(64) {
            line[0] = line[0].wrapping_add(1);
            sink = sink.wrapping_add(line[0] as u64);
        }
        // The input written just before the call, as the bench writes it.
        for (i, b) in input.iter_mut().enumerate() {
            *b = (i + r) as u8;
        }
        let t0 = unsafe { core::arch::x86_64::_rdtsc() };
        let d = hash(black_box(&input));
        let t1 = unsafe { core::arch::x86_64::_rdtsc() };
        sink = sink.wrapping_add(d[0] as u64);
        out.push(t1 - t0);
    }
    black_box(sink);
    for c in out {
        println!("{c}");
    }
}
