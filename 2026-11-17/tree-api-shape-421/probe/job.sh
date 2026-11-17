#!/bin/sh
# BLAKE3 #421, a probe declared before it ran (November 17, 2026): what does a chaining value that carries
# its place cost? The sketch's value is 40 bytes where today's is 32; each is compared when two are joined,
# and a layer's values are gathered for the kernels that today read them in place.
#
# One message of 1 MiB on one core, three runs of the program, each arm three turns in alternating order:
#   the parents alone (1024 chunk values to the root), today's calls and the sketch's;
#   the whole tree from chunk leaves (the parents' largest share: one compression in 17);
#   the whole tree from 16 KiB leaves (b3sum's outboard).
# Expected before running: the parents alone 10% to 40% longer; the whole tree under 3% longer from chunk
# leaves and under 0.3% from 16 KiB leaves. The sketch wraps today's calls and copies each parent twice,
# so its cost is an upper bound on a library that keeps the place itself.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/tree-shape-probe-421"
if [ "${BOUNDED_S:-}" != yes ]; then
  export BOUNDED_S=yes
  status=0
  timeout --kill-after=30s 1500s sh "$O/run.sh" || status=$?
  printf 'PROBE_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
# The build stays outside the folder that travels back, and goes when the job ends.
export CARGO_TARGET_DIR="$HOME/work/tree-shape-probe-421-target"
trap 'rm -rf "$CARGO_TARGET_DIR"' EXIT
S="$O/source"
mkdir -p "$S/src" "$S/probe/src"
cat > "$O/source/Cargo.toml" <<'EOF_FILE_0'
[package]
name = "tree-shape-sketch"
version = "0.0.0"
edition = "2024"
publish = false
description = "A compiled sketch for BLAKE3 #421: a tree API whose calls cannot build a tree that is not BLAKE3's"

[dependencies]
# BLAKE3-Servil's core at `next` of November 16, 2026: today's TreeHasher, which the sketch wraps.
blake3-servil-core = { git = "https://github.com/servil-software-factory/BLAKE3", rev = "d1b4596aaefaf5e6baf7c24fc9983333ae059e7b" }

[dev-dependencies]
# Official BLAKE3: the tests' independent hash of each message.
blake3 = { version = "=1.8.7", default-features = false, features = ["std"] }

