#!/usr/bin/env python3
"""Each of the sketch's checks, removed or bent one at a time: do the tests notice?

Usage: mutants.py [NAME...]   (all when none is named)
For each mutant: src/lib.rs is rewritten with one change, `cargo test` runs (tests and doctests),
and src/lib.rs is restored. A mutant the tests fail on is caught; one they pass on survived, and
names either a missing test or a check that does nothing. Writes mutants.tsv.
"""
import subprocess
import sys
from pathlib import Path

LIB = Path('src/lib.rs')
PRISTINE = LIB.read_text()

LEN_ASSERT = 'assert!(input.len() as u64 == CHUNK << level, "a whole subtree at level {level} holds {} bytes (found {})", CHUNK << level, input.len());\n'

# (name, what the change is, old text, new text, which occurrence of old: 0 is the first)
MUTANTS = [
    ('subtree-length', "subtree_cv takes input of any length", '        let place = place(level, index);\n        ' + LEN_ASSERT, '        let place = place(level, index);\n', 0),
    ('halves-length', "subtree_halves takes input of any length", '        let _ = place(level, index);\n        ' + LEN_ASSERT, '        let _ = place(level, index);\n', 0),
    ('halves-places', "subtree_halves gives its right half the left half's place", 'place: place(level - 1, 2 * index + 1) }]', 'place: place(level - 1, 2 * index) }]', 0),
    ('subtree-chunk', "subtree_cv hashes at chunk `index`, whatever the level", 'Cv { value: self.0.subtree_cv(index << level, input), place }', 'Cv { value: self.0.subtree_cv(index, input), place }', 0),
    ('parent-even', "parent_cv takes a left child at an odd index", 'assert!(place & 1 == 0 && right.place == place + 1, "the children are not siblings', 'assert!(right.place == place + 1, "the children are not siblings', 0),
    ('parent-next', "parent_cv takes any right child", 'assert!(place & 1 == 0 && right.place == place + 1, "the children are not siblings', 'assert!(place & 1 == 0, "the children are not siblings', 0),
    ('last-parent-even', "last_parent_cv takes a left child at an odd index", 'assert!(index & 1 == 0 && right.first_chunk == (index + 1) << level, "the children are not siblings', 'assert!(right.first_chunk == (index + 1) << level, "the children are not siblings', 0),
    ('last-parent-next', "last_parent_cv takes a last subtree that begins anywhere", 'assert!(index & 1 == 0 && right.first_chunk == (index + 1) << level, "the children are not siblings', 'assert!(index & 1 == 0, "the children are not siblings', 0),
    ('last-parent-len', "last_parent_cv gives its right child's length as its own", 'len: (CHUNK << level) + right.len }', 'len: right.len }', 0),
    ('last-parent-chunk', "last_parent_cv gives its right child's first chunk as its own", 'LastCv { value: self.0.parent_cv(&left.value, &right.value), first_chunk: index << level,', 'LastCv { value: self.0.parent_cv(&left.value, &right.value), first_chunk: right.first_chunk,', 0),
    ('layer-even', "parent_cvs takes a layer from an odd index", '        assert!(base & 1 == 0, "the first child is at an odd index: {first:?}");\n', '', 0),
    ('layer-next', "parent_cvs takes children in any order", '            assert!(child.place == base + k as u64, "child {k} is not the next subtree of its size: {child:?}");\n', '', 0),
    ('layer-next-first-call', "parent_cvs checks only the children of its first call to the kernels", 'for (k, child) in children.iter().enumerate() {', 'for (k, child) in children.iter().take(2 * 16).enumerate() {', 0),
    ('layer-pairs', "parent_cvs takes an odd number of children", '        assert_eq!(children.len() % 2, 0, "parents take their children in pairs");\n', '', 0),
    ('layer-outputs', "parent_cvs takes any number of outputs", '        assert_eq!(out.len(), children.len() / 2, "one parent per pair of children");\n', '', 0),
    ('layer-parent-place', "parent_cvs gives a parent its left child's place", 'place: parent_place(children[2 * i].place) };', 'place: children[2 * i].place };', 0),
    ('root-start', "root_hash takes a left child from anywhere", 'assert!(index == 0 && right.first_chunk == 1 << level, "not a root\'s children', 'assert!(right.first_chunk == 1 << level, "not a root\'s children', 0),
    ('root-next', "root_hash takes a right child that begins anywhere", 'assert!(index == 0 && right.first_chunk == 1 << level, "not a root\'s children', 'assert!(index == 0, "not a root\'s children', 0),
    ('root-length', "root_hash takes any length", '        assert!(held == len, "the root\'s children hold {held} bytes, and the message {len}");\n', '', 0),
    ('place-level', "a place takes any level", '    assert!(level <= MAX_LEVEL, "a whole subtree\'s level is at most 53");\n', '', 0),
    ('place-end', "a place takes any index", '    assert!(index < u64::MAX >> (level + 10), "the subtree ends beyond a message\'s last byte");\n', '', 0),
    ('max-level', "the highest level is 54", 'pub const MAX_LEVEL: u32 = 53;', 'pub const MAX_LEVEL: u32 = 54;', 0),
    ('parent-place-level', "a parent's place keeps its children's level", '((place & !INDEX_MASK) + (1 << LEVEL_SHIFT)) | ((place & INDEX_MASK) >> 1)', '(place & !INDEX_MASK) | ((place & INDEX_MASK) >> 1)', 0),
    ('parent-place-index', "a parent's place keeps its left child's index", '((place & !INDEX_MASK) + (1 << LEVEL_SHIFT)) | ((place & INDEX_MASK) >> 1)', '((place & !INDEX_MASK) + (1 << LEVEL_SHIFT)) | (place & INDEX_MASK)', 0),
    ('last-start', "a last subtree starts at any chunk", '    assert!(first_chunk <= u64::MAX / CHUNK, "the subtree starts beyond a message\'s last byte");\n', '', 0),
    ('last-zero', "a last subtree at chunk 0 is sized as at any other chunk", '    if first_chunk == 0 {\n        return room;\n    }\n', '', 0),
    ('last-room', "a last subtree may end beyond the longest message", '    if whole < room { whole } else { room }', '    whole', 0),
    ('last-twice', "a last subtree may be twice the whole subtree at its place", 'let whole = CHUNK << first_chunk.trailing_zeros();', 'let whole = CHUNK << (first_chunk.trailing_zeros() + 1);', 0),
    ('last-empty', "last_cv takes no bytes", 'assert!(len >= 1 && len <= max, "the last subtree at chunk', 'assert!(len <= max, "the last subtree at chunk', 0),
    ('last-long', "last_cv takes any length", 'assert!(len >= 1 && len <= max, "the last subtree at chunk', 'assert!(len >= 1, "the last subtree at chunk', 0),
    ('last-at', "LastCv::at takes any place and length", '        assert!(len >= 1 && len <= last_max(first_chunk), "the last subtree holds from one byte to the whole subtree aligned at its first chunk");\n', '', 0),
    ('whole-as-last-len', "a whole subtree made the last one is a chunk long", 'LastCv { value: cv.value, first_chunk: index << level, len: CHUNK << level }', 'LastCv { value: cv.value, first_chunk: index << level, len: CHUNK }', 0),
    ('whole-as-last-chunk', "a whole subtree made the last one begins at chunk `index`", 'LastCv { value: cv.value, first_chunk: index << level, len: CHUNK << level }', 'LastCv { value: cv.value, first_chunk: index, len: CHUNK << level }', 0),
    ('unset', "a value never set has a place", '        assert!(self.place != UNSET, "a chaining value that was never set");\n', '', 0),
    ('level-of', "level_of takes any whole number of chunks", 'assert!(len >= CHUNK && len % CHUNK == 0 && (len / CHUNK).is_power_of_two(), "a whole subtree holds a power of two of chunks");', 'assert!(len >= CHUNK && len % CHUNK == 0, "a whole subtree holds a power of two of chunks");', 0),
    ('equal-place', "two values are equal whatever their places", '(self.place == other.place) & (self.value == other.value)', '(self.value == other.value)', 0),
    ('equal-value', "two values at one place are equal", '(self.place == other.place) & (self.value == other.value)', '(self.place == other.place)', 0),
    ('equal-last-place', "two last values are equal whatever their places", '(self.first_chunk == other.first_chunk) & (self.len == other.len) & (self.value == other.value)', '(self.value == other.value)', 0),
    ('equal-last-value', "two last values at one place are equal", '(self.first_chunk == other.first_chunk) & (self.len == other.len) & (self.value == other.value)', '(self.first_chunk == other.first_chunk) & (self.len == other.len)', 0),
    ('root-output-unchecked', "root_output checks nothing", '''    pub fn root_output(&self, left: &Cv, right: &LastCv, len: u64) -> OutputReader {
        Self::root_children(left, right, len);
''', '''    pub fn root_output(&self, left: &Cv, right: &LastCv, len: u64) -> OutputReader {
''', 0),
]


