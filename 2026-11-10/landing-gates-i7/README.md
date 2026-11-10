# The i7's speed gates for four landings on BLAKE3-Servil `next`, November 10, 2026

**Question.** Does each candidate make any measured cell slower on the
i7-12700K, against the `next` it lands on?

**Verdict.** No cell slower, for each of the three gates here. The fourth
landing, #329, has its gate in `../next-segv-pipeline-i7/third-sighting/`
(first round no cell slower; its confirmation round stopped when the old
side, `next`, took a segfault from BLAKE3 #302's race) and its earlier
complete gate in `../../2026-11-09/pipeline-no-alloc-i7/`.

| Folder | Candidate | New side | Old side | Points |
|---|---|---|---|---|
| `248-round-up/` | BLAKE3 #248, landed through #345 | d3e907a8 | `next` a4095ba6 | 1 KiB, 2304 B, 3 KiB, 3839 B, 4470 B, 7935 B, 16 KiB, idle 3 KiB |
| `276-pause-stop/` | BLAKE3 #276 | e0f96d77 | d3e907a8 | continuous 64 B, continuous 1 KiB, continuous 16 KiB, 64 B, 1 MiB |
| `328-build-version/` | BLAKE3 #328 | 98654c33 | `next` a4095ba6 | 64 B, 1 KiB, 16 KiB, continuous 64 B, continuous 1 KiB, 1 MiB |

The heads that landed differ from the measured ones by a rebase, and for
#248 by a repair to `src/test.rs` alone (#345): the library sources each
gate measured are the ones that landed.

**Commands.** `gate-stack.sh` (#248 and #276: suites, builds, mutation
checks, then `bench-hashes check`) and `gate-328.sh`, each run from the
night's queue under `run-bounded.py`. Bench: eb1002b8 (`next` of
bench-hashes). Their whole output: `gate-stack.stdout.txt`,
`gate-328.stdout.txt`, and the `.stderr.txt` beside each.

**#248's gain on this head.** `248-round-up/compare.md` is `bench-hashes
compare --markdown` over the first round's four pairs: leans, since four
pairs give no verdict on size. Single-threaded 3 KiB x0.782, 4470 B
x0.883, 3 KiB after a pause x0.555.

**Posted.** [BLAKE3 #345](https://github.com/servil-software-factory/BLAKE3/pull/345),
[#276](https://github.com/servil-software-factory/BLAKE3/pull/276),
[#328](https://github.com/servil-software-factory/BLAKE3/pull/328),
[#329](https://github.com/servil-software-factory/BLAKE3/pull/329).

**Machine.** i7-12700K, Linux, mains power; each check waited for a quiet
machine (`--when-quiet`).
