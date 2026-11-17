//! A real caller on the sketch: b3sum's `--outboard` (b3sum/src/outboard.rs
//! at BLAKE3-Servil `d1b4596a`), ported call for call. The file's groups of
//! 16 KiB are hashed on several threads, each value written to its slot;
//! the parents are made a layer at a time; and each parent's two children
//! are written out in pre-order. The result is compared with bao-tree's
//! own, byte for byte, as b3sum's tests compare theirs.
//!
//! Then the two mistakes that port could make (a slot never filled, two
//! slots filled the wrong way round): today's calls give a wrong hash and
//! outboard without a word, and the sketch's stop.

use blake3_servil_core::throughput::{Cv as Bare, TreeHasher};
use blake3_servil_core::{CHUNK_LEN, Hash, Mode};
use std::panic::{AssertUnwindSafe, catch_unwind};
use tree_shape_sketch::{Cv, LastCv, Tree, level_of};

/// A chunk group: sixteen chunks, bao-tree's block size 4.
const GROUP: usize = 16 * CHUNK_LEN;
/// Checked when this compiles: a group is a whole subtree's size.
const LEVEL: u32 = level_of(GROUP as u64);

/// A layer of the tree: its whole subtrees' values, `whole` of them from
/// `cvs[at]`, and beside them the value of the message's last subtree at
/// that layer.
#[derive(Clone, Copy)]
struct Layer {
    at: usize,
    whole: usize,
    last: LastCv,
}

/// The bytes of value `j` of a layer: a whole subtree's, or after them the last one's.
fn value<'a>(cvs: &'a [Cv], layer: &'a Layer, j: usize) -> &'a [u8; 32] {
    if j < layer.whole { cvs[layer.at + j].as_bytes() } else { layer.last.as_bytes() }
}

/// The node `index` of the layer under `layer`, and the nodes below it,
/// appended to `out` in pre-order: a parent as its two children's values.
/// A last value its layer passed up as it was is no parent, and writes
/// nothing of its own. The root is node 0 of the layer above the top.
fn node(cvs: &[Cv], layers: &[Layer], layer: usize, index: usize, out: &mut Vec<u8>) {
    if layer == 0 {
        return;
    }
    let below = &layers[layer - 1];
    if 2 * index + 1 > below.whole {
        return node(cvs, layers, layer - 1, 2 * index, out);
    }
    out.extend_from_slice(value(cvs, below, 2 * index));
    out.extend_from_slice(value(cvs, below, 2 * index + 1));
    node(cvs, layers, layer - 1, 2 * index, out);
    node(cvs, layers, layer - 1, 2 * index + 1, out);
}

/// The hash of a message of `len` bytes, more than a group, and its
/// outboard: `fill` writes the whole groups' values (all groups but the
/// last) and returns the last group's.
fn build(tree: &Tree, len: usize, fill: impl FnOnce(&mut [Cv]) -> LastCv) -> (Hash, Vec<u8>) {
    assert!(len > GROUP);
    let groups = len.div_ceil(GROUP);
    // Every layer's whole values, one layer after another: each holds half the one below.
    let mut cvs = vec![Cv::unset(); 2 * groups];
    let last = fill(&mut cvs[..groups - 1]);
    let mut layers = vec![Layer { at: 0, whole: groups - 1, last }];
    loop {
        let Layer { at, whole, last } = *layers.last().unwrap();
        if whole == 1 {
            break;
        }
        let (children, parents) = cvs[at..].split_at_mut(whole);
        let pairs = whole / 2;
        tree.parent_cvs(&children[..2 * pairs], &mut parents[..pairs]);
        // An odd whole one out is the last subtree's left sibling; with none, the last goes up as it is.
        let last = if whole % 2 == 1 { tree.last_parent_cv(&children[whole - 1], &last) } else { last };
        layers.push(Layer { at: at + whole, whole: pairs, last });
    }
    let top = *layers.last().unwrap();
    let mut out = Vec::with_capacity(64 * (groups - 1));
    node(&cvs, &layers, layers.len(), 0, &mut out);
    (tree.root_hash(&cvs[top.at], &top.last, len as u64), out)
}

/// The groups' values, the whole ones on `threads` threads, each thread a run of slots.
fn group_cvs(tree: &Tree, data: &[u8], threads: usize, cvs: &mut [Cv]) -> LastCv {
    let whole = cvs.len();
    let a_thread = whole.div_ceil(threads).max(1);
    std::thread::scope(|scope| {
        for (t, slots) in cvs.chunks_mut(a_thread).enumerate() {
            let tree = tree.clone().on_this_core();
            scope.spawn(move || {
                for (i, slot) in slots.iter_mut().enumerate() {
                    let group = t * a_thread + i;
                    *slot = tree.subtree_cv(LEVEL, group as u64, &data[group * GROUP..(group + 1) * GROUP]);
                }
            });
        }
    });
    tree.last_cv((whole << LEVEL) as u64, &data[whole * GROUP..])
}

fn outboard(mode: Mode, data: &[u8], threads: usize) -> (Hash, Vec<u8>) {
    let tree = Tree::new(mode);
    if data.len() <= GROUP {
        return (tree.hash(data), Vec::new());
    }
    build(&tree, data.len(), |cvs| group_cvs(&tree, data, threads, cvs))
}

fn painted(len: usize) -> Vec<u8> {
    (0..len).map(|i| (i.wrapping_mul(31) ^ (i >> 9)) as u8).collect()
}

