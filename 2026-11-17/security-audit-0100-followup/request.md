**Code review request: correctness and memory safety of our own code before 0.10.0** (for a reviewer on a model outside the Gemini family that did not write these changes)

We maintain BLAKE3-Servil (https://github.com/servil-software-factory/BLAKE3), an open-source
hashing library and the `b3sum` command-line tool. Before we release version 0.10.0 we want an
independent reviewer to read the code we changed and tell us where it is wrong. This is a
defensive review of our own code. We are not asking for exploits or proof-of-concept attacks:
a finding is "this line can read or write memory it should not", "this can return a wrong
hash", "this can hang or lose an error", with the reasoning or a small failing test.

The code is at three commits today, because the changes have not all landed yet. Start now; each
part below names its commit. I will post one combined commit here within about an hour, and
anything that differs from these will be listed with it.

- **b3sum** (parts 1 and 5): `5df2bc455003289cbc1e6ccbe67443918abb3fa4` (branch `probe/keep-safety-wip`). Work in progress on an
  older base: read `b3sum/` there and ignore the rest of that tree. The README section in part 5
  is being corrected, so do part 5 last.
- **Pipeline and its model** (parts 2 and 3): `950832cc3be8f458ee7a3aed2ffa4be34932c212`
  (branch `probe/keep-model2`).
- **Release tools** (part 4): `8db36ff8533b7a14ae88649db697d4926ce84db2` (branch `next`).

Earlier reviewers read `39c7d61b` (branch `audit/0.10.0-fixes`); compare with it where that helps.

Please read, in this order:

1. `b3sum/src/uring.rs` and `b3sum/src/linux_pipe.rs`: every `unsafe` block has a `// Sound:`
   comment giving the reason it is correct. Is each reason true? Is any buffer handed to the
   kernel freed or reused before its read completes? Do the changes for issues #437, #440,
   #441 and #442 do what their comments say?
2. `threads/src/pipeline.rs`: the same question for its `// Sound:` comments. Which thread may
   write each `UnsafeCell`, and when?
3. `threads/tests/shuttle_pipeline.rs` and `tools/pipeline_model_controls.py`: a model-checker
   test of `pipeline.rs` with a stand-in thread pool. Does the stand-in behave differently
   from the real pool (`threads/src/lanes.rs`, `mod sources`) in a way that would hide a bug?
   What bugs could this test not see?
4. `tools/release_artifacts.py` and `.github/workflows/release-artifacts.yml`: they check that
   published files were built from the tagged source. Can a file that was not pass?
5. `b3sum/README.md`, section "What b3sum reads": is every sentence true of the code?

For each finding give the file and line, what goes wrong, how sure you are, and whether you
ran anything or reasoned from the text. Say plainly which parts you did not read. Also record
the model name, the commit, and the start and end time.

Post findings as issues in the `0.10.0` milestone and a summary here.

— John Servil
