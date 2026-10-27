// For the Mac (BLAKE3 #190): extended output of 1 to 8 blocks, the cases
// whose tail (and first block) move from the portable Rust to the x4
// kernel. Copy into examples/ on e7c5ef48 and on #190's head, then
//   cargo run --release --example xof_probe
// on each; it prints ns per call for each length.
fn main() {
    blake3_servil::initialize();
    let mut hasher = blake3_servil::performance::Hasher::new();
    hasher.update(b"abc");
    for blocks in 1..=8usize {
        let mut out = vec![0u8; 64 * blocks];
        let calls = 2_000_000 / blocks;
        let t = std::time::Instant::now();
        for _ in 0..calls {
            let mut reader = std::hint::black_box(&hasher).finalize_xof();
            reader.fill(&mut out);
            std::hint::black_box(&out);
        }
        println!("{blocks} blocks: {:.1} ns a call", t.elapsed().as_nanos() as f64 / calls as f64);
    }
}
