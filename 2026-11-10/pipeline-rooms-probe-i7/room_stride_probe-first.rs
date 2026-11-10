//! A probe for the Pipeline's design (BLAKE3 #356): what does it cost a
//! stream of short messages when each message's bytes lie in a room of its
//! own (16 KiB apart), against lying back to back as in today's ring?
//!
//! It uses today's stream and its lent call, on bytes that never change,
//! so the workers read each message where it lies. It leaves out two
//! things a room a message would also cost: the producer's write into the
//! room, and the wait for a free room. So it is a lower bound.
//!
//!     cargo run --release --example room_stride_probe
//!
//! Prints, for each message length, the median ns/B of each layout over
//! alternating rounds.
use blake3_servil::throughput::Block;
use blake3_servil::{Hash, Mode};
use std::time::Instant;

const ROOM: usize = 16 * 1024;
const MESSAGES: usize = 100_000;
const ROUNDS: usize = 41;

/// One stream of MESSAGES messages of `len` bytes, message i at
/// `starts[i % starts.len()]` blocks into `memory`: nanoseconds.
fn round(memory: &[Block], starts: &[usize], len: usize, digests: &mut [Hash]) -> u128 {
    let blocks = len.div_ceil(64);
    let begin = Instant::now();
    blake3_servil::throughput::stream(
        Mode::Plain,
        |_done: &mut [Hash]| {},
        |s| {
            for (i, digest) in digests.iter_mut().enumerate() {
                let at = starts[i % starts.len()];
                s.submit(&memory[at..at + blocks], len, digest);
            }
            s.finish();
        },
    );
    begin.elapsed().as_nanos()
}

fn median(mut v: Vec<u128>) -> u128 {
    v.sort_unstable();
    v[v.len() / 2]
}

fn main() {
    blake3_servil::initialize_multithreaded(None);
    // 16 MiB of bytes that never change, every block different.
    let total_blocks = 1024 * ROOM / 64;
    let memory: Vec<Block> = (0..total_blocks as u32).map(|i| Block(i.to_le_bytes().repeat(16).try_into().unwrap())).collect();
    let mut digests = vec![Hash::from_bytes([0; 32]); MESSAGES];
    println!("{MESSAGES} messages a stream, {ROUNDS} rounds a layout, alternating; median ns/B, and against back to back");
    for len in [64usize, 256, 1024, 4096] {
        let blocks = len.div_ceil(64);
        // Back to back through 2 MiB (today's ring's size), then round again.
        let packed: Vec<usize> = (0..(2 << 20) / 64 / blocks).map(|i| i * blocks).collect();
        // A room each: 128 rooms (2 MiB of rooms) and 1,024 rooms (16 MiB).
        let rooms = |count: usize| -> Vec<usize> { (0..count).map(|i| i * ROOM / 64).collect() };
        let layouts: [(&str, Vec<usize>); 3] = [("back to back, 2 MiB", packed), ("a room each, 128 rooms", rooms(128)), ("a room each, 1,024 rooms", rooms(1024))];
        // The digests are the same whatever the layout only where the bytes
        // are; here they differ, so check each layout against the one-shot call once.
        for (name, starts) in &layouts {
            round(&memory, starts, len, &mut digests);
            for i in [0usize, 1, 77, MESSAGES - 1] {
                let at = starts[i % starts.len()];
                let bytes: Vec<u8> = memory[at..at + blocks].iter().flat_map(|b| b.0).take(len).collect();
                assert_eq!(digests[i], blake3_servil::convenience::hash(&bytes), "{name}, message {i}");
            }
        }
        let mut times: [Vec<u128>; 3] = Default::default();
        for r in 0..ROUNDS {
            for k in 0..3 {
                // Each round a different layout first.
                let k = (k + r) % 3;
                times[k].push(round(&memory, &layouts[k].1, len, &mut digests));
            }
        }
        let per_byte = |ns: u128| ns as f64 / (MESSAGES * len) as f64;
        let base = median(times[0].clone());
        for (k, (name, _)) in layouts.iter().enumerate() {
            let m = median(times[k].clone());
            println!("  {len:>5} B  {name:<26} {:.4} ns/B  x{:.3}", per_byte(m), m as f64 / base as f64);
        }
    }
}
