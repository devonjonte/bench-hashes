# Qualified M6 b3sum snapshot published, November 13, 2026

The M6 file-command cells now appear on the public map and overview. Their
load qualification remains visible beside the results. This publishes the
completed workstation snapshot, with quiet-machine speed claims outside its
scope. Further repetitions solely to obtain a quiet flag would add little.

- Publication: [`e2a3bb8c4d9e331a918fe2afa5382e52fc081abc`](https://github.com/servil-software-factory/bench-hashes/commit/e2a3bb8c4d9e331a918fe2afa5382e52fc081abc),
  [publication PR](https://github.com/servil-software-factory/bench-hashes/pull/203).
- Load labels: [`45f356014024e3cc42c40f036c6af1e921913318`](https://github.com/servil-software-factory/bench-hashes/commit/45f356014024e3cc42c40f036c6af1e921913318),
  [feature PR](https://github.com/servil-software-factory/bench-hashes/pull/202).
- Historical renderer: [`d2028f7011313911e1149574e9c4be66349fe635`](https://github.com/devonjonte/bench-hashes/commit/d2028f7011313911e1149574e9c4be66349fe635),
  based on bench `9434d50e50de4b93dc962ccbf52346db5442358e` with library
  `2037118ca1da85710aef55d7f13b3abd9095b485`. Its backports concern presentation
  alone. The reader, clocks, contender calls and statistical arithmetic stay at
  the original release.

[Published map](https://servil-software-factory.github.io/bench-hashes/benchmark-results/AppleM6.darwin27/bench-hashes.map.html)
and [overview](https://servil-software-factory.github.io/bench-hashes/).
Both were fetched and checked live at 09:15 UTC. The map includes b3sum and its
1/486-window warning; the overview shows separate Library (1/362) and Files
(1/486) warnings. The original 3077 run and the complete 3095 exchange record
remain preserved in this question's earlier evidence.

The map already carried load counts in its section introduction. Devon's first
follow-up comment overlooked that. The missing qualification was the overview's;
one formatter now carries the warnings to both pages, and says times may be
slower. The machine's load classification is used as recorded, without changing
samples or recomputing acceptance.

## Validation and failed controls

- 180 current workspace tests pass; 154 historical-renderer tests pass.
  The 16 machine tests remain outside this presentation-only scope.
- All four GitHub checks passed on both landed commits.
- The historical overview equals the current presentation byte-for-byte;
  all 308 plotted bar speeds agree. Both map section payloads equal those
  from the pristine historical renderer, apart from load wording.
- Focused Chromium checks pass: file-command section, source-specific load
  notes, overview first view/grid/card, and clean JavaScript execution.
  Desktop/phone screenshots remain local, outside this text-only record.
- The standard map script's phone-tap check times out at line 117 on both
  pristine and patched maps with Chromium 140.0.7339.186. Earlier desktop
  checks pass. [Separate finding and next move](https://github.com/servil-software-factory/bench-hashes/issues/204),
  owned by Devon. It remains separate from measurement correctness.
- Initial browser recipes used an unavailable browser path, then an incorrect
  selector. Their logs are preserved alongside the corrected check. The bounded
  supervisor terminated the selector-failure browser group at its deadline.

`validation/` holds confirming and failed text evidence. Its development-home
prefix is redacted as `<development-home>`. Published measurement values, counts
and load windows stay unchanged. The M6 folder includes its checked dual
manifests; the question's top-level manifests cover all public evidence here.

`index.html` preserves the complete published overview. Its other machines'
records stay in the main repository; this subfolder copies the M6 record alone.
The source-matched renderer's ordinary `map` and `overview` commands reproduce
these derived views. The publication adds records and qualifications; it changes
no timed code and collects no fresh performance data.

— Devon Jonte
