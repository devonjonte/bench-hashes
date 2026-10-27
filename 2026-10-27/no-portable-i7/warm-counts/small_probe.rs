// Measurement probe (not committed): CALLS calls of one small call, warm.
// KIND: many1 (hash_many, one 64 B message), st128 / st512 (convenience::hash),
// mt128 (performance::hash_multithreaded, 128 B).
use blake3_servil::performance::{self, Block};
fn main() {
    let a: Vec<String> = std::env::args().skip(1).collect();
    let (kind, calls): (&str, usize) = (&a[0], a[1].parse().unwrap());
    if kind == "mt128" { blake3_servil::initialize_multithreaded(None) } else { blake3_servil::initialize() }
    let blocks = vec![Block([7u8; 64]); 8];
    let bytes = vec![7u8; 512];
    let mut out = vec![[0u8; 32]; 1];
    for _ in 0..calls {
        match kind {
            "many1" => performance::hash_many(blake3_servil::Mode::Plain, std::hint::black_box(&blocks[..1]), 64, &mut out),
            "st128" => out[0] = *blake3_servil::convenience::hash(std::hint::black_box(&bytes[..128])).as_bytes(),
            "st512" => out[0] = *blake3_servil::convenience::hash(std::hint::black_box(&bytes[..512])).as_bytes(),
            "mt128" => out[0] = *performance::hash_multithreaded(blake3_servil::Mode::Plain, std::hint::black_box(&blocks[..2]), 128).as_bytes(),
            _ => panic!("kind"),
        }
        std::hint::black_box(&mut out);
    }
}
