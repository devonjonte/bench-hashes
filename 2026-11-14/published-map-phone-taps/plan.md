# Publish the existing phone-tap repair in stored maps

November14,11:00UTC. Budget one hour for patch/validation/publication preparation.
GitHub Pages serves next. All15 stored maps have documentation-link styling and
none carries the coarse-pointer repair already present in src/map.html. The live
M6 page matches its stored file byte for byte. The original source repair is
e85b4c49583faec19d2705be873afaca7046ccd7 (PR208).

Question: deliver that existing UI fix to readers of historical published maps,
without changing measured values, provenance or API labels.

First run the existing graph-check/map.js against the downloaded M6 page and
retain the expected phone-stage failure. Add an explicit opens assertion to the
existing phone check before its bounding-box access, so failure names the cause.
Then copy only the exact repair block
from the current canonical template into each compatible stored HTML file.
Require the expected anchor once, preserve every other byte, and change only
the map's entries in existing SHA256/BLAKE3 manifests. Validate manifests before
and after. Raw samples, reports and overview data must remain byte-identical.

Run the existing browser check on all15 maps serially under a bounded supervisor.
Inspect desktop/phone renders, including the open chart's documentation link.
Retain browser failures and the before/after record. No new UI mechanism, flag,
renderer version or Rust change is needed. Skip timing/Rust tests because the
change affects generated presentation only; normal CI still runs before landing.

Next-line PR, then verify the deployed M6 page and its phone interaction. The
current source template already contains the fix, so later drawings keep it.

11:08 preflight finding: four 0.18/0.18.1 result folders have neither manifest.
The refresh stopped before changing any map. Bind those four existing folders
with paired manifests in a separate preparation commit, keeping every existing
file byte-identical; retain the new pre-refresh manifests as evidence. Then run
the same uniform refresh contract over all15 folders. No compatibility fallback
is added to the updater. Check the other eleven existing pairs before proceeding.

11:22 scope correction: full tracked-HTML inventory adds five older comparison
maps under beside/. Their centre taps work at420px, but taps on the visible call
name open no chart in all five. The same repair belongs on all20 published maps.
The existing browser test now checks that call-name target too. Preserve both
inventory outcomes. The fifteen-map pass and receipt are saved under initial-main/;
its exact owned changes were checked and restored before one complete pass.
Three comparison folders gain paired manifests in a second preparation commit.
The updater now groups all map entries per directory, so two maps sharing a
manifest update it once. Same CSS rule, same byte-preservation contract.

11:40 validation scope: all15 benchmark maps pass the complete browser check.
It then stops on the first historical comparison map, whose stored cells lack
the CPU field required by the current full check. Preserve that failure and the
old payloads. Extract the existing phone routine as checkPhone(browser,url),
shared by the full checker and a historical-page caller; add no data-compatibility
mode. Run that same phone contract on all20 pages and recheck full M6 after the
extraction. Report15 full checks plus20 shared phone checks, rather than claiming
all20 passed the current full-data test.

Visual inspection also exposes an existing expanded-phone layout defect:
long title/API text overlaps the legend, and axis text is cramped. The repair's
only visual-code change is pointer hit testing. Keep this separate layout finding
visible for the next source/UI correction; this publication restores interaction
without claiming complete mobile polish.