[profile.dev]
opt-level = 1
overflow-checks = true
debug-assertions = true
EOF_FILE_0
cat > "$O/source/src/lib.rs" <<'EOF_FILE_1'
//! A sketch for BLAKE3 #421: `TreeHasher`'s calls with the tree's shape in
//! their types and in the values they pass, so that a program cannot build
//! a tree that is not BLAKE3's. It is a thin layer over today's
//! `TreeHasher` (BLAKE3-Servil `d1b4596a`), written to be compiled and
//! tested before the library changes.
//!
//! # The shape, and where each part of it is kept
//!
//! A BLAKE3 tree has one rule. Every left child is a **whole** subtree: a
//! power of two of full chunks (1024 bytes each), starting at a multiple of
//! its own size. Its right sibling begins where it ends and is no longer.
//! The message's **last** subtree, the right child at every level down the
//! tree's right edge, is the only one that may be shorter.
//!
//! | Part of the rule | Kept by |
//! |---|---|
//! | A whole subtree's size is a power of two of chunks | Its name: `level`, for 2^level chunks. No other size can be said. For a constant size, [`level_of`] in a `const` stops the build. |
//! | A whole subtree starts at a multiple of its size | Its name: `index`, counted in subtrees of its own size. |
//! | The bytes handed over are that subtree's | One comparison of the input's length, in every build. |
//! | A left child is whole | The types: a left child is a [`Cv`], and a short subtree is a [`LastCv`]. |
//! | A root's right child ends the message | The types: [`Tree::root_hash`] takes a [`LastCv`] on the right. |
//! | Two children are siblings, in order | Each value carries its place; every call that joins two compares the places, in every build. |
//! | The tree holds the whole message | [`Tree::root_hash`] takes the message's length and compares it with what its two children hold, in every build. |
//!
//! ```
//! # blake3_servil_core::initialize();
//! use tree_shape_sketch::{Tree, level_of};
//! use blake3_servil_core::{Mode, convenience};
//! // A message hashed in parts of 4 KiB: the part size is checked when this compiles.
//! const PART: usize = 4096;
//! const LEVEL: u32 = level_of(PART as u64);
//! let message = [7u8; 3 * PART + 100];
//! let tree = Tree::new(Mode::Plain);
//! let part = |i: usize| &message[i * PART..message.len().min((i + 1) * PART)];
//! let (p0, p1, p2) = (tree.subtree_cv(LEVEL, 0, part(0)), tree.subtree_cv(LEVEL, 1, part(1)), tree.subtree_cv(LEVEL, 2, part(2)));
//! let end = tree.last_cv((3 * PART / 1024) as u64, part(3));
//! let left = tree.parent_cv(&p0, &p1);
//! let right = tree.last_parent_cv(&p2, &end);
//! assert_eq!(tree.root_hash(&left, &right, message.len() as u64), convenience::hash(&message));
//! ```
//!
//! Parts of a size that is no power of two of chunks do not compile (the
//! same lines but for the size, so this fails for that reason):
//!
//! ```compile_fail
//! use tree_shape_sketch::level_of;
//! const PART: usize = 5 * 4096;
//! const LEVEL: u32 = level_of(PART as u64);
//! let _ = LEVEL;
//! ```
//!
//! A short subtree is no left child, and a root's right child is one that
//! ends the message (each the working example with one value changed):
//!
//! ```compile_fail
//! # blake3_servil_core::initialize();
//! use tree_shape_sketch::Tree;
//! let tree = Tree::new(blake3_servil_core::Mode::Plain);
//! let end = tree.last_cv(1, &[7u8; 100]);
//! let next = tree.subtree_cv(0, 2, &[7u8; 1024]);
//! let _ = tree.parent_cv(&end, &next);
//! ```
//!
//! ```compile_fail
//! # blake3_servil_core::initialize();
//! use tree_shape_sketch::Tree;
//! let tree = Tree::new(blake3_servil_core::Mode::Plain);
//! let (left, right) = (tree.subtree_cv(0, 0, &[7u8; 1024]), tree.subtree_cv(0, 1, &[7u8; 1024]));
//! let _ = tree.root_hash(&left, &right, 2048);
//! ```
//!
//! ```
//! # blake3_servil_core::initialize();
//! use tree_shape_sketch::Tree;
//! let tree = Tree::new(blake3_servil_core::Mode::Plain);
//! let (left, right) = (tree.subtree_cv(0, 0, &[7u8; 1024]), tree.subtree_cv(0, 1, &[7u8; 1024]));
//! // A whole subtree that ends the message: the program says so.
//! assert_eq!(tree.root_hash(&left, &right.into(), 2048), blake3_servil_core::convenience::hash(&[7u8; 2048]));
//! ```

use blake3_servil_core::throughput::{self, TreeHasher};
use blake3_servil_core::{CHUNK_LEN, Hash, Mode, OutputReader};

pub use blake3_servil_core::throughput::left_len;

const CHUNK: u64 = CHUNK_LEN as u64;

/// The highest level of a whole subtree: 2^53 chunks, 2^63 bytes, the left
/// half of the longest message.
pub const MAX_LEVEL: u32 = 53;

const LEVEL_SHIFT: u32 = 56;
const INDEX_MASK: u64 = (1 << LEVEL_SHIFT) - 1;
const UNSET: u64 = u64::MAX;

/// The level of whole subtrees of `len` bytes: `len` is `1024 << level`.
///
/// Requires a power of two of chunks. In a `const`, another size stops the
/// build; elsewhere it panics.
pub const fn level_of(len: u64) -> u32 {
    assert!(len >= CHUNK && len % CHUNK == 0 && (len / CHUNK).is_power_of_two(), "a whole subtree holds a power of two of chunks");
    (len / CHUNK).trailing_zeros()
}

/// A whole subtree's place, packed: its level above its index.
const fn place(level: u32, index: u64) -> u64 {
    assert!(level <= MAX_LEVEL, "a whole subtree's level is at most 53");
    // It ends at byte (index + 1) << (level + 10), within a message's 2^64 - 1.
    assert!(index < u64::MAX >> (level + 10), "the subtree ends beyond a message's last byte");
    ((level as u64) << LEVEL_SHIFT) | index
}

