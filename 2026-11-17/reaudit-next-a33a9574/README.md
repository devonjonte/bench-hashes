# Re-audit of what landed on `next` after the 0.10.0 audit: to `a33a9574`

For [BLAKE3 #410 (independent deep security audits)](https://github.com/servil-software-factory/BLAKE3/issues/410) and [BLAKE3 #433 (release 0.10.0: findings and final evidence)](https://github.com/servil-software-factory/BLAKE3/issues/433). November 17, 2026. Devon Jonte.

The audit of `ad163558` is in [`2026-11-16/security-audit-0100-ad163558/`](../../2026-11-16/security-audit-0100-ad163558/). Its fixes land on `next` one commit at a time, and each is read again here as it lands. This page covers `next` from `d1b4596a` to `a33a9574`. It is no audit of the final candidate, which gets its own.

| Commit | What it changes | Reading |
|---|---|---|
| `33acf40d` | Pages: `new b3_hasher` needs C++17; `update_reader`'s buffer is not cleared ([#430](https://github.com/servil-software-factory/BLAKE3/issues/430), [#429](https://github.com/servil-software-factory/BLAKE3/issues/429)) | One finding, below |
| `a33a9574` | The crates are packaged from a committed lock, with `--frozen` ([#436](https://github.com/servil-software-factory/BLAKE3/issues/436)) | Read: `tools/crates-release.sh`, the lock check in `tools/gen-ver.py` (name, version and checksum of every package of `b3sum/Cargo.lock`), `tools/release_artifacts.py`. No finding |

## The finding: "in an aligned member" fails before C++17

`capi/b3.h` now says: before C++17, "allocate as in C, or keep the b3_hasher on the stack or in an aligned member". A member is aligned within its object. Before C++17, `new` and `std::allocator` place that object without regard to its alignment, so the hasher inside is misplaced as often as one made by `new b3_hasher`. `b3_hasher_new` then stops the process: a crash that followed the header's advice.

`430-member.cpp` takes `struct Wrapper { int id; b3_hasher h; }` with `next`'s `b3.h` and counts misplaced hashers among 1000 objects made each way. It takes addresses alone. `430-member.out.txt` is its output from g++ 15.2.0 on x86-64 Linux with glibc:

| Standard | `new Wrapper` | `std::vector<Wrapper>` |
|---|---:|---:|
| C++11 | 750 of 1000 misplaced | 1000 of 1000 |
| C++14 | 750 of 1000 misplaced | 1000 of 1000 |
| C++17 | 0 | 0 |

To run it: `g++ -std=c++14 -O1 -I <BLAKE3>/capi 430-member.cpp && ./a.out`.

Posted on [#430](https://github.com/servil-software-factory/BLAKE3/issues/430#issuecomment-6934008571), with a wording that holds: on the stack, in static storage, or in a member of an object that is itself there.

## Candidates read before they land

Each gets its reading again when it lands, since a candidate can change in the gates.

| Candidate | Issues | Reading |
|---|---|---|
| `48151f3f` every-build checks | #419, #420 | The same patch as `919834cd`, read on November 16 |
| `8b143994` zeroize | #429 | The same patch as `353ca2f7`, read on November 16 |
| `36065305` Pipeline's drop contract (pages) | #426 | Read: it states the abort that Zooko kept. No finding |
| `fb9f2773` b3sum fail-stop | #406 to #409, #424, #425, part of #432 | One point open on [#424](https://github.com/servil-software-factory/BLAKE3/issues/424#issuecomment-6932394571): `try_pread_cached` ends a file at its size hint |

## How it was read

By Devon Jonte in `pi`. The session log records provider `openrouter` and model `anthropic/claude-fable-5.2` from 2026-11-16T23:39:24Z, which covers this page. The first audit ran under `google/gemini-4-carbon`. The reader held the first audit's notes, so this is a second reading by another model and no independent audit.
