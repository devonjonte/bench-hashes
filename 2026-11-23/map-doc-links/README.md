# The published maps' links to BLAKE3-Servil's documentation: found dead, repaired (November 23, 2026)

**Question.** Each small chart on a bench-hashes map names the BLAKE3-Servil call it measures, and the name links the call's page in the library's documentation. Do those links answer?

**Verdict.** On the thirteen published maps of bench-hashes 0.22 and 0.24, 342 of the 445 links were dead. For 329 of them the map named a call in the library's `throughput` module and linked its page under the module's former name, `performance`. Those are repaired: in the program, which now computes a call's page from its name, and on the thirteen stored maps by an exact patch. Thirteen links stay dead: the 0.22 maps name `throughput::Hasher::update_multithreaded`, a method the library no longer has. The older maps (0.18 to 0.20) name `performance::` calls on the library's former site and were left as they are.

**Where it was posted.** [bench-hashes pull request 267](https://github.com/servil-software-factory/bench-hashes/pull/267).

## The commits

On bench-hashes `next` at `2a223359a711585ec6705c2279acc1f860f99851`:

- `36fdfb82b`: `src/map.rs` gains `doc_page()`, which gives a call's page from its name (`MODULE::function`, `MODULE::Type`, `MODULE::Type::method`); `place()` and `one_thread_call()` carry names alone.
- `d1ea0d438`: the thirteen stored maps, patched, with each folder's `SHA256SUMS` and `BLAKE3SUMS` bound to the new file.

The pull request landed by rebase: `next` holds the same two changes as `15e4307ff` and `9ae9e8962c180316374f49d9bb0e094a6f24cd6f`.

## What is here, and the commands

| File | What | Command, in the bench-hashes checkout |
|---|---|---|
| `links-before.txt` | every distinct call and page the stored maps link, and whether the page answers, at `2a223359` | `python3 check-links.py .` |
| `links-after.txt` | the same at `d1ea0d438` | `python3 check-links.py .` |
| `patch-links.txt` | the patch's own report: the maps it changed, the links in each, the digests before and after | `python3 patch-links.py . --write` |
| `redraw-ab.txt` | four 0.24 records drawn again by the program before the change and after it: the two maps differ in those links alone | `python3 redraw-ab.py OLD_PROGRAM NEW_PROGRAM benchmark-results/RECORD...` |

`check-links.py` fetches each page once from `https://servil-software-factory.github.io/BLAKE3/blake3_servil/` and looks for the link's anchor in it; the site showed BLAKE3-Servil 0.10.0 when it ran. `patch-links.py` rewrites a link only where the call is named `throughput::NAME` and the link is `performance/fn.NAME.html`, asserts that the old file with those links renamed is the new file, and verifies both manifests of a folder before and after. In `redraw-ab.txt` the old program is the build of `66a21802b` (the tree of `2a223359`) and the new one the build of `36fdfb82b`'s tree.

## Limits

- A link answers on the day it is checked. The documentation site shows the newest release, so a stored map's link to a call that a later release removes dies with it: `throughput::update_each_multithreaded` leaves in 0.11, and the 0.22 and 0.24 maps name it in 71 places.
- The check reads the links the maps hold as data. It drives no browser.
