// Measurement probe (not committed): CALLS calls of hash_many over MSGS 64-byte messages.
use blake3_servil::performance::{self, Block};
fn main() {
    let a: Vec<usize> = std::env::args().skip(1).map(|s| s.parse().unwrap()).collect();
    let (msgs, calls) = (a[0], a[1]);
    blake3_servil::initialize();
    let input = vec![Block([7u8; 64]); msgs];
    let mut out = vec![[0u8; 32]; msgs];
    for _ in 0..calls {
        performance::hash_many(blake3_servil::Mode::Hash, std::hint::black_box(&input), 64, &mut out);
        std::hint::black_box(&mut out);
    }
}
