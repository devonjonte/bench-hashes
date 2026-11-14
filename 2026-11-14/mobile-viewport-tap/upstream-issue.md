### Version

Playwright 1.65.1, bundled Chromium 159.0.8154.6.

### Steps to reproduce

[Minimal repository branch](https://github.com/devonjonte/bench-hashes/tree/3a7723d840d6b8a340830a453c852197c6512ced) contains only the reproduction and its exact dependency lock.

```sh
git clone --depth 1 --branch repro/devon-visual-viewport-tap https://github.com/devonjonte/bench-hashes.git tap-repro
cd tap-repro
npm ci
npx playwright install chromium
npm test
```

The script uses `page.setContent`, a 1534-pixel-wide container and two buttons. It tests identical 1200×900 touch contexts with `isMobile: false`, then `true`. No server or application framework is involved.

### Expected behavior

`locator('#target').tap()` reaches the target in both contexts.

### Actual behavior

The ordinary touch context passes. The mobile context times out:

```text
locator.tap: Timeout 3000ms exceeded.
<main>…</main> intercepts pointer events
```

### Additional context

After scrolling in the mobile context, `visualViewport.offsetLeft` is 118. The target's `getBoundingClientRect()` centre is x=1213. A direct touchscreen tap at x=1095, subtracting the visual offset, reaches the intended button in a separate control. The locator action still fails with current Playwright. Version 1.55.1 also exhibits the issue.

Reporting this reproduction for maintainer triage. No implementation or PR is planned without assignment or approval.

### Environment

```text
System:
  OS: Linux 7.0 Ubuntu 26.04.1 LTS (Resolute Raccoon)
  CPU: (20) x64 12th Gen Intel(R) Core(TM) i7-12700K
  Memory: 11.47 GB / 14.86 GB
  Container: Yes
Binaries:
  Node: 24.21.0 - ~/.nvm/versions/node/v24.21.0/bin/node
  npm: 11.19.0 - ~/.nvm/versions/node/v24.21.0/bin/npm
Languages:
  Bash: 5.3.9 - /usr/bin/bash
npmPackages:
  playwright: 1.65.1 => 1.65.1
```

— Devon Jonte
