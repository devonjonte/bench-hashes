# Expanded-chart layout, measured before editing

November14,12:23UTC. Issue221. Local implementation/validation budget through
13:45; CI/publication follow. Base2059ff5e. No performance collection.

Question: make long chart titles, API names, legends and axes readable on a
phone while retaining the data and existing interactions.

First inventory normalized published templates, leaving their SECTIONS payloads
as opaque bytes. Identify which pages share the current presentation contract;
keep older comparison data/legend formats intact. Measure current title/legend
overlap, plot-label clipping and documentation-link hit targets at320/420/1200px.

Preferred design: one flowing header, measured at its actual width, rather than
fixed phone/desktop title and legend-row allowances. Derive the plot's top inset
from that header. Size the left margin from actual tick-label text where needed.
Prefer removing redundant assumptions over adding special cases. Keep raw data,
provenance, call labels and numeric payloads byte-identical.

Add failing geometry/hit-target checks before the correction. Validate narrow
and desktop views, different long titles/legend sizes and measure toggles. Review
rendered pages as newcomer, regular and maintainer. Refresh only source-compatible
published templates; source and artifacts must receive the same layout rule.
If a broader renderer migration is needed, stop and report that scope rather
than silently adapting historical measurement data.

12:25 inventory: four template families cover the15 benchmark maps. Their
expanded-chart CSS, draw geometry and open/header logic match the current
source; differences elsewhere (glyphs, layout tracks and provenance rendering)
stay untouched. Five comparison maps use older draw/open/data contracts and
have no expanded legend. Leave those five layouts unchanged; their tap repair
already landed. Apply exact shared block replacements to the source and15
compatible maps, preserving SECTIONS bytes and all unrelated template bytes.

13:20 review: normal flow and font-measured margins pass the initial viewport
matrix, including320×568. Opening now clears the old mini-chart tooltip; a
pointer-handler rewrite alone failed and was discarded. Further checks found a
sticky global legend covering a desktop close button, and a resize viewport
mismatch under investigation. Stress selection uses the public chart link after
the wide-mobile far-cell tap failed before opening; those failures stay recorded.

Horizontal coordinates in the existing renderer follow point order, including
numeric inputs. Remove the misleading horizontal log-scale claim without moving
points; name the vertical log scale explicitly and document horizontal ordering.
Animation/transient-size/instant-reopen logic leaves in favor of immediately
measured layout. The existing resize/reopen mechanism remains shared.
