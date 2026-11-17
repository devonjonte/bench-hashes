//! PROBE for BLAKE3 #421 (never merged). The sketch's chaining value carries
//! its place: 40 bytes where today's is 32, each compared when two are
//! joined, and gathered for the kernels that today read them in place. What
//! does that cost where it costs most (a layer of parents), and what share
//! of a caller's whole tree is it?
//!
//! One message of 1 MiB, one core, `clocks::measure`, three turns in
//! alternating order. Each arm's hash is checked against the library's
//! one-shot hash before any is timed.
//!
//! The sketch wraps today's calls, so its parents are copied twice (in to
//! the kernels, out to the labelled values): a library that kept the place
//! itself would copy once. These numbers are an upper bound.
use blake3_servil_core::throughput::{Cv as Bare, TreeHasher};
use blake3_servil_core::{CHUNK_LEN, Hash, Mode};
use std::hint::black_box;
use tree_shape_sketch::{Cv, LastCv, Tree};

const LEN: usize = 1 << 20;

/// Today's calls: each layer after the one before it in `cvs`, an odd last
/// value passed up as it is (b3sum's outboard.rs), to the root.
fn reduce_today(tree: &TreeHasher, cvs: &mut [Bare], leaves: usize) -> Hash {
    let (mut at, mut count) = (0, leaves);
    while count > 2 {
        let (children, parents) = cvs[at..].split_at_mut(count);
        let pairs = count / 2;
        tree.parent_cvs(&children[..2 * pairs], &mut parents[..pairs]);
        if count % 2 == 1 {
            parents[pairs] = children[count - 1];
        }
        at += count;
        count = count.div_ceil(2);
    }
    tree.root_hash(&cvs[at], &cvs[at + 1])
}

/// The sketch's calls: the whole subtrees' layers in `cvs`, the last
/// subtree's value beside them, joined to an odd whole one out.
fn reduce_sketch(tree: &Tree, cvs: &mut [Cv], whole: usize, mut last: LastCv, len: u64) -> Hash {
    let (mut at, mut count) = (0, whole);
    while count > 1 {
        let (children, parents) = cvs[at..].split_at_mut(count);
        let pairs = count / 2;
        tree.parent_cvs(&children[..2 * pairs], &mut parents[..pairs]);
        if count % 2 == 1 {
            last = tree.last_parent_cv(&children[count - 1], &last);
        }
        at += count;
        count = pairs;
    }
    tree.root_hash(&cvs[at], &last, len)
}

/// The leaves' values today: one call a piece, the last piece as the others.
fn leaves_today(tree: &TreeHasher, msg: &[u8], level: u32, cvs: &mut [Bare]) -> usize {
    let piece = CHUNK_LEN << level;
    for (i, bytes) in msg.chunks(piece).enumerate() {
        cvs[i] = tree.subtree_cv((i << level) as u64, bytes);
    }
    msg.len().div_ceil(piece)
}

/// The leaves' values in the sketch: the whole pieces', and the last one's.
fn leaves_sketch(tree: &Tree, msg: &[u8], level: u32, cvs: &mut [Cv]) -> (usize, LastCv) {
    let piece = CHUNK_LEN << level;
    let whole = msg.len().div_ceil(piece) - 1;
    for i in 0..whole {
        cvs[i] = tree.subtree_cv(level, i as u64, &msg[i * piece..(i + 1) * piece]);
    }
    (whole, tree.last_cv((whole << level) as u64, &msg[whole * piece..]))
}

/// The arms' rooms: the parents-only arms read chunk values that no other
/// arm writes (each layer of parents goes after the layer it reads).
struct Arms {
    msg: Vec<u8>,
    today: TreeHasher,
    sketch: Tree,
    bare: Vec<Bare>,
    placed: Vec<Cv>,
    chunk_bare: Vec<Bare>,
    chunk_placed: Vec<Cv>,
    chunks: usize,
    whole: usize,
    last: LastCv,
}

