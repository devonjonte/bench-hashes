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
//! | The last subtree is no longer than its left sibling | [`Tree::last_cv`] takes from one byte to the whole subtree aligned at its first chunk, in every build. One that begins where a left child ends is then no longer than that child. |
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
    /// Requires what `subtree_cv` does, and `level` of 1 or more (today's
    /// call, which this one wraps, refuses one chunk).
    pub fn subtree_halves(&self, level: u32, index: u64, input: &[u8]) -> [Cv; 2] {
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
