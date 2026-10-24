//! One 1 MiB message (aligned blocks), hashed seven ways, in rotating
//! order each round: does the Hasher fed in chunks keep the one-shot's
//! speed? Raw ns per sample (32 calls), one TSV line each.
//! Usage: hasher-chunks ROUNDS
use blake3_servil::{convenience, performance::{self, Block, Hasher}, Mode};
use std::hint::black_box;

fn main() {
    let rounds: usize = std::env::args().nth(1).unwrap().parse().unwrap();
    blake3_servil::initialize_multithreaded(None);
    const LEN: usize = 1 << 20;
    let blocks: Vec<Block> = (0..LEN / 64).map(|i| Block([(i % 251) as u8; 64])).collect();
    let bytes = Block::bytes(&blocks);
    let chunks = |c: usize, mt: bool| move || {
        let mut h = Hasher::new();
        for piece in bytes.chunks(c) {
            if mt { h.update_multithreaded(black_box(piece)); } else { h.update(black_box(piece)); }
        }
        h.finalize()
    };
    let ways: Vec<(&str, Box<dyn Fn() -> blake3_servil::Hash>)> = vec![
        ("convenience::hash", Box::new(|| convenience::hash(black_box(bytes)))),
        ("performance::hash_multithreaded", Box::new(|| performance::hash_multithreaded(Mode::Hash, black_box(&blocks), LEN))),
        ("Hasher::update_multithreaded whole", Box::new(chunks(LEN, true))),
        ("Hasher::update_multithreaded 512 KiB", Box::new(chunks(512 << 10, true))),
        ("Hasher::update_multithreaded 64 KiB", Box::new(chunks(64 << 10, true))),
        ("Hasher::update 64 KiB", Box::new(chunks(64 << 10, false))),
        ("Hasher::update 16 KiB", Box::new(chunks(16 << 10, false))),
    ];
    let want = convenience::hash(bytes);
    for (n, f) in &ways { assert_eq!(f(), want, "{n}"); }
    println!("way\tround\tcalls\tbytes\twall_ns");
    for round in 0..rounds {
        for k in 0..ways.len() {
            let (name, f) = &ways[(k + round) % ways.len()];
            let start = clocks::now();
            for _ in 0..32 { black_box(f()); }
            println!("{name}\t{round}\t32\t{}\t{}", 32 * LEN, clocks::since_ns(start));
        }
    }
}