/// The place of the parent of the whole subtree at `place` (an even index).
const fn parent_place(place: u64) -> u64 {
    ((place & !INDEX_MASK) + (1 << LEVEL_SHIFT)) | ((place & INDEX_MASK) >> 1)
}

/// The most bytes the last subtree that begins at `first_chunk` can hold:
/// the whole subtree aligned there, as many chunks as the largest power of
/// two that divides `first_chunk` (at chunk 0, a whole message), and no
/// more than a message has left.
const fn last_max(first_chunk: u64) -> u64 {
    assert!(first_chunk <= u64::MAX / CHUNK, "the subtree starts beyond a message's last byte");
    let room = u64::MAX - first_chunk * CHUNK;
    if first_chunk == 0 {
        return room;
    }
    // first_chunk is under 2^54, so its whole subtree is 2^63 bytes or less.
    let whole = CHUNK << first_chunk.trailing_zeros();
    if whole < room { whole } else { room }
}

/// The chaining value of a **whole** subtree, with its place: 2^level
/// chunks, the `index`-th subtree of that size. The only kind a left child
/// can be.
///
/// Equality compares the place and, in constant time, the value. `Debug`
/// shows the place alone.
#[derive(Clone, Copy)]
pub struct Cv {
    value: throughput::Cv,
    place: u64,
}

impl Cv {
    /// A slot not yet filled: every call that takes a `Cv` refuses it.
    pub const fn unset() -> Self {
        Cv { value: throughput::Cv::from_bytes([0; 32]), place: UNSET }
    }

    /// A chaining value a program stored or received, for the whole
    /// subtree at `level` and `index`.
    pub const fn at(level: u32, index: u64, bytes: [u8; 32]) -> Self {
        Cv { value: throughput::Cv::from_bytes(bytes), place: place(level, index) }
    }

    /// The chaining value's 32 bytes.
    pub const fn as_bytes(&self) -> &[u8; 32] {
        self.value.as_bytes()
    }

    /// The subtree holds 2^level chunks.
    pub const fn level(&self) -> u32 {
        (self.set() >> LEVEL_SHIFT) as u32
    }

    /// The subtree is the `index`-th of its size.
    pub const fn index(&self) -> u64 {
        self.set() & INDEX_MASK
    }

    /// The place, of a value that has one.
    const fn set(&self) -> u64 {
        assert!(self.place != UNSET, "a chaining value that was never set");
        self.place
    }
}

impl core::fmt::Debug for Cv {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        if self.place == UNSET { write!(f, "a value never set") } else { write!(f, "the whole subtree at level {} index {}", self.place >> LEVEL_SHIFT, self.place & INDEX_MASK) }
    }
}

impl PartialEq for Cv {
    fn eq(&self, other: &Cv) -> bool {
        (self.place == other.place) & (self.value == other.value)
    }
}
impl Eq for Cv {}

/// The chaining value of a message's **last** subtree, with its place and
/// length: the right child at some level of the tree's right edge. It may
/// be shorter than its left sibling, and is never a left child. Its length
/// is what lets a root say how many bytes it covers
/// ([`Tree::root_hash`]).
#[derive(Clone, Copy)]
pub struct LastCv {
    value: throughput::Cv,
    first_chunk: u64,
    len: u64,
}

impl LastCv {
    /// A chaining value a program stored or received, for the last
    /// subtree: the message's last `len` bytes, which begin at its chunk
    /// `first_chunk`.
    ///
    /// Requires what [`Tree::last_cv`] does of the place and the length.
    pub const fn at(first_chunk: u64, len: u64, bytes: [u8; 32]) -> Self {
        assert!(len >= 1 && len <= last_max(first_chunk), "the last subtree holds from one byte to the whole subtree aligned at its first chunk");
        LastCv { value: throughput::Cv::from_bytes(bytes), first_chunk, len }
    }

    /// The chaining value's 32 bytes.
    pub const fn as_bytes(&self) -> &[u8; 32] {
        self.value.as_bytes()
    }

