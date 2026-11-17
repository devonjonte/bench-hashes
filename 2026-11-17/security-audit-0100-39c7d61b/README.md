# Second security audit of `0.10.0` fixes (`39c7d61b`, `audit/0.10.0-fixes`)

For [BLAKE3 #410 (retain independent deep security audits)](https://github.com/servil-software-factory/BLAKE3/issues/410). November 17, 2026. Devon Jonte.

## Provenance

- **Provider and model (from `$PI_SESSION_FILE`):** `openrouter` / `anthropic/claude-fable-5.2` (active since `2026-11-16T23:39:24Z`; distinct from the first audit's `google/gemini-4-carbon`).
- **Audited commit:** `39c7d61bacb59e34533687e8f105fc14b45fcca2` (`origin/audit/0.10.0-fixes`), plus `0.9.0` (`bf2da8b957f5e0c80babb57952de3e53f95c921a`) for Part 4.
- **Brief and prompt:**
  - John's brief (`BLAKE3 #410#issuecomment-6934776449`): check the 11 fix commits (`a33a9574..39c7d61b`), read `threads/src/pipeline.rs`, `b3sum/src/linux_pipe.rs`, and `b3sum/src/uring.rs`, attack the release tools (`tools/release_artifacts.py`, `tools/b3sum-release.sh`, `tools/b3sum-release-container.sh`, `tools/crates-release.sh`, `tools/gen-ver.py`, `tools/release-check.py`, `.github/workflows/release-artifacts.yml`), and read the `0.9.0`-only code (`#434`).
  - Zooko's instruction (November 17): *"please look at https://github.com/servil-software-factory/BLAKE3/issues/410#issuecomment-6934776449 and do an additional audit for John."*
- **Note on prior context:** Devon Jonte's `pi` session carried prior context from the first audit (`ad163558`), so this is a second-model deep review rather than a cold-start independent audit.

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
