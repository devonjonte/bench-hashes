# Provenance in “About the hashes compared”

November 14, 2026. [Reader contract](https://github.com/servil-software-factory/bench-hashes/issues/226).

## Question and design

Zooko wanted provenance present and findable when sought, while results readers
see less of it. He looked in the existing **About the hashes compared** section.
The live page's pale version line linked to the M6 record, but looked like an
annotation and occupied the space between machine metadata and results.

The overview now keeps that space clear. Its existing collapsed section contains
machine disclosures with separate library, file-tool and earlier-library records.
Software identities lead each record, followed by build settings and conditions.
The map and overview share the header formatter. Full benchmark versions, tool
commands, source text without a Git link, clean state and logical CPU count are
retained. The benchmark's linked BLAKE3-Servil version is labelled separately from
file tools' own recorded versions. Open records have readable contrast and wrap
on phones.

Earlier formats expose their recorded header strings through the existing
header-only path. Their measurement rows remain with their original readers and
maps. Four older maps predate the `#run` entry, so showing their headers here also
makes those identities reachable through the same reader-facing section.

## Source and scope

- Base: `da6fe3c478e3e25c23ab05514a1723e1e20f5e2f`.
- Final candidate: **`86e4687ac9b306f62da1608a805d3023f555c98f`**.
- Final renderer/test source: `adc20bdd76f7346e263b4d533afc596c0de383d5`.
- Earlier checkpoints: `adf9fc857`, `9e831b8f6`, `9418b5b58`, `1f06c2289`.

The source checkpoints skipped hosted CI while the overview needed regeneration.
The final artifact commit runs normal CI. Source, rendered index, recipes, logs,
controls and images are retained here. Build executables remain local.

All **392 bar elements, values, labels and plot links remain exact**. The twenty
stored maps receive only a shared record-style patch; reversing it restores
every original HTML byte. Their measured payloads, metadata and API labels remain
unchanged. Only each map's manifest entries change. No raw samples, reports or
SVG charts were rewritten. Inputs remain in the benchmark repository at the base
commit above. `validation/presentation-audit.json` and the style receipt bind the
checks with both hashes.

The design adds one record type/field, native HTML disclosures and a browser
checker. It reuses the existing metadata formatter and adds no runtime dependency,
flag or fetch protocol. The index grows from 146,755 to 320,576 bytes; gzip grows
from 19,572 to 35,305 bytes, about 15.4 KiB. That is the explicit cost of keeping all
records in static HTML, available when opened without another request.

## Validation

- **197 release tests pass** on the workhorse. Fixed anchors distinguish the
  library/file/earlier identities, preserve complete versions and escaped text,
  and keep old measurement rows outside the current reader. Header anchors cover
  source text without a Git commit, clean state, CPU counts and duplicate fields.
- Four source controls fail as intended: truncated version, file record taken
  from the library, earlier header formatter, duplicated load/power. Sources are
  restored and focused tests pass. Exact sources and logs are in `builds/`.
- Chromium **159.0.8154.6**, Playwright **1.65.1**: desktop and phone checks each
  inspect **15 machines, 30 run records and 334 recorded identity entries**. The
  checker starts at the familiar section name, checks collapsed headers, follows
  raw-sample links, and verifies identities, full versions, timestamps, source
  links, software-first order, contrast and wrapping.
- Four UI controls are rejected: omitted source, long version exposed in result
  headers, faint text and disclosure open by default. The previous published
  layout fails the result-header check.
- **15 full map checks / 476 chart instances** pass. Five older comparison maps
  pass their version-matched `2059ff5e` target checker. All 20 maps' 39 record disclosures
  pass at 390 and 1200 pixels: 78 record-style checks.

The initial workhorse suite stopped after 137/195 tests on the previous stale-row
caption assertion. The corrected suite and an added legacy-header test passed 196;
software-first/fidelity anchors bring it to 197. Those attempts remain intact.
The initial visual review is in `validation/preview-1/`; final images put software
identities ahead of run conditions. Accidental edition 2024 formatter churn was
reverted; the crate uses 2021.

Dedicated performance comparisons were skipped: timed calls and statistical rules
are unchanged. These are UI/correctness checks, with no new speed claim. Hosted CI,
landing-tree and live-deployment verification are the final publication steps.

## Reproduction

From the candidate checkout, build and run under normal bounded supervision:

```sh
cargo build --release --locked
./target/release/bench-hashes overview index.html benchmark-results
cargo nextest run --release --locked
node tools/graph-check/overview.js index.html CHROMIUM
node tools/graph-check/map.js benchmark-results/AppleM6.darwin27/bench-hashes.map.html CHROMIUM
```

Install Playwright in the environment used by the checker. An entry script beneath
another node_modules directory resolves that ancestor before NODE_PATH; the records
name the pinned package/browser actually used. Recipes under `validation/` cover
fault controls, historical maps, source-compatible patching and exact bar checks.
Home prefixes in text recipes/logs are redacted. HTML and images retain their bytes.
Both manifests cover this archive, excluding themselves.
