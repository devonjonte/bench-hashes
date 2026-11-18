// Verbatim from threads/src/lanes.rs at 2ef4c443: next_piece_len, cut_with_prefix, sme2_prefix.
const CHUNK_LEN: usize = 1024;
const MIN_PIECE_LEN: usize = 8 * CHUNK_LEN;
const MAX_PIECE_LEN: usize = 128 * CHUNK_LEN;
const MAX_PREFIX_PIECE_LEN: usize = 1 << 20;
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Piece { offset: usize, len: usize }
fn next_piece_len(remaining: usize, threads: usize) -> usize {
    debug_assert!(threads > 0, "a cut needs at least one thread");
    let want = (remaining / threads).clamp(MIN_PIECE_LEN, MAX_PIECE_LEN);
    1 << (usize::BITS - 1 - want.leading_zeros())
}
fn cut_with_prefix(pieces: &mut Vec<Piece>, len: usize, threads: usize, prefix: usize) -> usize {
    assert!(threads >= 2, "a serial call hashes the input whole");
    assert!(len > MIN_PIECE_LEN, "one piece has no parent to merge; hash it whole instead");
    assert!(prefix < len, "the SME2 thread's prefix leaves the pool some input");
    let mut offset = 0;
    let first_after = next_piece_len(len - prefix, threads);
    let prefix = prefix / first_after * first_after;
    while offset < prefix {
        let piece = MAX_PREFIX_PIECE_LEN.min(1 << (usize::BITS - 1 - (prefix - offset).leading_zeros()));
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    let own = pieces.len();
    loop {
        // What is left is the last piece once a share would take it all
        // (a share is MIN_PIECE_LEN at least, so this ends).
        let piece = next_piece_len(len - offset, threads);
        if len - offset <= piece {
            break;
        }
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    pieces.push(Piece { offset, len: len - offset });
    own
}
fn cut_capped(pieces: &mut Vec<Piece>, len: usize, threads: usize, prefix: usize) -> usize {
    assert!(threads >= 2, "a serial call hashes the input whole");
    assert!(len > MIN_PIECE_LEN, "one piece has no parent to merge; hash it whole instead");
    assert!(prefix < len, "the SME2 thread's prefix leaves the pool some input");
    let mut offset = 0;
    let first_after = next_piece_len(len - prefix, threads);
    let prefix = prefix / first_after * first_after;
    while offset < prefix {
        let piece = MAX_PREFIX_PIECE_LEN.min(1 << (usize::BITS - 1 - (prefix - offset).leading_zeros()));
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    let own = pieces.len();
    // 0.8.0's cap (removed by 4490da41): a piece after the prefix is no longer than the one before it.
    let mut cap = if own > 0 { pieces[own - 1].len } else { MAX_PIECE_LEN };
    loop {
        // What is left is the last piece once a share would take it all
        // (a share is MIN_PIECE_LEN at least, so this ends).
        let piece = next_piece_len(len - offset, threads).min(cap);
        if len - offset <= piece {
            break;
        }
        pieces.push(Piece { offset, len: piece });
        offset += piece;
        cap = piece;
    }
    pieces.push(Piece { offset, len: len - offset });
    own
}

fn cut_settled(pieces: &mut Vec<Piece>, len: usize, threads: usize, prefix: usize) -> usize {
    assert!(threads >= 2, "a serial call hashes the input whole");
    assert!(len > MIN_PIECE_LEN, "one piece has no parent to merge; hash it whole instead");
    assert!(prefix < len, "the SME2 thread's prefix leaves the pool some input");
    let mut offset = 0;
    let mut unit = next_piece_len(len - prefix, threads);
    let prefix = loop {
        let rounded = prefix / unit * unit;
        let after = next_piece_len(len - rounded, threads);
        if after == unit {
            break rounded;
        }
        unit = after;
    };
    while offset < prefix {
        let piece = MAX_PREFIX_PIECE_LEN.min(1 << (usize::BITS - 1 - (prefix - offset).leading_zeros()));
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    let own = pieces.len();
    loop {
        // What is left is the last piece once a share would take it all
        // (a share is MIN_PIECE_LEN at least, so this ends).
        let piece = next_piece_len(len - offset, threads);
        if len - offset <= piece {
            break;
        }
        pieces.push(Piece { offset, len: piece });
        offset += piece;
    }
    pieces.push(Piece { offset, len: len - offset });
    own
}

fn sme2_prefix(len: usize, threads: usize) -> usize {
    let share = len / (100 + (threads - 1) * 10000 / 165) * 100;
    if share >= MAX_PIECE_LEN { share } else { 0 }
}

/// merge_to_children's walk over sizes and places alone (threads/src/lanes.rs at 2ef4c443), with the place checks
/// of parent_cvs, last_parent_cv and the root. Err names the first check that would stop the process.
fn merge(pieces: &[Piece], len: usize) -> Result<(), &'static str> {
    const DEG: usize = 16;
    let whole = &pieces[..pieces.len() - 1];
    if whole.is_empty() { return Err("two pieces or more"); }
    let mut cvs: Vec<(u32, u64)> = Vec::with_capacity(whole.len());
    for p in whole {
        if !(p.len % 1024 == 0 && (p.len / 1024).is_power_of_two()) { return Err("level_of"); }
        let level = (p.len / 1024).trailing_zeros(); let chunk = (p.offset / 1024) as u64;
        if (chunk >> level) << level != chunk { return Err("a piece off its place"); }
        cvs.push((level, chunk >> level));
    }
    let end = pieces[pieces.len() - 1];
    let fc = (end.offset / 1024) as u64;
    let max = if fc == 0 { u64::MAX } else { 1024u64 << fc.trailing_zeros() };
    if !(end.len >= 1 && end.len as u64 <= max) { return Err("last_cv bound"); }
    let mut last = (fc, end.len as u64);
    let mut count = cvs.len(); let mut width = MIN_PIECE_LEN;
    while count > 1 {
        let prefix = whole.partition_point(|p| p.len > width);
        let (mut read, mut write) = (prefix, prefix);
        while read + 1 < count {
            let children = (count - read).min(2 * DEG) & !1;
            let base = cvs[read];
            if base.1 % 2 != 0 { return Err("first child at an odd index"); }
            for k in 0..children { if cvs[read + k] != (base.0, base.1 + k as u64) { return Err("not the next subtree"); } }
            for i in 0..children / 2 { let c = cvs[read + 2 * i]; cvs[write + i] = (c.0 + 1, c.1 / 2); }
            read += children; write += children / 2;
        }
        if read < count {
            let (l, ix) = cvs[read];
            if !(ix % 2 == 0 && last.0 == (ix + 1) << l) { return Err("last_parent_cv siblings"); }
            last = (ix << l, (1024u64 << l) + last.1);
        }
        if write >= count { return Err("a level of the tree merged nothing"); }
        count = write; width *= 2;
    }
    let (l, ix) = cvs[0];
    if !(ix == 0 && last.0 == 1 << l && (1024u64 << l) + last.1 == len as u64) { return Err("root"); }
    Ok(())
}

fn main() {
    let (mut tried, mut stops, mut bound, mut differ) = (0u64, 0u64, 0u64, 0u64);
    let (mut now, mut capped) = (Vec::new(), Vec::new());
    let mut first = String::new();
    for threads in 2..=64usize {
        for k in 9..=70_000usize {
            for tail in [0usize, 1] {
                let len = k * 1024 + tail;
                let share = sme2_prefix(len, threads);
                if share == 0 { continue; }
                now.clear(); capped.clear();
                cut_with_prefix(&mut now, len, threads, share);
                cut_capped(&mut capped, len, threads, share);
                tried += 1;
                if merge(&capped, len).is_err() { stops += 1; }
                if capped != now { differ += 1; if merge(&now, len).is_err() { bound += 1; } if first.is_empty() { first = format!("{threads} threads, {len} bytes"); } }
            }
        }
    }
    println!("with the cap (the code of 0.8.0): {tried} cuts with an SME2 share, {stops} stop");
    println!("cuts where the cap changes a piece: {differ} (first: {first}); of those, cuts that stop without the cap: {bound}");
}