    /// The message's chunk the subtree begins at.
    pub const fn first_chunk(&self) -> u64 {
        self.first_chunk
    }

    /// The subtree's bytes.
    #[allow(clippy::len_without_is_empty)]
    pub const fn len(&self) -> u64 {
        self.len
    }
}

impl core::fmt::Debug for LastCv {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        write!(f, "the last subtree, {} bytes from chunk {}", self.len, self.first_chunk)
    }
}

impl PartialEq for LastCv {
    fn eq(&self, other: &LastCv) -> bool {
        (self.first_chunk == other.first_chunk) & (self.len == other.len) & (self.value == other.value)
    }
}
impl Eq for LastCv {}

/// A whole subtree that ends the message: the program says so.
impl From<Cv> for LastCv {
    fn from(cv: Cv) -> LastCv {
        let (level, index) = (cv.level(), cv.index());
        LastCv { value: cv.value, first_chunk: index << level, len: CHUNK << level }
    }
}

/// `TreeHasher` with the shape checked: the same work, the same kernels.
#[derive(Clone)]
pub struct Tree(TreeHasher);

impl Tree {
    /// The tree of messages hashed in `mode`.
    pub fn new(mode: Mode) -> Self {
        Tree(TreeHasher::new(mode))
    }

    /// As `TreeHasher::on_this_core`.
    pub fn on_this_core(self) -> Self {
        Tree(self.0.on_this_core())
    }

    /// The hash of a whole message: the root of one that is a single piece.
    pub fn hash(&self, input: &[u8]) -> Hash {
        self.0.hash(input)
    }

    /// The chaining value of a whole subtree: the `index`-th of 2^level
    /// chunks.
    ///
    /// Requires `input.len() == 1024 << level`, checked in every build.
    pub fn subtree_cv(&self, level: u32, index: u64, input: &[u8]) -> Cv {
        let place = place(level, index);
        assert!(input.len() as u64 == CHUNK << level, "a whole subtree at level {level} holds {} bytes (found {})", CHUNK << level, input.len());
        Cv { value: self.0.subtree_cv(index << level, input), place }
    }

    /// The two halves of the whole subtree [`subtree_cv`](Tree::subtree_cv)
    /// hashes, each a whole subtree a level down.
    ///
    /// Requires what `subtree_cv` does, and `level` of 1 or more.
    pub fn subtree_halves(&self, level: u32, index: u64, input: &[u8]) -> [Cv; 2] {
        assert!(level >= 1, "a subtree of one chunk has no halves");
        let _ = place(level, index);
        assert!(input.len() as u64 == CHUNK << level, "a whole subtree at level {level} holds {} bytes (found {})", CHUNK << level, input.len());
        let [left, right] = self.0.subtree_halves(index << level, input);
        [Cv { value: left, place: place(level - 1, 2 * index) }, Cv { value: right, place: place(level - 1, 2 * index + 1) }]
    }

    /// The chaining value of the message's last subtree: `input` is the
    /// message from its chunk `first_chunk` to its end.
    ///
    /// Requires from one byte to the whole subtree aligned at
    /// `first_chunk` (as many chunks as the largest power of two that
    /// divides it), checked in every build. That is what makes it no
    /// longer than the left sibling it will be given.
    pub fn last_cv(&self, first_chunk: u64, input: &[u8]) -> LastCv {
        let (len, max) = (input.len() as u64, last_max(first_chunk));
        assert!(len >= 1 && len <= max, "the last subtree at chunk {first_chunk} holds 1 to {max} bytes (found {len})");
        LastCv { value: self.0.subtree_cv(first_chunk, input), first_chunk, len }
    }

    /// The parent of two whole subtrees: whole, a level up.
    ///
    /// Requires siblings in order (`left` at an even index, `right` the
    /// next of its size), checked in every build.
    pub fn parent_cv(&self, left: &Cv, right: &Cv) -> Cv {
        let place = left.set();
        assert!(place & 1 == 0 && right.place == place + 1, "the children are not siblings: {left:?} and {right:?}");
        Cv { value: self.0.parent_cv(&left.value, &right.value), place: parent_place(place) }
    }

