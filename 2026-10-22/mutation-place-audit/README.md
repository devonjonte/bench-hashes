# Mutation-place and shard audit — October 22, 2026

## Question and findings

Do the retained records establish the reported fluctuating feed/prefix
mutants? Did the map run one shard at a time?

**The retained place-specific outcomes agree.** The earlier fluctuation
claim needs correcting: aggregate `NOW CAUGHT` differences compare a run
with the expected survivor list. They establish neither a flip between two
runs nor which same-named place changed.

| Mutation | Retained run | Place-keyed map |
| --- | --- | --- |
| feed, minus to plus at 169:33 | missed | missed |
| feed, minus to plus at 189:45 | caught | caught |
| sme2_prefix, multiply to divide at column 59 | missed (line490) | missed (line479) |
| sme2_prefix, multiply to divide at column 44 | caught (line490) | caught (line479) |

The three full-run stdout logs each print the 169 miss. They contain no 189
miss report. The retained raw run and map JSON explicitly classify 189 as
caught. The known-x86_64 counts at servil `216377a8` are 1 for each feed minus replacement
and the prefix multiply-to-divide name, consistent with these places.

Both tests recorded catching 189 are serial digest tests at map commit
`b399810c0c022086a655feb64c9a64e1a5998824`:
- `test_grouped_hash` hashes fixed-offset subtrees through `Hasher::update`.
  The retained log fails at **6145 bytes in subtrees of 4 chunks**.
- `test_merge_every_cut` simulates the cuts for logical thread counts and
  hashes those pieces serially. Its loop itself starts no workers.

Their source does not support worker-progress changes as the explanation
for a flip in those two tests. Other mutants and other historical runs
retain their own scope. These receipts supply no general claim that every
mutation test is timing-independent. The map source is named by its commit.
The retained run JSON lacks a standalone HEAD receipt, which limits it to
a scoped diagnostic.

## Shard correction

The original map README claimed SHARDS=1. Its actual data has **146 distinct
baseline tests, each recorded 6 times**. `run-map.py` assigned the global
SHARDS after import. `run(..., shards=SHARDS)` had already bound six as its
default, and the checker launches all shards before waiting. The included
`shard-default.txt` records a read-only import inspection:

```text
before override: SHARDS 6 run defaults ((), 6, 'run')
after override: SHARDS 1 run defaults ((), 6, 'run')
```

Thus the completed map used **six concurrent shards**, with
CARGO_BUILD_JOBS=2 and NEXTEST_TEST_THREADS=4. The corrected README keeps all
original tests.tsv rows intact. A future single-shard caller passes the existing `shards=1` argument
explicitly.

## Receipts and reproduction

Four `*-outcomes.json` files preserve cargo-mutants' original records from
`BLAKE3-mini/tmp/mutants-last/{run,map}/shard*`. The map log preserves the
actual 189 failure, test names and compiler/test commands. Full-run stdout,
original launcher and source-matched checker are included. No new mutation
run or timing intervention was performed for this audit.

From this folder, inspect the baseline multiplicity:

```sh
pypy3 - <<'PY'
import csv, collections
with open('../../2026-10-21/x86-map/tests.tsv') as f:
    tests = collections.Counter(r[4] for r in csv.reader(f, delimiter='\t')
                                if r[0] == '(unmutated)')
print(collections.Counter(tests.values()))  # Counter({6: 146})
PY
```

For each raw JSON, inspect `outcomes[*].scenario.Mutant.name` and `summary`.
The original map and the new qualification are linked from
[the x86 mutation-list discussion](https://github.com/johnservil/BLAKE3/pull/115).