const NAMES: [&str; 6] = [
    "today: 1024 chunk values to the root",
    "sketch: 1024 chunk values to the root",
    "today: 1 MiB whole, chunk leaves",
    "sketch: 1 MiB whole, chunk leaves",
    "today: 1 MiB whole, 16 KiB leaves",
    "sketch: 1 MiB whole, 16 KiB leaves",
];

impl Arms {
    fn run(&mut self, arm: usize) -> Hash {
        let level = if arm < 4 { 0 } else { 4 };
        match arm {
            0 => reduce_today(&self.today, &mut self.chunk_bare, self.chunks),
            1 => reduce_sketch(&self.sketch, &mut self.chunk_placed, self.whole, self.last, LEN as u64),
            2 | 4 => {
                let n = leaves_today(&self.today, black_box(&self.msg), level, &mut self.bare);
                reduce_today(&self.today, &mut self.bare, n)
            }
            _ => {
                let (whole, last) = leaves_sketch(&self.sketch, black_box(&self.msg), level, &mut self.placed);
                reduce_sketch(&self.sketch, &mut self.placed, whole, last, LEN as u64)
            }
        }
    }
}

fn main() {
    blake3_servil_core::initialize();
    let batch_ns: u64 = if std::env::var_os("PROBE_SMOKE").is_some() { 200_000 } else { 20_000_000 };
    let msg: Vec<u8> = (0..LEN).map(|i| (i as u64).wrapping_mul(0x9e3779b97f4a7c15).to_le_bytes()[7]).collect();
    let want = blake3_servil_core::convenience::hash(&msg);
    let (today, sketch) = (TreeHasher::new(Mode::Plain), Tree::new(Mode::Plain));
    let slots = 2 * (LEN / CHUNK_LEN) + 64;
    let (mut chunk_bare, mut chunk_placed) = (vec![Bare::from_bytes([0; 32]); slots], vec![Cv::unset(); slots]);
    let chunks = leaves_today(&today, &msg, 0, &mut chunk_bare);
    let (whole, last) = leaves_sketch(&sketch, &msg, 0, &mut chunk_placed);
    let mut arms = Arms { msg, today, sketch, bare: vec![Bare::from_bytes([0; 32]); slots], placed: vec![Cv::unset(); slots], chunk_bare, chunk_placed, chunks, whole, last };
    // Every arm gives the message's hash, before any is timed and after.
    for arm in 0..NAMES.len() {
        assert_eq!(arms.run(arm), want, "{}", NAMES[arm]);
    }
    println!("# tree-shape-probe v1: a value is {} bytes today, {} with its place; the last subtree's is {}", size_of::<Bare>(), size_of::<Cv>(), size_of::<LastCv>());
    println!("arm\tns_per_call\tmin_turn\tmax_turn");
    let mut ns = vec![Vec::new(); NAMES.len()];
    for turn in 0..3 {
        for step in 0..NAMES.len() {
            // Each pair's order swaps from turn to turn.
            let arm = if turn % 2 == 0 { step } else { step ^ 1 };
            let batches = clocks::measure(6, batch_ns, || {
                black_box(arms.run(arm));
            });
            ns[arm].push(batches.iter().map(|b| b.wall_ns).sum::<u64>() as f64 / batches.iter().map(|b| b.calls).sum::<u64>() as f64);
        }
    }
    for arm in 0..NAMES.len() {
        assert_eq!(arms.run(arm), want, "{}", NAMES[arm]);
    }
    for (arm, name) in NAMES.iter().enumerate() {
        let mean = ns[arm].iter().sum::<f64>() / ns[arm].len() as f64;
        println!("{name}\t{mean:.1}\t{:.1}\t{:.1}", ns[arm].iter().cloned().fold(f64::INFINITY, f64::min), ns[arm].iter().cloned().fold(0.0, f64::max));
    }
    let windows = clocks::load::windows();
    println!("# load: {} windows, busiest {} milli-CPUs of other programs", windows.len(), windows.iter().map(|w| w.other_milli_cpus.max(w.steal_milli_cpus)).max().unwrap_or(0));
}
