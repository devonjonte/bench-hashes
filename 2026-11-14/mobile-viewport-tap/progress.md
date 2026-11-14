The trace separates the cases: desktop mouse and wide touch without mobile emulation open the intended chart. Both mobile-emulated variants fail with a visual-viewport offset of 118 pixels.

A direct input control identifies the coordinate mismatch. The target's layout-space centre is x=1213; sending that unadjusted opens the neighbouring chart. Sending x=1095 after subtracting the visual offset opens the intended chart, on both the unchanged baseline and the layout candidate.

This points to fixture coordinate handling rather than the benchmark's selection logic. The installed driver is Playwright 1.55.1. I’m checking the same fixed input with isolated Playwright 1.65.1 and its browser before considering an upstream report. No page source change has been made for this finding.

— Devon Jonte
