# A tree API that keeps BLAKE3's shape: a compiled sketch

For [BLAKE3 #421 (TreeHasher accepts non-power-of-two left subtrees)](https://github.com/servil-software-factory/BLAKE3/issues/421), November 17, 2026. Devon Jonte.

**The question** (Zooko, November 16): "What would be the ideal API for shifting the burden onto the caller, ideally statically-checkably, to make the left subtrees be exactly the right shape?" He then held 0.10.0 for the improved `TreeHasher` API.

**The answer.** A program builds a BLAKE3 tree from chaining values: 32 bytes for each subtree, joined in pairs up to the root. Today's `TreeHasher` takes any two values as a pair, so a wrong pair gives a hash that is no BLAKE3 hash, with no error. In this sketch a wrong tree has no way through. Four parts of the tree's rule cannot be written, or stop the build. Four are compared when the program runs, in every build. `src/lib.rs` is the sketch, a layer over today's `TreeHasher` at BLAKE3-Servil `d1b4596a`. It compiles, and its tests compare it with official BLAKE3 and with bao-tree.

It is input to John's design of the library's calls. The choices I would leave to him are listed below.

## The rule, and where each part is kept

Every left child is a **whole** subtree: a power of two of full chunks (1024 bytes each), starting at a multiple of its own size. Its right sibling begins where it ends and is at most as long. The message's **last** subtree, the right child at every level down the tree's right edge, is the only one that may be shorter.

| Part of the rule | Kept by | When |
|---|---|---|
| A whole subtree's size is a power of two of chunks | Its name is `level`, for 2^level chunks: no other size can be said. For a size in bytes, `const LEVEL: u32 = level_of(PART)` | cannot be written; a constant such as 5 MiB stops the build |
| A whole subtree starts at a multiple of its size | Its name is `index`, counted in subtrees of its own size | cannot be written |
| A left child is whole | Two types: `Cv` for a whole subtree, `LastCv` for the message's last. A left child is a `Cv` | stops the build |
| A root's right child ends the message | `root_hash` takes a `LastCv` on the right. The program converts a whole subtree that ends the message (`LastCv::from`) | stops the build |
| The bytes handed over are the subtree named | `subtree_cv(level, index, input)` requires `1024 << level` bytes | compared at run time, every build |
| The last subtree is no longer than its left sibling | `last_cv(first_chunk, input)` requires 1 byte to the whole subtree aligned at `first_chunk` | compared at run time, every build |
| Two children are siblings, in order | Each value carries its place. `parent_cv`, `last_parent_cv`, `parent_cvs` and `root_hash` compare places | compared at run time, every build |
| The tree holds the whole message | `root_hash(left, right, len)` compares `len` with what the two children hold | compared at run time, every build |

A slot of an array that no call has filled (`Cv::unset()`, where today's callers write 32 zero bytes) is refused by every call that reads it.

## The calls

```rust
pub const fn level_of(len: u64) -> u32;                 // 1024 << level == len, or it stops (in a const: the build)

impl Tree {                                             // today's TreeHasher, wrapped
    pub fn subtree_cv(&self, level: u32, index: u64, input: &[u8]) -> Cv;
    pub fn subtree_halves(&self, level: u32, index: u64, input: &[u8]) -> [Cv; 2];
    pub fn last_cv(&self, first_chunk: u64, input: &[u8]) -> LastCv;
    pub fn parent_cv(&self, left: &Cv, right: &Cv) -> Cv;
    pub fn last_parent_cv(&self, left: &Cv, right: &LastCv) -> LastCv;
    pub fn parent_cvs(&self, children: &[Cv], out: &mut [Cv]);
    pub fn root_hash(&self, left: &Cv, right: &LastCv, len: u64) -> Hash;
    pub fn root_output(&self, left: &Cv, right: &LastCv, len: u64) -> OutputReader;
}
impl Cv     { pub const fn at(level: u32, index: u64, bytes: [u8; 32]) -> Cv;  pub const fn unset() -> Cv; /* as_bytes, level, index */ }
impl LastCv { pub const fn at(first_chunk: u64, len: u64, bytes: [u8; 32]) -> LastCv;  /* as_bytes, first_chunk, len */ }
impl From<Cv> for LastCv                                // a whole subtree that ends the message
```

A file hashed in pieces, as `b3sum` reads a long file (after `by_pieces` in `tests/shape.rs`):

```rust
const LEVEL: u32 = level_of(PIECE as u64);                       // a PIECE of 5 MiB stops the build here
let n = msg.len().div_ceil(PIECE);
let mut cvs: Vec<Cv> = (0..n - 1).map(|i| tree.subtree_cv(LEVEL, i as u64, piece(i))).collect();
let mut last = tree.last_cv(((n - 1) << LEVEL) as u64, piece(n - 1));
let mut next = vec![Cv::unset(); cvs.len() / 2];
while cvs.len() > 1 {
    let pairs = cvs.len() / 2;
    tree.parent_cvs(&cvs[..2 * pairs], &mut next[..pairs]);      // consecutive places from an even index
    if cvs.len() % 2 == 1 {
        last = tree.last_parent_cv(&cvs[2 * pairs], &last);      // the odd one out is the last subtree's sibling
    }
    cvs.truncate(pairs);
    cvs.copy_from_slice(&next[..pairs]);
}
tree.root_hash(&cvs[0], &last, msg.len() as u64)
```

## What the tests show

`cargo test` runs 7 tests and 5 doctests. `run-tests.stdout.txt` is the run recorded here.

| Test | What it shows |
|---|---|
| `every_allowed_build_gives_blake3s_hash` | 4,032 trees equal official BLAKE3 1.8.7: 130 lengths, plain and keyed, each built from pieces of seven sizes, by a recursive walk, and from eight random cuts into subtrees of mixed sizes |
| `the_outboard_is_bao_trees_byte_for_byte` (`tests/outboard.rs`) | `b3sum --outboard` (`b3sum/src/outboard.rs`) ported call for call, its groups hashed on 1, 3 and 16 threads: the hash and the outboard equal bao-tree 0.17.0's, at 19 lengths, plain and keyed |
| `a_slot_missed_or_misplaced_stops_the_build` | In that port, a slot never filled and two slots swapped: today's calls return a hash that is not the message's; the sketch stops and names the slot |
| `parts_of_five_mebibytes` | #421's report: today's calls take parts of 5 MiB and return another hash; the sketch takes no part of 5 MiB at any level |
| `every_wrong_shape_is_refused` | 54 wrong calls, each refused with the message of the check meant to refuse it; the same calls with right values are taken |
| `stored_values_verify_from_the_root_down` | A verifier's walk over stored pairs (verified streaming); every stored child changed alone, and a changed message byte, are found |
| `equality_is_of_place_and_bytes_and_debug_shows_the_place` | `Debug` shows a value's place and never its bytes, so a refusal's message carries no chaining value of a keyed tree |
| three `compile_fail` doctests | The three refusals at compile time; `static-refusals.txt` holds the compiler's reason for each |

**The tests can fail.** `mutants.py` removes or bends each check in `src/lib.rs`, one at a time, and runs the tests: 40 changes, 40 caught (`mutants.tsv`). Its first run caught 32 of 40. One of the eight it missed was a check that duplicated the wrapped call's, now removed. The other seven named missing tests, now added: for a layer longer than one call of the kernels, for a root whose left child begins after the message's start, for a value that was not set, and for equality.

## What it costs

`probe/` times the sketch beside today's calls: one message of 1 MiB, one core, `clocks::measure`, three runs of three turns. The sketch copies each layer's values in to the kernels and out again, so these are upper bounds for a library that keeps the place itself.

| EPYC 9275F (Zen 5, AVX-512), three runs | today | sketch | difference |
|---|---:|---:|---:|
| the parents alone: 1024 chunk values to the root | 6.15 to 6.17 µs | 9.24 µs | +50%, 3.0 ns a parent |
| the whole tree from chunk leaves | 1163.0 to 1164.9 µs | 1166.5 to 1167.1 µs | +0.13%, +0.28%, +0.35% |
| the whole tree from 16 KiB leaves (`b3sum --outboard`) | 104.4 to 105.7 µs | 105.0 to 105.6 µs | +0.04%, +0.57%, -0.16% |

Before the run I declared what I expected (in `probe/job.sh`): the parents alone 10% to 40% longer, the whole tree under 3% longer from chunk leaves, and under 0.3% from 16 KiB leaves. The parents cost more than I expected. The whole tree from chunk leaves cost less: chunk leaves hashed one at a time take 1.1 ns a byte, and the parents are 0.5% of that tree. From 16 KiB leaves the three runs disagree in sign, so the probe resolves no difference there.

The same job is queued on an EPYC 7443 (Zen 3, AVX2). Its rows go here when it reports.

## What each caller would change

- **`b3sum/src/direct.rs`** (pieces of 2 MiB): the loop above. The thread that reads the last piece calls `last_cv`.
- **`b3sum/src/outboard.rs`** (groups of 16 KiB): the same loop, keeping each layer's last value for the pre-order walk. `tests/outboard.rs` is that port.
- **`threads/src/lanes.rs`** (the pool: pieces of several sizes, shrinking): a whole piece is `subtree_cv(level_of(len), offset / len, bytes)` and the last is `last_cv(offset / 1024, bytes)`. `merge_to_children` pairs the whole values of each size and joins an odd one to the last value. Its `debug_assert`s on the cut become the calls' own checks. `subtree_cv_on`, the hidden call that names the kernels, needs a counterpart for each of the two. I have not ported it: `by_cut` in `tests/shape.rs` joins cuts of mixed sizes.
- **bao-tree's two calls** (`hash_subtree(start_chunk, data, is_root)`, `parent_cv(left, right, is_root)`, [BLAKE3 #378 (a tree API)](https://github.com/servil-software-factory/BLAKE3/issues/378)): its walker knows each node's level and index, and labels a stored value with `Cv::at` or `LastCv::at`. `stored_values_verify_from_the_root_down` does so.

## Choices I would leave to John

1. **The message's length at the root.** It catches a tree that leaves out the message's end (a loop that stops a piece early returns the hash of a prefix). It costs a parameter, and `LastCv` is 48 bytes for it. Without it `LastCv` is 40.
2. **Where the place lives.** Here each value carries it: 40 bytes, and a layer is gathered for the kernels. The other design keeps it in a layer: a type holding a level and the message's length over bare 32-byte values, with the library pairing whole layers. Values stay 32 bytes and nothing is gathered. It serves `b3sum`'s two callers, whose trees are layers of one size. The pool's cut of several sizes and a recursive walker need the calls above anyway, and a value written to the wrong slot of a layer goes unseen. I chose the value because one mechanism serves all four callers and catches that slot.
3. **The gather.** A parents kernel that reads children at a stride would end it.
4. **An input sized by its type.** `subtree_cv::<N>(index, &[u8; N])` would compare the length at compile time for a caller that holds arrays. `b3sum` and the pool hold slices, so I left it out.
5. **The unset value's bits.** All zero would make fresh zeroed memory unset.
6. **The names**, and whether a whole subtree becomes the last one by `From` or by a named call.

## A correction

On November 16 I told Zooko that two types would make `parent_cv` safe by types alone. That was wrong. Types tell a whole subtree from the last one. Two whole subtrees are siblings only when they are the same size and the left one sits at an even index. That takes each value's place, compared when the program runs.

## Limits

- The sketch wraps `d1b4596a`'s `TreeHasher`: its checks run, then today's unchecked calls. The library's own version would be one layer.
- The calls check the tree's shape. Bytes handed over for another place than the one named give a wrong hash, as with any hash call. `Cv::at` takes the caller's word for a stored value's place.
- The cost is measured on x86 servers alone, at one message size, on one core. Nothing here ran on Apple silicon.
- The pool is not ported.

## Files

| File | What it is |
|---|---|
| `src/lib.rs` | the sketch |
| `tests/shape.rs`, `tests/outboard.rs` | the tests |
| `run-tests.stdout.txt` | `cargo test`, as run for this page |
| `static-refusals.txt` | the three compile-time refusals, with the compiler's reasons |
| `mutants.py`, `mutants.tsv` | the changes tried against the tests, and each one's verdict |
| `probe/` | the timing probe: its source, each host's runs, and the job as submitted (`job.sh`), which holds every file it built. The sketch it built is the one of that hour: since then `subtree_halves` lost a check and the pages gained lines, and the calls timed are unchanged |
| `Cargo.toml`, `Cargo.lock` | the versions built: BLAKE3-Servil `d1b4596a`, official `blake3` 1.8.7, `bao-tree` 0.17.0 |

To run: `cargo test`, then `python3 mutants.py` (about three minutes).
