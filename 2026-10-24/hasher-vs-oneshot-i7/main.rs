//! Hasher::update_multithreaded against hash_multithreaded on one large
//! input (BLAKE3 servil, the line): does b3sum's Hasher path leave speed
//! behind the one-shot's? Alternating pairs (AB, BA, ...), each sample
//! the wall time of `calls` calls; one TSV line a sample, raw ns.
//! Usage: hasher-vs-oneshot FILE ROUNDS
use std::hint::black_box;

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let (file, rounds): (&str, usize) = (&args[1], args[2].parse().unwrap());
    blake3_servil::initialize_multithreaded(None);
    let make = |len: usize| -> Vec<u8> { (0..len).map(|i| (i % 251) as u8).collect() };
    let small = make(64 << 20);
    let large = make(1 << 30);
    let f = std::fs::File::open(file).unwrap();
    let hasher = |x: &[u8]| blake3_servil::Hasher::new().update_multithreaded(x).finalize();
    let oneshot = |x: &[u8]| blake3_servil::hash_multithreaded(x);
    assert_eq!(hasher(&large), oneshot(&large));
    println!("input\tcall\tround\tcalls\tbytes\twall_ns");
    for (input, calls) in [("64MiB", 16usize), ("1GiB", 2), ("1GiB-mapped", 2)] {
        for round in 0..rounds {
            let order: [(&str, &dyn Fn(&[u8]) -> blake3_servil::Hash); 2] =
                if round % 2 == 0 { [("hasher", &hasher), ("oneshot", &oneshot)] } else { [("oneshot", &oneshot), ("hasher", &hasher)] };
            for (name, call) in order {
                let mut bytes = 0u64;
                let start = clocks::now();
                for _ in 0..calls {
                    match input {
                        "64MiB" => { black_box(call(black_box(&small))); bytes += small.len() as u64; }
                        "1GiB" => { black_box(call(black_box(&large))); bytes += large.len() as u64; }
                        _ => {
                            // A fresh mapping each call, as b3sum maps each file.
                            let map = unsafe { memmap2::Mmap::map(&f) }.unwrap();
                            black_box(call(black_box(&map)));
                            bytes += map.len() as u64;
                        }
                    }
                }
                println!("{input}\t{name}\t{round}\t{calls}\t{bytes}\t{}", clocks::since_ns(start));
            }
        }
    }
}
