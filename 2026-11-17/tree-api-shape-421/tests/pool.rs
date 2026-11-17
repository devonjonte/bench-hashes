//! The pool's merge on the sketch: `threads/src/lanes.rs` at BLAKE3-Servil
//! `d1b4596a` cuts a message into pieces of several sizes, shrinking
//! toward its end (`cut_with_prefix`), hashes each piece on some thread,
//! and merges the values a size at a time (`merge_to_children`). Both are
//! ported here, the cut as it is and the merge call for call, and the
//! result is compared with official BLAKE3.
//!
//! The cut is the library's own and the merge trusts it: today its rules
//! are `debug_assert`s in the merge. On the sketch the calls keep them in
//! every build. The last test puts two pieces' values in each other's
//! slots, as a mistake in the pool would: today's calls return a hash that
//! is not the message's, and the sketch's stop.

use blake3_servil_core::throughput::{Cv as Bare, TreeHasher};
use blake3_servil_core::{CHUNK_LEN, Hash, Mode};
use std::panic::{AssertUnwindSafe, catch_unwind};
use tree_shape_sketch::{Cv, LastCv, Tree, level_of};

/// lanes.rs: the shortest piece, the longest, and the longest of a prefix.
const MIN_PIECE_LEN: usize = 8 * CHUNK_LEN;
const MAX_PIECE_LEN: usize = 128 * CHUNK_LEN;
const MAX_PREFIX_PIECE_LEN: usize = 1 << 20;
/// As many pairs a call as the kernels take.
const MAX_SIMD_DEGREE: usize = 16;

#[derive(Clone, Copy, Debug)]
struct Piece {
    offset: usize,
    len: usize,
}

/// lanes.rs, as it is.
fn next_piece_len(remaining: usize, threads: usize) -> usize {
    let want = (remaining / threads).clamp(MIN_PIECE_LEN, MAX_PIECE_LEN);
    1 << (usize::BITS - 1 - want.leading_zeros())
}

