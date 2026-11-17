# Follow-up independent review for BLAKE3 #410

November 17, 2026. Devon Jonte. Model from the session log: `openrouter` / `openai/gpt-6-astra`, active from `2026-11-17T06:13:19.697Z`. Start `06:14:32Z`, end `13:31Z` UTC. This model did not write the reviewed changes.

The request is `request.md` (John's issue comment 6940362822). Pinned commits: b3sum `5df2bc455003289cbc1e6ccbe67443918abb3fa4`; Pipeline/model `950832cc3be8f458ee7a3aed2ffa4be34932c212`; release tools `8db36ff8533b7a14ae88649db697d4926ce84db2`. The combined candidate was `89abafc6`; landed code is `next` `4483281c`. Later candidate changes and the landed differences are in `model-revisions.diff` and `combined-io.diff`.

## Findings

- **BLAKE3 #444:** `linux_pipe.rs` reopened non-regular files by name, and reopened a large file in its no-io_uring fallback. `fifo_check.py` writes `abc` to a FIFO once. Alone, the FIFO passes; beside a regular file with `statx` delayed by `strace`, the original binary times out with no stdout. `fifo-delayed.txt` records that. `retain-open-file.patch` passes the already-open `File`; `fifo-fixed.stdout.txt` and `fifo-fixed.trace` show the corrected run. The combined candidate contains the same fix independently, plus its regression test.
- **BLAKE3 #445:** model coverage limits, not demonstrated library bugs. The stand-in masks `ACTION_SME2`, always registers successfully, and uses zero spin duration. Its lost-wake bug was fixed independently by John in `4dab5a4d`.

No new memory-safety finding in the reviewed Pipeline or release code. The release-tool negative controls show malformed archives, bad digests and forged version commits refused.

## Coverage and execution

Read: `b3sum/src/uring.rs`, `b3sum/src/linux_pipe.rs`, all of `threads/src/pipeline.rs` including unit tests, `threads/tests/shuttle_pipeline.rs`, `tools/pipeline_model_controls.py`, `tools/release_artifacts.py`, `.github/workflows/release-artifacts.yml`, `b3sum/README.md` “What b3sum reads”. For comparison, real `threads/src/lanes.rs` `mod sources` and `threads/src/waker.rs` were read. The final README was checked against `hash_open_file`, sequential reads, mappings and `direct.rs`.

Executed: FIFO original/fixed checks; 12 b3sum I/O nextest tests; 26 Pipeline nextest tests; 49 release-tool tests; `release_negative_controls.py`. The Shuttle model and its planted-fault campaign were read but not run. No fuzzing, Miri, soak testing, macOS execution or release publication was performed.

`410-summary.md`, `issue-fifo.md`, and `issue-model.md` are the public posts. Raw test output is in `io-tests.txt`, `pipeline-tests.txt`, `release-tests.txt`. Paths in traces are redacted. No binaries are included. Both manifests bind the record, excluding themselves.
