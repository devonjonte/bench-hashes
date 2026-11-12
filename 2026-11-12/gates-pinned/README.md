# The 0.9 gates against 0.8, pinned, November 12, 2026

next c10d6804 (the two crates) against 0.8 (b5b988d8 under its own bench 3363bee8), bench next 77d4a765, whose checks across two benches are pinned. A folder a machine: `core-gate-pinned` (the single-threaded contender, every cell), `mt-gate-pinned` (the multithreaded one, 191 points), and the isolations (`iso-4k` on the EPYC 9275F, `iso-16k` on the second Xeon pair). On the 9275F the core gate is in `gates-pinned`.

The verdicts and how they were read: BLAKE3 #357 (the comment of this date) and #376.
