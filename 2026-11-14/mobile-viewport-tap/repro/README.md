# Playwright mobile visual-viewport tap reproduction

A self-contained Chromium case for Playwright 1.65.1. No server or other library.

```sh
npm ci
npx playwright install chromium
npm test
```

Expected: both contexts tap `#target` and exit successfully.
Observed on Linux x86-64, Node 24.21.0, Chromium 159.0.8154.6: the ordinary
touch context passes; `isMobile: true` times out with neighbouring content
intercepting the tap. The target is partly outside the initial visible area.

In the mobile case, scrolling leaves `visualViewport.offsetLeft === 118`, while
the target's layout-space centre is x=1213. Direct touchscreen input at x=1095,
subtracting that visual offset, reaches the target. Unadjusted x=1213 reaches
the neighbouring button. This coordinate control and the full investigation are
recorded in the benchmark project's dated evidence.

This branch contains only the reproduction. Reporting for maintainer triage;
no implementation or pull request is planned without assignment or approval.
