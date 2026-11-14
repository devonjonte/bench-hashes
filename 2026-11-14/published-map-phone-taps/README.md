# Deliver the phone-tap repair to published maps

## Question and result

The renderer already contained the [phone-tap repair](https://github.com/servil-software-factory/bench-hashes/pull/208),
while the published HTML still had its old style. GitHub Pages serves `next`.
The downloaded M6 page matched the stored map byte for byte and failed the phone
opening check: zero enlarged charts where one was expected.

Candidate **c7fcc90df215bf50bfc40377d4cb494c13cb440e** updates **20 stored maps in
18 folders**, including five older comparison maps. It copies the canonical
three-line CSS/comment block from `src/map.html`. Removing that block restores
every original HTML byte, including numbers, provenance, warnings and call labels.
Raw samples, reports, SVGs and overview data stay byte-identical.

The comparison pages' centre taps already worked at 420 pixels. Tapping their
visible call names opened no chart in all five. Both findings are retained.
The repair makes that name part of the small chart's opening target, while the
enlarged chart's documentation link retains its normal pointer behavior.

## Validation and limits

- **15 benchmark maps pass the full browser check**, covering **476 chart
  instances**. The full M6 check passes again after extracting the shared test.
- **All 20 maps pass the shared phone-target check**: centre/call-name opening,
  plot tooltip, close button and pointer-active expanded documentation link.
- The original published page fails the opening assertion. A deliberately
  overbroad CSS rule fails the expanded-link assertion. Both controls fail again
  through the final shared routine.
- All eighteen folders' SHA-256 and BLAKE3 manifests verify after the update.
  Only map entries change during the UI step. Seven historical folders first
  receive paired manifests in metadata-only preparation commits, binding nineteen
  existing files without changing them.
- Desktop/phone screenshots were inspected. **An existing expanded-phone layout
  defect remains:** long title/API text overlaps the legend, with cramped axis
  text (`phone-open.png`). Devon owns the separate layout correction. This record
  establishes restored interaction while keeping that visual cost visible.

The current full checker stops on an older comparison page's missing CPU field.
An initial extracted phone routine also expected that page's newer-style legend
buttons. These failures remain in the archive. The final `checkPhoneTargets(page)`
uses only the shared DOM interaction contract; the full checker retains its
current measurement/legend checks. Historical payloads and scripts stay intact.
This is **15 full checks plus 20 target checks**, with no data compatibility mode.

Dedicated timing and Rust validation were skipped because the change affects
presentation and browser tests only. All seven final repository CI checks passed.

## Sources, steps and records

- Base: `eb2d8dec91409d58dd26378e6d2ecab14e6b5f4b`.
- Canonical repair: `e85b4c49583faec19d2705be873afaca7046ccd7`.
- Preparation commits: `cd84b3749` and `88550026f` (exact parents of the candidate).
- `all-maps/refresh-receipt.json` binds each map before/after with both digests;
  `repair.css` is the exact inserted block. `scope-check.txt` establishes the
  complete changed-path set and unchanged records.
- `refresh.py` performs one preflight over all inputs, then updates each folder's
  manifest once, including comparison folders containing two maps.
- `legacy-before/` and `compared-before/` retain the initial checksum bindings.
  The first refresh stopped before editing because four older folders had no
  manifests; its failure is retained. `initial-main/` preserves the first
  fifteen-map pass before the complete inventory added five comparison pages.
- `browser-results.json`, `phone-target-results.json`, logs and bounded queue
  summaries retain each outcome. `validation-summary.json` counts the observed
  passes. `code/map.js` is the candidate's shared checker.
- `history/` records reconstructed intermediate test implementations for the
  retained contract-mismatch failures; their outputs were preserved, never
  regenerated. `published-m6-before.html` is the live input; `overbroad-m6.html`
  is the deliberate faulty repair, outside the candidate.

To repeat current full checks, use the candidate's `tools/graph-check/map.js` as
its README describes. `check-targets.js` drives the same exported target routine
on all receipt-listed pages and exercises both controls. It uses Playwright's
installed Chromium path. Script/log home prefixes are redacted as
`<development-home>`; HTML, images and CSS retain their exact bytes.

[Publish the phone-tap repair on stored maps](https://github.com/servil-software-factory/bench-hashes/pull/222)
landed as **2059ff5e2235af6423d80c49de31f87cfd355f0c** on `next`. Its tree matches
the reviewed candidate. The cache-busted live M6 URL then matched that HTML byte
for byte and passed the shared phone-target check at 12:17 UTC. `ci.json` and
`phone-live.*` retain the final checks; both live-page digests were verified.

The data branch preserves source, logs and screenshots. Both manifests bind all
published files, including historical checksum records.
[Expanded phone-header overlap](https://github.com/servil-software-factory/bench-hashes/issues/221)
remains Devon's next layout task.
