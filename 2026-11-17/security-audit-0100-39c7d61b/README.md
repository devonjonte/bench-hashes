# Second security audit of `0.10.0` fixes (`39c7d61b`, `audit/0.10.0-fixes`)

For [BLAKE3 #410 (retain independent deep security audits)](https://github.com/servil-software-factory/BLAKE3/issues/410). November 17, 2026. Devon Jonte.

## Provenance

- **Provider and model (from `$PI_SESSION_FILE`):** `openrouter` / `anthropic/claude-fable-5.2` (active since `2026-11-16T23:39:24Z`; distinct from the first audit's `google/gemini-4-carbon`).
- **Audited commit:** `39c7d61bacb59e34533687e8f105fc14b45fcca2` (`origin/audit/0.10.0-fixes`), plus `0.9.0` (`bf2da8b957f5e0c80babb57952de3e53f95c921a`) for Part 4.
- **Brief and prompt:**
  - John's brief (`BLAKE3 #410#issuecomment-6934776449`): check the 11 fix commits (`a33a9574..39c7d61b`), read `threads/src/pipeline.rs`, `b3sum/src/linux_pipe.rs`, and `b3sum/src/uring.rs`, attack the release tools (`tools/release_artifacts.py`, `tools/b3sum-release.sh`, `tools/b3sum-release-container.sh`, `tools/crates-release.sh`, `tools/gen-ver.py`, `tools/release-check.py`, `.github/workflows/release-artifacts.yml`), and read the `0.9.0`-only code (`#434`).
  - Zooko's instruction (November 17): *"please look at https://github.com/servil-software-factory/BLAKE3/issues/410#issuecomment-6934776449 and do an additional audit for John."*
- **Note on prior context:** Devon Jonte's `pi` session carried prior context from the first audit (`ad163558`), so this is a second-model deep review rather than a cold-start independent audit.

## Corrections (November 17, 2026, after a recheck of this record)

The text below stands as first published. These four statements in it were wrong or stronger than the work done:

1. **#438 is withdrawn: a false finding.** The reproduction fetched the tag alone. The `clean` job checks out with `fetch-depth: 0`, and `actions/checkout@v4` then fetches `+refs/heads/*:refs/remotes/origin/*` and every tag (`src/ref-helper.ts`). A fetch with those two refspecs of the real repository has `refs/remotes/origin/main`, so `on_main()` answers. This audit has **two** findings, #437 and #439.
2. **Part 4 was not done when this was published.** Only `b3sum/src/readahead.rs` was read in that pass; `main.rs` and `lanes.rs` had been read earlier, under another model, for #434. Part 4 was then done on November 17 under `anthropic/claude-fable-5.2`: the 458 lines removed from `threads/src/lanes.rs` and the 314 removed from `b3sum/src/main.rs` since `bf2da8b9`, read as a diff, with `main.rs`'s three unsafe sites (`mapped`, `resident`, `hold`) and the pool's public callers (`hash_many_multithreaded`, `hash_each_multithreaded`, `subtree_children`) read in full at `bf2da8b9`. No finding beyond #434. The removed `Task`/`Source::push` stream code is `#[cfg(test)]` in 0.9.0 (`mod stream` in `threads/src/lib.rs:245`). Nothing was run.
3. **Part 2, "read completely":** `linux_pipe.rs` and `uring.rs` whole; `pipeline.rs` its non-test code (to about line 2050), once, without the tests below it.
4. **Part 1, "verified closed":** by a before/after run for #406, #407, #408, #417, #420, #423, #424, #425 and #432's flags; by reading the diff and the commit's own tests for #418, #419, #426, #427, #429, #414/#428.

**#437:** the ring's behaviour is measured (`repro-defer-taskrun-cold.txt`); the hang itself is argued from the code and was not reproduced end to end. John confirmed the path by reading.

## Findings

Three new findings opened in milestone `0.10.0` with label `release-blocker` and assigned to `johnservil`:

1. **[BLAKE3 #437](https://github.com/servil-software-factory/BLAKE3/issues/437)** — `b3sum/src/linux_pipe.rs:195–199, 263–269` (`stream_fd_into_rooms`): when `commit_ready` is true, `first_err.is_some()`, and `in_flight_uring > 0`, `ring.submit_and_wait` is skipped. Under `Uring::new`'s `IORING_SETUP_DEFER_TASKRUN` (`uring.rs:155`), cold reads post 0 CQEs until `submit_and_wait(1)` enters with `IORING_ENTER_GETEVENTS` (`repro-defer-taskrun-cold.txt`), so `stream_fd_into_rooms` spins forever instead of returning the error.
2. **[BLAKE3 #438](https://github.com/servil-software-factory/BLAKE3/issues/438)** — `.github/workflows/release-artifacts.yml:52–56, 73–76`: `actions/checkout@v4` with an explicit tag `ref` fetches only that tag and omits `refs/remotes/origin/main`. `release_artifacts.py "$TAG" --published --rebuilt rebuilt` then calls `on_main()`, gets `None`, prints `MISSING origin/main in this clone`, and exits 1 (`repro-release-tools.out.txt`).
3. **[BLAKE3 #439](https://github.com/servil-software-factory/BLAKE3/issues/439)** — `tools/release_artifacts.py:147–148, 234–265, 322`: `crate_problems` without `--rebuilt` (the command `SECURITY.md` gives users) skips root tar entries without `/`, ignores directory prefixes, and overwrites duplicate tar members in a dict comprehension; `published` skips `.sha256`/`.b3` assets; `stamp_problems` passes deleted or duplicated stamps on a line that held one (`repro-release-tools.out.txt`).

## Coverage summary (Parts 1–4)

- **Part 1 (the 11 commits in `a33a9574..39c7d61b`):**
  - `220d5824` (#419, #420), `9bf167e9` (#417, #418), `f72215b3` (#427), `c14f34cd` (#423), `a766df23` (#429), `0ee045e9` (#414, #428), `06e0cb4c` (#426 docs), `f780a02e` + `39c7d61b` (#406–#409, #424, #425, `--no-mmap`/`--check --seek`/links of #432), `b0fe1181` (`SECURITY.md`): verified closed.
  - `#432` control-character and `-` checkfile rules (decided by Zooko after `f780a02e`) remain open on `#432`.
  - `#430` C++ pre-C++17 header wording (`"or in an aligned member"` landed on `next` `33acf40d`) remains open in `#430#issuecomment-6934008571`.
  - `b52d0fa6`: see #438 and #439.
- **Part 2 (`threads/src/pipeline.rs`, `b3sum/src/linux_pipe.rs`, `b3sum/src/uring.rs`):** read completely. One finding (#437).
- **Part 3 (release tools and `.github/workflows/release-artifacts.yml`):** `python3 tools/test_release_check.py`, `test_release_artifacts.py`, `test_gen_ver.py`, `test_land.py` all pass (91 tests). Two findings (#438, #439).
- **Part 4 (`0.9.0` `bf2da8b957f5` `readahead.rs`, `main.rs`, `lanes.rs`):** read under `anthropic/claude-fable-5.2`; no additional finding beyond `#434`.

## Limits

- Static reading plus targeted local reproductions on `x86_64` Linux `7.0.0-43-generic`; no fuzzing, soak, or differential campaign.
- No macOS / Apple Silicon execution of `0ee045e9`.
