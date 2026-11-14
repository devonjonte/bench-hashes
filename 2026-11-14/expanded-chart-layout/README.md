# Expanded charts: readable headings and bounded panels

## Question and correction

After restoring phone taps, visual review found title/API text overlapping the
legend. DOM checks reproduced that overlap, covered documentation links and four
clipped tick labels at 320/420 pixels on M6 and i7 records. Desktop panels could
also extend below the viewport.

Candidate **554af6dc1409bff785c1544ee3efacaf44a1be83**, based on
**2059ff5e2235af6423d80c49de31f87cfd355f0c**, uses one flowing title/legend heading.
Its actual height determines the plot's room. Tick strings are measured in their
SVG font. Panels use client viewport dimensions and one stacking order; short
panels scroll while the close button remains reachable. The old miniature-chart
tooltip is cleared when the expanded chart opens.

**Trade:** charts open and close directly. Animation, transient dimensions,
instant-reopen flags and delayed hash-link positioning leave the design. Row and
column highlighting, documentation links, plot interaction and legend controls
remain. The vertical axis keeps its units; the persistent bar carries the scale
and direction.

Review also found that horizontal positions follow the ordered test inputs,
rather than numeric logarithms. Those positions stay unchanged. The misleading
horizontal log-scale label is removed and the bar explicitly names the vertical
log scale. `METHODOLOGY.md` describes the spacing.

## Scope and checks

- **15 source-compatible benchmark maps**, 476 chart instances, pass the full
  browser check with geometry checked on every expanded chart.
- **Eight viewport cases** cover M6/i7 at 320×568, 320×900, 420×860 and 1200×900.
  They check overlap, SVG text bounds, documentation hit targets, close after
  scrolling and touch interaction. Original controls fail; final cases pass.
- **Twelve resize/measure/legend states** pass, including cost/rate views and all
  available measures. These use the documented chart-link entry point.
- **Five older comparison maps remain byte-identical** and pass their
  version-matched target checker from commit `2059ff5e`. They have older presentation
  contracts and receive no renderer migration.
- Every `SECTIONS` payload remains byte-identical, including numeric values,
  provenance, warnings and API labels. Only exact canonical layout patches enter
  compatible pages. They apply with zero fuzz and reverse to the original HTML.
  Paired manifests verify; only map checksum entries change.

The inventory distinguishes six template families. Groups 1–4 share the changed
CSS/draw/open blocks; unrelated glyph, track and provenance differences remain.
`template-inventory.json`, diffs, `trial-4/source.patch` and
`installed-receipt.json` bind that scope. Raw samples, reports, SVGs and overview
data stay unchanged. No measured workload or statistical rule changes.

## Failures retained and remaining scope

- The first geometric prototype still showed the old small-chart tooltip.
  Changing pointer handlers alone failed. Clearing the tooltip at the view
  transition passed, and the extra handler change was removed.
- Full checks found a sticky global legend covering a desktop close button.
  One panel stacking order fixed it. A mobile `innerHeight` of 1151 for a 900-pixel
  client viewport explained the resize overflow; client dimensions fixed it.
- Two attempts to tap a far-right small cell in a wide mobile context failed
  before opening. The same operation fails on unmodified base `2059ff5e`. This
  separate grid-selection finding remains visible in `tap-baseline.json` and
  the stress logs. The resize/measure test uses a normal public chart link,
  without changing its selected input. This record makes no claim to repair
  that pre-existing interaction.
- Applying the current target checker to older unchanged comparison layouts
  also failed. Their matching published checker passes all five. The source
  contracts remain separate; no compatibility switch was added.

Screenshots before and after were inspected. `final-matrix/` and `stress-final/`
show the resulting phone, desktop and cost views. Intermediate patches, logs and
images remain alongside the final checks.

## Reproduce and publication

`preview.py` applies the canonical source diff to the fifteen compatible copies.
`check.js`, `stress.js`, `full.py` and the bounded queue records name each test.
`install.py` verifies full-check success and reverse-patch identity before changing
stored maps. `code/` contains the candidate template and shared checker. Restore
redacted `<development-home>` prefixes for local recipes; source templates, data
receipts and images retain their bytes. Generated trial HTML is reproducible from
the base files and retained patches and is omitted from this archive.

Rust/timing checks were skipped for this presentation-only change. Repository CI
and live deployment verification remain the final steps. Both manifests bind all
published evidence. [Expanded phone-chart issue](https://github.com/servil-software-factory/bench-hashes/issues/221)
is Devon's next move: finish CI, land and verify the deployed page.
