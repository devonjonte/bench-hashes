use blake3_servil::performance::{self, Batch, Block};
fn main() {
    let a: Vec<usize> = std::env::args().skip(1).map(|s| s.parse().unwrap()).collect();
    let (count, calls) = (a[0], a[1]);
    blake3_servil::initialize();
    let blocks = vec![Block([7u8; 64]); count];
    let mut out = vec![[0u8; 32]; count];
    for _ in 0..calls { performance::hash_many(blake3_servil::Mode::Plain, &Batch::from_blocks(std::hint::black_box(&blocks), 64), &mut out); std::hint::black_box(&mut out); }
}