def run(name, what, old, new, which):
    assert PRISTINE.count(old) >= which + 1, f'{name}: the text to change is not in src/lib.rs'
    assert PRISTINE.count(old) == 1 or which is not None
    at = -1
    for _ in range(which + 1):
        at = PRISTINE.index(old, at + 1)
    LIB.write_text(PRISTINE[:at] + new + PRISTINE[at + len(old):])
    try:
        done = subprocess.run(['cargo', 'test', '--quiet', '--no-fail-fast'], capture_output=True, text=True, timeout=240)
    finally:
        LIB.write_text(PRISTINE)
    out = done.stdout + done.stderr
    if 'could not compile `tree-shape-sketch` (lib)' in out:
        verdict, by = 'does not build', ''
    elif done.returncode == 0:
        verdict, by = 'SURVIVED', ''
    else:
        verdict = 'caught'
        failed = sorted({line.split()[1] if line.startswith('test ') else line.strip() for line in out.splitlines()
                         if (line.startswith('test ') and line.rstrip().endswith('FAILED')) or line.startswith('---- ') and 'stdout' in line})
        by = '; '.join(f.replace('---- ', '').replace(' stdout ----', '') for f in failed) or 'a test that did not build or a doctest'
    return verdict, by


def main():
    names = sys.argv[1:]
    known = [m[0] for m in MUTANTS]
    assert len(set(known)) == len(known)
    for n in names:
        assert n in known, n
    rows = []
    for m in MUTANTS:
        if names and m[0] not in names:
            continue
        verdict, by = run(*m)
        rows.append((m[0], m[1], verdict, by))
        print(f'{m[0]}\t{verdict}\t{by}', flush=True)
    if not names:
        Path('mutants.tsv').write_text('mutant\tthe change\tverdict\tfailing tests\n' + ''.join('\t'.join(r) + '\n' for r in rows))
    survived = [r[0] for r in rows if r[2] != 'caught']
    print(f'{len(rows)} mutants, {len(rows) - len(survived)} caught; not caught: {", ".join(survived) or "none"}')


main()
