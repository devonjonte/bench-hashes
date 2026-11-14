# Mobile visual-viewport tap coordinates

## Result

A wide mobile-emulated page exposes a coordinate mismatch in Playwright's
`locator.tap()`. Ordinary desktop and touch contexts select the intended chart.
With `isMobile: true`, the visible viewport pans while the layout coordinates
stay put, and the locator tap is intercepted by neighbouring content.

The finding reproduces with **Playwright 1.55.1** and current **1.65.1 / Chromium
159.0.8154.6**, on Linux x86-64 and Node 24.21.0. A self-contained page with two
buttons reproduces it without benchmark code, a server or another framework.

| Control | Result |
|---|---|
| Desktop mouse | Intended chart opens |
| Touch, without mobile emulation | Intended chart opens |
| Mobile emulation, all-touch | Locator tap fails |
| Mobile emulation, mouse chips then touch chart | Locator tap fails |
| Direct touch adjusted for the visual offset | Intended target opens |

After panning, the target's layout-space centre is x=1213 and
`visualViewport.offsetLeft` is 118. Input at x=1095, subtracting that offset, reaches
the target. The unadjusted direct input selects a neighbour in the original
benchmark control. The standalone current-version control also reaches the target
with the adjusted input. Physical-device scope remains unmeasured.

## Reproduction and report

The [minimal repository branch](https://github.com/devonjonte/bench-hashes/tree/3a7723d840d6b8a340830a453c852197c6512ced)
contains only the reproducer, its exact dependency lock and instructions:

```sh
git clone --depth 1 --branch repro/devon-visual-viewport-tap https://github.com/devonjonte/bench-hashes.git tap-repro
cd tap-repro
npm ci
npx playwright install chromium
npm test
```

The ordinary touch context passes. The mobile context exits with the recorded
3000 ms timeout. `repro/` retains that tested source. The independent direct-input
control remains in `current/minimal.js` and its result file.

Reported as [Playwright: Chromium locator.tap misses its target after the visible viewport pans](https://github.com/microsoft/playwright/issues/44121).
The project requires triage/assignment before a code contribution. This is a
reproduction report; no upstream implementation or PR is planned without approval.

## Scope and evidence

The initial stress failure occurred before opening a benchmark chart and also
reproduced on unmodified bench `2059ff5e`. The layout correction therefore retains
its separate scope. Its resize/measure checks use the documented chart-link entry.
No benchmark page source change is made for this coordinate finding.

`results.json` and the four context screenshots retain the initial trace.
`coordinates.json` compares adjusted and unadjusted direct inputs on the baseline
and the layout candidate. `current/results/` repeats the matrix with the pinned
current driver/browser. The full M6 layout check also passes with that current
browser. Package/browser versions and the environment report are retained.

The first current-driver attempt resolved the older ancestor package despite
NODE_PATH and stopped before running. Moving the same script beside its pinned
package selected the intended version; both outcomes remain recorded. Browser
and node_modules binaries are excluded. Home prefixes in logs/recipes use
`<development-home>`. Both manifests bind the published evidence.

[The benchmark's investigation](https://github.com/servil-software-factory/bench-hashes/issues/224)
can close as diagnosed and reported. Further driver work belongs to upstream
triage. No performance measurement was collected.
