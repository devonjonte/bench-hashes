// Measurement probe (not committed): CALLS warm calls of hash_many over
// COUNT messages of LEN bytes in a Batch (padding zero), one thread.
use blake3_servil::performance::{self, Batch};
fn main() {
    let a: Vec<usize> = std::env::args().skip(1).map(|s| s.parse().unwrap()).collect();
    let (count, len, calls) = (a[0], a[1], a[2]);
    blake3_servil::initialize();
    let mut batch = Batch::new(len, count);
    for i in 0..count { batch.set(i, &vec![(i % 251) as u8; len]); }
    let mut out = vec![[0u8; 32]; count];
    for _ in 0..calls {
        performance::hash_many(blake3_servil::Mode::Plain, std::hint::black_box(batch.blocks()), len, &mut out);
        std::hint::black_box(&mut out);
    }
}