/// lanes.rs, as it is: `len` bytes cut into subtrees for `threads`
/// threads after a prefix of about `prefix` bytes.
fn cut_with_prefix(len: usize, threads: usize, prefix: usize) -> Vec<Piece> {
    assert!(threads >= 2 && len > MIN_PIECE_LEN && prefix < len);
    let mut pieces = Vec::new();
    let mut offset = 0;
    let first_after = next_piece_len(len - prefix, threads);
    let prefix = prefix / first_after * first_after;
    while offset < prefix {
        let piece = MAX_PREFIX_PIECE_LEN.min(1 << (usize::BITS - 1 - (prefix - offset).leading_zeros()));
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    loop {
        let piece = next_piece_len(len - offset, threads);
        if len - offset <= piece {
            break;
        }
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    pieces.push(Piece { offset, len: len - offset });
    pieces
}

/// lanes.rs's `merge_root` on the sketch. `cvs` holds the values of the
/// whole pieces (all but the last), `last` the last piece's.
///
/// At each size the longer pieces are an untouched prefix; the values
/// after it are that size's whole subtrees. They are paired through the
/// kernels, and an odd one out is the last subtree's left sibling.
fn merge_root(tree: &Tree, pieces: &[Piece], cvs: &mut [Cv], mut last: LastCv, len: usize) -> Hash {
    let whole = &pieces[..pieces.len() - 1];
    assert_eq!(whole.len(), cvs.len());
    let mut count = cvs.len();
    let mut width = MIN_PIECE_LEN;
    let mut out = [Cv::unset(); MAX_SIMD_DEGREE];
    while count > 1 {
        let prefix = whole.partition_point(|p| p.len > width);
        let (mut read, mut write) = (prefix, prefix);
        while read + 1 < count {
            let children = (count - read).min(2 * MAX_SIMD_DEGREE) & !1;
            let parents = children / 2;
            tree.parent_cvs(&cvs[read..read + children], &mut out[..parents]);
            cvs[write..write + parents].copy_from_slice(&out[..parents]);
            read += children;
            write += parents;
        }
        if read < count {
            last = tree.last_parent_cv(&cvs[read], &last);
        }
        count = write;
        width *= 2;
    }
    tree.root_hash(&cvs[0], &last, len as u64)
}

/// Each piece's value, as a thread of the pool would hash it.
fn piece_cvs(tree: &Tree, msg: &[u8], pieces: &[Piece]) -> (Vec<Cv>, LastCv) {
    let (end, whole) = pieces.split_last().unwrap();
    let cvs = whole.iter().map(|p| tree.subtree_cv(level_of(p.len as u64), (p.offset / p.len) as u64, &msg[p.offset..p.offset + p.len])).collect();
    (cvs, tree.last_cv((end.offset / CHUNK_LEN) as u64, &msg[end.offset..end.offset + end.len]))
}

fn painted(len: usize) -> Vec<u8> {
    (0..len).map(|i| (i.wrapping_mul(131) ^ (i >> 7)) as u8).collect()
}

#[test]
fn the_pools_cut_and_merge_give_blake3s_hash() {
    blake3_servil_core::initialize();
    let all = painted(3 * (1 << 20) + 300 * CHUNK_LEN + 77);
    let key = [0x17u8; 32];
    let mut lens = vec![MIN_PIECE_LEN + 1, 2 * MIN_PIECE_LEN, 2 * MIN_PIECE_LEN + 1, 3 * MIN_PIECE_LEN - 1, 100_000, 512 * 1024, 512 * 1024 + 1];
    lens.extend([(1 << 20) - 1, 1 << 20, (1 << 20) + CHUNK_LEN, 1_500_000, 2 << 20, (2 << 20) + 8 * CHUNK_LEN + 5, all.len()]);
    let (mut cuts, mut sizes) = (0, std::collections::BTreeSet::new());
    for &len in &lens {
        let msg = &all[..len];
        let (plain, keyed) = (*blake3::hash(msg).as_bytes(), *blake3::keyed_hash(&key, msg).as_bytes());
        for threads in [2, 3, 4, 7, 8, 16, 20, 64] {
            for prefix in [0, len / 3, len / 2, len - 1] {
                let pieces = cut_with_prefix(len, threads, prefix);
                assert!(pieces.len() >= 2);
                sizes.extend(pieces.iter().map(|p| p.len));
                for (mode, want) in [(Mode::Plain, plain), (Mode::Keyed(&key), keyed)] {
                    let tree = Tree::new(mode);
                    let (mut cvs, last) = piece_cvs(&tree, msg, &pieces);
                    assert_eq!(merge_root(&tree, &pieces, &mut cvs, last, len).as_bytes(), &want, "len={len} threads={threads} prefix={prefix}");
                }
                cuts += 1;
            }
        }
    }
    // The cuts tried hold pieces of many sizes, the pool's longest among them.
    assert!(cuts == 14 * 8 * 4 && sizes.contains(&MAX_PREFIX_PIECE_LEN) && sizes.contains(&MAX_PIECE_LEN) && sizes.contains(&MIN_PIECE_LEN), "{cuts} cuts, sizes {sizes:?}");
}

/// Today's merge (lanes.rs's `merge_root`), the values bare.
fn merge_root_today(tree: &TreeHasher, pieces: &[Piece], cvs: &mut [Bare]) -> Hash {
    let mut count = cvs.len();
    let mut width = MIN_PIECE_LEN;
    let mut out = [Bare::from_bytes([0; 32]); MAX_SIMD_DEGREE];
    while count > 2 {
        let prefix = pieces.partition_point(|p| p.len > width);
        let (mut read, mut write) = (prefix, prefix);
        while read + 1 < count {
            let children = (count - read).min(2 * MAX_SIMD_DEGREE) & !1;
            let parents = children / 2;
            tree.parent_cvs(&cvs[read..read + children], &mut out[..parents]);
            cvs[write..write + parents].copy_from_slice(&out[..parents]);
            read += children;
            write += parents;
        }
        if read < count {
            cvs[write] = cvs[read];
            write += 1;
        }
        count = write;
        width *= 2;
    }
    tree.root_hash(&cvs[0], &cvs[1])
}

/// The message `f` panics with.
fn refusal<T>(f: impl FnOnce() -> T) -> String {
    let payload = catch_unwind(AssertUnwindSafe(f)).err().expect("the call is refused");
    payload.downcast_ref::<String>().cloned().or_else(|| payload.downcast_ref::<&str>().map(|s| s.to_string())).unwrap_or_default()
}

/// A cut that is not the tree's: two neighbouring pieces of unlike sizes
/// the wrong way round (the long piece after the short one), their values
/// in each other's slots. Today's `subtree_cv` refuses to hash the long
/// piece at its bent place, and that is all today's calls check: given the
/// two values, the merge returns a hash that is not the message's (the
/// pool's `debug_assert`s on its cut are not in a release build). On the
/// sketch the bent piece cannot be named, since its start is no multiple of
/// its size, and the merge stops at the first join that reads a value out
/// of its place.
#[test]
fn a_bent_cut_stops_the_merge() {
    blake3_servil_core::initialize();
    let len = 600 * CHUNK_LEN + 9;
    let msg = painted(len);
    let want = *blake3::hash(&msg).as_bytes();
    let pieces = cut_with_prefix(len, 4, 0);
    // Two neighbours of unlike sizes, the long one first as the cut has them.
    let at = (0..pieces.len() - 2).find(|&i| pieces[i].len == 2 * pieces[i + 1].len).expect("the cut shrinks by halves somewhere");
    let (long, short) = (pieces[at], pieces[at + 1]);
    let mut bent = pieces.clone();
    bent[at] = Piece { offset: long.offset, len: short.len };
    bent[at + 1] = Piece { offset: long.offset + short.len, len: long.len };

    // Today, in a release build: the right cut gives the hash, the bent one another hash.
    let today = TreeHasher::new(Mode::Plain);
    let bare = |pieces: &[Piece]| -> Vec<Bare> { pieces.iter().map(|p| today.subtree_cv((p.offset / CHUNK_LEN) as u64, &msg[p.offset..p.offset + p.len])).collect() };
    assert_eq!(merge_root_today(&today, &pieces, &mut bare(&pieces)).as_bytes(), &want);
    // The long piece now starts where no subtree of its size does: today's subtree_cv stops there.
    let stopped = refusal(|| bare(&bent));
    assert!(stopped.contains("holds at most"), "{stopped}");
    // Its value taken from elsewhere (a stored value, another thread's slot), the merge returns a hash.
    let mut values = bare(&pieces);
    values.swap(at, at + 1);
    assert_ne!(merge_root_today(&today, &bent, &mut values).as_bytes(), &want, "today: a bent cut's merge returns a hash");

    // The sketch: the bent piece has no name (its start is no multiple of its size).
    let tree = Tree::new(Mode::Plain);
    assert_ne!((long.offset + short.len) % long.len, 0);
    // Its value put in the other's slot: the merge stops at the first join that reads it.
    let (mut cvs, last) = piece_cvs(&tree, &msg, &pieces);
    cvs.swap(at, at + 1);
    let stopped = refusal(|| merge_root(&tree, &bent, &mut cvs, last, len));
    assert!(stopped.contains("is not the next subtree of its size") || stopped.contains("not siblings") || stopped.contains("odd index"), "{stopped}");
    // And the right cut merges.
    let (mut cvs, last) = piece_cvs(&tree, &msg, &pieces);
    assert_eq!(merge_root(&tree, &pieces, &mut cvs, last, len).as_bytes(), &want);
}