    /// The parent of a whole subtree and the message's last subtree: the
    /// last subtree a level up.
    ///
    /// Requires `left` at an even index and `right` beginning where it
    /// ends, checked in every build. (A last subtree that begins there is
    /// no longer than `left`: [`last_cv`](Tree::last_cv) saw to it.)
    pub fn last_parent_cv(&self, left: &Cv, right: &LastCv) -> LastCv {
        let (level, index) = (left.level(), left.index());
        assert!(index & 1 == 0 && right.first_chunk == (index + 1) << level, "the children are not siblings: {left:?} and {right:?}");
        LastCv { value: self.0.parent_cv(&left.value, &right.value), first_chunk: index << level, len: (CHUNK << level) + right.len }
    }

    /// A layer of parents: `out[i]` is the parent of `children[2 * i]` and
    /// `children[2 * i + 1]`.
    ///
    /// Requires an even number of children, half as many outputs, and the
    /// children consecutive whole subtrees of one size from an even index,
    /// checked in every build.
    pub fn parent_cvs(&self, children: &[Cv], out: &mut [Cv]) {
        assert_eq!(children.len() % 2, 0, "parents take their children in pairs");
        assert_eq!(out.len(), children.len() / 2, "one parent per pair of children");
        let Some(first) = children.first() else { return };
        let base = first.set();
        assert!(base & 1 == 0, "the first child is at an odd index: {first:?}");
        for (k, child) in children.iter().enumerate() {
            assert!(child.place == base + k as u64, "child {k} is not the next subtree of its size: {child:?}");
        }
        // Today's call takes bare values side by side: gather, call, label.
        const PAIRS: usize = 16;
        let mut values = [throughput::Cv::from_bytes([0; 32]); 2 * PAIRS];
        let mut parents = [throughput::Cv::from_bytes([0; 32]); PAIRS];
        for (children, out) in children.chunks(2 * PAIRS).zip(out.chunks_mut(PAIRS)) {
            for (value, child) in values.iter_mut().zip(children) {
                *value = child.value;
            }
            self.0.parent_cvs(&values[..children.len()], &mut parents[..out.len()]);
            for (i, parent) in out.iter_mut().enumerate() {
                *parent = Cv { value: parents[i], place: parent_place(children[2 * i].place) };
            }
        }
    }

    /// The root's two children, checked: `left` begins the message,
    /// `right` begins where it ends, and the two hold `len` bytes.
    fn root_children(left: &Cv, right: &LastCv, len: u64) {
        let (level, index) = (left.level(), left.index());
        assert!(index == 0 && right.first_chunk == 1 << level, "not a root's children: {left:?} and {right:?}");
        let held = (CHUNK << level) + right.len;
        assert!(held == len, "the root's children hold {held} bytes, and the message {len}");
    }

    /// The hash of the message of `len` bytes whose root has these two
    /// children.
    ///
    /// Requires `left` at the message's start, `right` beginning where it
    /// ends, and the two holding `len` bytes, checked in every build: a
    /// tree that leaves out the message's end is refused, where it would
    /// give the hash of the bytes before it.
    pub fn root_hash(&self, left: &Cv, right: &LastCv, len: u64) -> Hash {
        Self::root_children(left, right, len);
        self.0.root_hash(&left.value, &right.value)
    }

    /// The extended output of the message of `len` bytes whose root has
    /// these two children. Requires what [`root_hash`](Tree::root_hash) does.
    pub fn root_output(&self, left: &Cv, right: &LastCv, len: u64) -> OutputReader {
        Self::root_children(left, right, len);
        self.0.root_output(&left.value, &right.value)
    }
}
EOF_FILE_1
cat > "$O/source/probe/Cargo.toml" <<'EOF_FILE_2'
# PROBE for BLAKE3 #421 (never merged): what a chaining value that carries
# its place costs where it costs most, a layer of parents. Built and run on
# a measurement host; the i7 only checks that it runs.
[package]
name = "tree-shape-probe"
version = "0.0.0"
edition = "2024"
publish = false