/// The lengths of b3sum's own test, but its longest (3 threads' worth of
/// 4 MiB): around a group, around powers of two of groups, and ragged.
fn lengths() -> Vec<usize> {
    let mut lens = vec![0usize, 1, 1024, GROUP - 1, GROUP, GROUP + 1, 2 * GROUP - 1, 2 * GROUP, 2 * GROUP + 1, 3 * GROUP, 50_000, 5 * GROUP + 1];
    lens.extend([63 * GROUP, 64 * GROUP, 64 * GROUP + 1, 65 * GROUP + 100, 1 << 20, (1 << 20) + 1, 131 * GROUP + 17]);
    lens
}

#[test]
fn the_outboard_is_bao_trees_byte_for_byte() {
    blake3_servil_core::initialize();
    let all = painted(131 * GROUP + 17);
    let key = [0x42u8; 32];
    let block_size = bao_tree::BlockSize::from_chunk_log(4);
    for len in lengths() {
        let data = &all[..len];
        for threads in [1, 3, 16] {
            let (hash, plain) = outboard(Mode::Plain, data, threads);
            let theirs = bao_tree::io::outboard::PreOrderMemOutboard::create(data, block_size);
            assert_eq!(hash.as_bytes(), theirs.root.as_bytes(), "the hash, len={len} threads={threads}");
            assert_eq!(plain, theirs.data, "the outboard, len={len} threads={threads}");
            assert_eq!(plain.len(), 64 * len.div_ceil(GROUP).saturating_sub(1), "a node a group but one, len={len}");
            let (hash, keyed) = outboard(Mode::Keyed(&key), data, threads);
            let theirs = bao_tree::io::outboard::PreOrderMemOutboard::create_keyed(data, block_size, &key);
            assert_eq!(hash.as_bytes(), theirs.root.as_bytes(), "the keyed hash, len={len} threads={threads}");
            assert_eq!(keyed, theirs.data, "the keyed outboard, len={len} threads={threads}");
        }
    }
}

/// Today's calls, as b3sum's outboard.rs makes them: the hash alone.
fn hash_today(len: usize, fill: impl FnOnce(&TreeHasher, &mut [Bare])) -> Hash {
    let tree = TreeHasher::new(Mode::Plain);
    let groups = len.div_ceil(GROUP);
    let mut cvs = vec![Bare::from_bytes([0; 32]); 2 * groups + usize::BITS as usize];
    fill(&tree, &mut cvs[..groups]);
    let (mut at, mut count) = (0, groups);
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

/// The message `f` panics with.
fn refusal<T>(f: impl FnOnce() -> T) -> String {
    let payload = catch_unwind(AssertUnwindSafe(f)).err().expect("the call is refused");
    payload.downcast_ref::<String>().cloned().or_else(|| payload.downcast_ref::<&str>().map(|s| s.to_string())).unwrap_or_default()
}

/// A fill that leaves one slot as it was made (a read that failed, its
/// failure dropped), and one that writes two values the wrong way round
/// (an index mistake). Today's calls take both and return a hash that is
/// not the message's. The sketch's first join stops, naming the slot.
#[test]
fn a_slot_missed_or_misplaced_stops_the_build() {
    blake3_servil_core::initialize();
    let data = painted(37 * GROUP + 5);
    let want = *blake3::hash(&data).as_bytes();
    let groups = data.len().div_ceil(GROUP);
    let group = |g: usize| &data[g * GROUP..data.len().min((g + 1) * GROUP)];

    // Today, filled rightly: the message's hash. Then each mistake: another hash, and no error.
    let fill_today = |skip: Option<usize>, swap: Option<(usize, usize)>| {
        hash_today(data.len(), |tree, cvs| {
            for g in (0..groups).filter(|g| Some(*g) != skip) {
                cvs[g] = tree.subtree_cv((g * GROUP / CHUNK_LEN) as u64, group(g));
            }
            if let Some((a, b)) = swap {
                cvs.swap(a, b);
            }
        })
    };
    assert_eq!(fill_today(None, None).as_bytes(), &want);
    assert_ne!(fill_today(Some(9), None).as_bytes(), &want, "today: a slot never filled gives a hash");
    assert_ne!(fill_today(None, Some((4, 5))).as_bytes(), &want, "today: two slots swapped give a hash");

    // The sketch, filled rightly, then with each mistake.
    let tree = Tree::new(Mode::Plain);
    let fill = |skip: Option<usize>, swap: Option<(usize, usize)>| {
        build(&tree, data.len(), |cvs| {
            for g in (0..groups - 1).filter(|g| Some(*g) != skip) {
                cvs[g] = tree.subtree_cv(LEVEL, g as u64, group(g));
            }
            if let Some((a, b)) = swap {
                cvs.swap(a, b);
            }
            tree.last_cv(((groups - 1) << LEVEL) as u64, group(groups - 1))
        })
    };
    assert_eq!(fill(None, None).0.as_bytes(), &want);
    let missed = refusal(|| fill(Some(9), None));
    assert!(missed.contains("child 9 is not the next subtree of its size: a value never set"), "{missed}");
    let swapped = refusal(|| fill(None, Some((4, 5))));
    assert!(swapped.contains("child 4 is not the next subtree of its size: the whole subtree at level 4 index 5"), "{swapped}");
    // The first slot of all, and the odd one out beside the last subtree.
    let first = refusal(|| fill(Some(0), None));
    assert!(first.contains("never set"), "{first}");
    let odd = refusal(|| fill(Some(groups - 2), None));
    assert!(odd.contains("never set") || odd.contains("not the next subtree"), "{odd}");
}
