//! A diagnostic, not a replacement workload: the benchmark's released
//! gap and exact preparation/call brackets, with empty-work controls.
//! It asks whether the unexplained cost is also present without hashing.
use std::hint::black_box;

const ROUNDS: usize = 96;
const CALLS: u64 = 3;
const BYTES: usize = 128;
const NAMES: [&str; 4] = ["empty", "hash", "hash8", "arithmetic"];

#[inline(never)]
fn empty(input: &[u8]) {
    black_box(input);
}

#[inline(never)]
fn hash(input: &[u8]) {
    black_box(blake3_servil_core::convenience::hash(black_box(input)));
}

#[inline(never)]
fn hash8(input: &[u8]) {
    for _ in 0..8 {
        black_box(blake3_servil_core::convenience::hash(black_box(input)));
    }
}

#[inline(never)]
fn arithmetic(input: &[u8]) {
    let mut x = black_box(input[0] as u64);
    for _ in 0..black_box(512) {
        x = x.wrapping_mul(0x9e3779b97f4a7c15).rotate_left(7);
    }
    black_box(x);
}

fn report(round: usize, case: usize, part: &str, batch: clocks::Batch) {
    let c = batch
        .counts
        .expect("this diagnostic requires the host's routine counters");
    assert_eq!(
        c.e,
        clocks::Level::default(),
        "this job uses a homogeneous CPU"
    );
    println!(
        "{round}\t{}\t{part}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}",
        NAMES[case],
        batch.calls,
        batch.wall_ns,
        c.p.time_ns,
        c.p.cycles,
        c.p.instructions,
        c.p.cache_references,
        c.p.cache_misses,
        batch.started_ns
    );
}

fn main() {
    // taskset pins this core-only diagnostic's whole process before startup.
    // It deliberately omits the benchmark's thread-pool/context machinery.
    blake3_servil_core::initialize();
    clocks::tight_timers();
    let input: Vec<u8> = (0..BYTES).map(|i| (i % 251) as u8).collect();
    assert_eq!(
        blake3_servil_core::convenience::hash(&input)
            .to_hex()
            .as_str(),
        "f17e570564b26578c33bb7f44643f539624b05df1a76c81f30acd548c44b45ef"
    );
    let work: Vec<u8> = (0..128 * 1024 * 1024).map(|i| (i % 251) as u8).collect();
    let mut produced = vec![0u8; BYTES];
    let functions: [fn(&[u8]); 4] = [empty, hash, hash8, arithmetic];
    let mut calls: [Vec<(u64, u64)>; 4] = std::array::from_fn(|_| Vec::new());
    println!("# core 27eacce3a5c2e03043f4fcd347c178a80f9d911c; clocks cade30fdb71682719f5fa3e586ff96146ae9fc25; {CALLS} calls/sample; 128 B input");
    println!("# counts read overhead: {}", clocks::read_overhead());
    println!("round\tcase\tpart\tcalls\twall_ns\tP_time_ns\tP_cycles\tP_instructions\tP_cache_references\tP_cache_misses\tstarted_ns");
    for round in 0..ROUNDS {
        // Rotate which case starts a round, as the bench rotates its points.
        for i in 0..NAMES.len() {
            let case = (i + round) % NAMES.len();
            let f = functions[case];
            let measured = clocks::measure_after_gaps_prepared(
                CALLS,
                clocks::Gap::Busy(&work),
                1_000_000,
                produced.as_mut_slice(),
                |p| p.copy_from_slice(black_box(&input)),
                |p| f(black_box(p)),
            );
            calls[case].push((measured.calls.wall_ns, measured.calls.calls));
            report(round, case, "preparation", measured.preparation);
            report(round, case, "call", measured.calls);
        }
    }
    for case in 0..NAMES.len() {
        let (ns, total_calls) = clocks::summary::mean_totals(calls[case].iter().copied());
        println!(
            "# mean {}: {ns}/{total_calls} ns/call; Q64 {}",
            NAMES[case],
            clocks::summary::mean(calls[case].iter().copied())
        );
    }
    println!(
        "# load: {}",
        clocks::load::describe(&clocks::load::windows())
    );
}