[dependencies]
tree-shape-sketch = { path = ".." }
blake3-servil-core = { git = "https://github.com/servil-software-factory/BLAKE3", rev = "d1b4596aaefaf5e6baf7c24fc9983333ae059e7b" }
# The servil projects' one way to time (bench-hashes 0.23.0).
clocks = { git = "https://github.com/servil-software-factory/bench-hashes", rev = "cade30fdb71682719f5fa3e586ff96146ae9fc25" }

# As bench-hashes builds.
[profile.release]
opt-level = 3
lto = "fat"
codegen-units = 1
panic = "abort"
incremental = false
EOF_FILE_2
cat > "$O/source/probe/Cargo.lock" <<'EOF_FILE_3'
# This file is automatically @generated by Cargo.
# It is not intended for manual editing.
version = 4

[[package]]
name = "arrayvec"
version = "0.7.8"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "d3fb67a6e08acf24fdeccbac2cb6ac4305825bd1f117462e0e6f2f193345ad56"

[[package]]
name = "blake3-servil-core"
version = "0.9.0+dev"
source = "git+https://github.com/servil-software-factory/BLAKE3?rev=d1b4596aaefaf5e6baf7c24fc9983333ae059e7b#d1b4596aaefaf5e6baf7c24fc9983333ae059e7b"
dependencies = [
 "arrayvec",
 "blake3-servil-version",
 "cc",
 "cfg-if",
 "constant_time_eq",
 "libc",
]

[[package]]
name = "blake3-servil-version"
version = "0.9.0+dev"
source = "git+https://github.com/servil-software-factory/BLAKE3?rev=d1b4596aaefaf5e6baf7c24fc9983333ae059e7b#d1b4596aaefaf5e6baf7c24fc9983333ae059e7b"

[[package]]
name = "cc"
version = "1.11.2"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "33ef9e3e8154a45c7a95cff4c1299702106ad94062d7bb85fdc5d3a5afd91d45"
dependencies = [
 "find-msvc-tools",
 "shlex",
]

[[package]]
name = "cfg-if"
version = "1.0.5"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "4e7648175b45a9a48536d676f68d918270699102aa8dab5496df06904c914600"

[[package]]
name = "clocks"
version = "0.1.0"
source = "git+https://github.com/servil-software-factory/bench-hashes?rev=cade30fdb71682719f5fa3e586ff96146ae9fc25#cade30fdb71682719f5fa3e586ff96146ae9fc25"

[[package]]
name = "constant_time_eq"
version = "0.4.2"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "3d52eff69cd5e647efe296129160853a42795992097e8af39800e1060caeea9b"

[[package]]
name = "find-msvc-tools"
version = "0.1.15"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "1c66915cc5391097de7a2b0b972e8505aa33c0df401fd3a6811dbdb32881ba48"

[[package]]
name = "libc"
version = "0.2.191"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "65cd87c9a6d60536580b316ad985726104730a5151c99845f2490428ef91240a"

[[package]]
name = "shlex"
version = "2.0.1"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "f8fadd59c855ef2080decdef8ff161eb6661b86933c9d82e5ba29dc602a55aba"

[[package]]
name = "tree-shape-probe"
version = "0.0.0"
dependencies = [
 "blake3-servil-core",
 "clocks",
 "tree-shape-sketch",
]

[[package]]
name = "tree-shape-sketch"
version = "0.0.0"
dependencies = [
 "blake3-servil-core",
]
EOF_FILE_3
cat > "$O/source/probe/src/main.rs" <<'EOF_FILE_4'
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
EOF_FILE_4
cd "$S/probe"
# The lock is this probe's own; a host whose cargo reads it otherwise resolves again, and its lock travels back.
cargo build --release --locked 2>&1 | tail -3 || true
test -x "$CARGO_TARGET_DIR/release/tree-shape-probe" || cargo build --release 2>&1 | tail -3
rustc --version
grep -m1 'model name' /proc/cpuinfo
echo "governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo none)"
for i in 1 2 3; do
  status=0
  taskset -c 2 "$CARGO_TARGET_DIR/release/tree-shape-probe" > "$O/run-$i.tsv" 2> "$O/run-$i.stderr.txt" || status=$?
  echo "== run $i exit $status $(date -u +%H:%M:%S)"
done
echo "== done"
