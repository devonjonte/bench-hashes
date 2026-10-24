//! Hasher::update_multithreaded against hash_multithreaded on one large
//! input (BLAKE3 servil, the line): does b3sum's Hasher path leave speed
//! behind the one-shot's? Alternating pairs (AB, BA, ...), each sample
//! the wall time of `calls` calls; one TSV line a sample, raw ns.
//! Usage: hasher-vs-oneshot FILE ROUNDS [mid]: with `mid`, 512 KiB to 16 MiB
//! in memory instead.
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
    let mid: Vec<(String, Vec<u8>, usize)> = std::env::args().nth(3).map_or(Vec::new(), |_| {
        [(512usize << 10, 1024usize), (1 << 20, 512), (4 << 20, 128), (16 << 20, 32)].into_iter().map(|(len, calls)| (format!("{}KiB", len >> 10), make(len), calls)).collect()
    });
    let names: Vec<(&str, usize)> = if mid.is_empty() { vec![("64MiB", 16usize), ("1GiB", 2), ("1GiB-mapped", 2)] } else { mid.iter().map(|(n, _, c)| (n.as_str(), *c)).collect() };
    for (input, calls) in names {
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
                        name if name.ends_with("KiB") => {
                            let x = &mid.iter().find(|(n, _, _)| n == name).unwrap().1;
                            black_box(call(black_box(x)));
                            bytes += x.len() as u64;
                        }
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
