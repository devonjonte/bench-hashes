//! Front-end costs of the single-chunk kernel: hash_with(Mode::Hash) of one
//! aligned message, warm (calls back to back) or cold (each after clocks'
//! busy gap: about 1 MiB of other code and a 64 MiB buffer's walk). Prints
//! the calls' own time; `perf stat` around a run counts the rest, and a
//! `gap` run (the same loop with no hash) is the baseline to subtract.
//! Usage: gpr-icache warm|cold|gap LEN CALLS
use std::hint::black_box;

#[repr(C, align(64))]
struct Input([u8; 1024]);

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let (mode, len, calls): (&str, usize, usize) = (&args[1], args[2].parse().unwrap(), args[3].parse().unwrap());
    blake3_servil::initialize();
    let mut input = Box::new(Input([0; 1024]));
    for (i, b) in input.0.iter_mut().enumerate() {
        *b = (i % 251) as u8;
    }
    let mut out = Box::new(blake3_servil::Hash::from([0; 32]));
    let work = vec![1u8; 64 << 20];
    let gap = clocks::Gap::Busy(&work);
    let mut ns = 0u64;
    match mode {
        "warm" => {
            let t = clocks::now();
            for _ in 0..calls {
                blake3_servil::hash_with(blake3_servil::Mode::Hash, black_box(&input.0[..len]), &mut out);
                black_box(&out);
            }
            ns = clocks::since_ns(t);
        }
        "cold" | "gap" => {
            for _ in 0..calls {
                gap.spend(0);
                if mode == "cold" {
                    let t = clocks::now();
                    blake3_servil::hash_with(blake3_servil::Mode::Hash, black_box(&input.0[..len]), &mut out);
                    black_box(&out);
                    ns += clocks::since_ns(t);
                }
            }
        }
        _ => panic!("warm|cold|gap"),
    }
    println!("{mode}\t{len}\t{calls}\t{ns}\t{:.2}", ns as f64 / calls as f64);
}
