# Direct plot selection

The user asks to explore every valid choice without learning which switches
enable other switches. The graph now offers one checkbox per measured plot,
grouped in a table by input shape and call pattern. Every checkbox stays
available. Clear selects none; Show all restores all; Done, Escape or a click
outside closes the picker. Counts and missing cells come from the actual data.

One Boolean array replaces four filter maps, dependent dimming, hypothetical
flip calculations and silent rejection of the last plot. This also permits
previously inexpressible selections, such as owned/alone beside lent/shared
without their other cross combinations. Native SVG checkbox roles and labels,
focus indication and Space/Enter activation serve keyboard and touch users.
Plain headings replace owned/lent terminology in the selector.

The picker replaces the original control implementation. Measurements,
workloads, timing, statistics and hashing remain unchanged. A new source file
holds the one selector implementation used by newly generated graphs and by
`tools/refresh-graph-ui.py`. That tool preserves an old graph's own renderer,
embedded DATA literal and metadata, and requires a separate output filename.
It introduces no sample reader or measurement rule. Original records stay intact.

## Validation

- 28 Rust tests pass, including the frozen workload contract and full/quick
  synthetic SVG generation (clearly labelled UI fixtures, never speed evidence).
- Full and quick jsdom checks pass: all plots reachable alone, arbitrary
  combinations, empty state/recovery, ranks, counts, zoom, units and hover.
- Real-browser full/quick and the user's historical graph pass mouse, touch,
  Space/Enter, Done and Escape, checking exact visible plot sets and unchanged
  DATA. Header/picker screenshots reviewed as newcomer, regular and maintainer.
- Existing single-point pieces rendering used a nonexistent median path to get
  a color. Fixture/browser tests expose that error. Reading DATA.colors directly
  fixes it using the existing single color source, without a special case.
- Initial refresh prototype substituted the whole current renderer into an old
  graph with different path representations. Retained failure; the final tool
  replaces only selection controls, keeping the source-matched renderer.

Local original test logs, failed prototypes, fixtures and screenshots:
`/home/agent/bench-hashes-validation/plot-picker/`. The upgraded user graph is
beside the original as `bench-hashes.explore.svg`. UI work lives on
`candidate/devon-plot-picker`; frozen Linux measurement runtime6047dcd remains
available independently. New benchmark artifacts must stay fixed within each
hashing comparison, including their presentation code and build provenance.
