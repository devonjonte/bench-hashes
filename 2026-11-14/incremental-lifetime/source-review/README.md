# Existing shared Git context: source/configuration review

November 14, 2026. This bounded offline review follows the unresolved 6.6–9.7%
shared two-cache Git reading in the incremental-lifetime record. It collects no
new timing and changes no production code or statistical rule.

## What the records establish

Compare measured benchmark sources `8d9eb92ada887ed57b4d2102d3f913344067f84a`
and `2c8676842feab053fa7855d4cb3393bdea26ed4a` with library
`f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec`.

- The original POINTS and dispatch-use-case lists remain exact prefixes. The
  six new points were appended, preserving existing indices.
- Seven source blocks are byte-identical: roster construction, contender orders,
  the sampler, placement rules, topology lookup, the two-copy runner and sample
  visit selection. Both digests of each block are in the receipt.
- All 24 accepted common-context run headers retain the same declared contenders,
  points, 24 rounds, 100 ms warm-up/6-sample trains and shared placement configuration.
  Measuring-thread settings also agree within each old/new pair. Source/library
  pins are checked explicitly.
- Each of the three saved calibration inputs sets the multithreaded Git collection
  to one iteration. The source keeps calibration and sampling behind the selected
  roster. The new short-hasher calls therefore stay outside this seven-point scope.

The existing points retain their indices and explicit scheduling rules. This
review covers source and declared configuration. Compiled-address effects and
the CPUs used by library workers remain unresolved. Identical function sizes
in the earlier disassembly record leave those questions open too.

## What remains useful to distinguish

The sampler still allocates metadata for every POINTS entry, including unselected
ones. Adding six entries therefore changes its allocations even in the common
scope. New code and the shared incremental adapter can also change compiled
layout or preceding calls. These are plausible effects, not attributions of the
observed cost; worker placement and machine-state variation remain possible too.

One candidate control would hold a linked executable fixed and vary only its
unused bookkeeping storage, with a same-setting repeat beside it. It would keep
the seven measured points, call counts and timing path fixed. An effect would
establish that this storage perturbation can contribute in the tested setting.
A Level result would leave other placement/layout effects unresolved.

**Next:** Devon weighs that control's implementation cost before building or
collecting it. First verify that its allocation change matches the six appended
slots; use an initial three-minute probe, then decide whether more collection is
worthwhile. This proposal is unimplemented. The original adverse reading stays
open in [the context audit](https://github.com/servil-software-factory/bench-hashes/issues/210).

## Replay

From the archive's `source-review/` directory, with the benchmark Git history
available and the enclosing evidence folder checked out:

```sh
python3 context-source-check.py BENCH_REPOSITORY ..
python3 context-source-control.py context-source-check.py BENCH_REPOSITORY .. NEW_CONTROL_DIRECTORY
```

The checker reads source, header metadata and saved input settings only. The
Rust reader remains responsible for samples and comparisons. A control changes
one copied placement header; the checker rejects it. The original records stay
untouched. The successful receipt, deliberate failure and both scripts are kept.
