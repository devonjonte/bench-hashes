// Renders cropped release-announcement PNGs (hero + full overview) from an
// overview page (index.html) in headless Chromium:
//   node announce.js INDEX.html OUT_DIR PREFIX [CHROMIUM]
// Writes:
//   OUT_DIR/PREFIX-hero.png   (top family summary + speed-up badges)
//   OUT_DIR/PREFIX.png        (hero + per-machine/use-case comparison table)
// Pass --show KEY1,KEY2 (legend `data-k` values) to override the page's default
// selection (BLAKE3-Servil multi-threaded vs SHA-256).
const fs = require('fs');
const path = require('path');
const assert = require('assert');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');

function parseArgs(argv) {
  let show = null;
  const pos = [];
  for (let i = 0; i < argv.length; i++) {
    if (argv[i] === '--show') {
      assert(i + 1 < argv.length, '--show requires a comma-separated list of legend keys');
      show = argv[++i].split(',').map(s => s.trim()).filter(Boolean);
    } else {
      pos.push(argv[i]);
    }
  }
  assert(
    pos.length === 3 || pos.length === 4,
    'usage: node announce.js [--show KEY,KEY] INDEX.html OUT_DIR PREFIX [CHROMIUM]'
  );
  return { file: pos[0], outDir: pos[1], prefix: pos[2], exe: pos[3] || null, show };
}

async function renderAnnouncementPngs({ file, outDir, prefix, exe, show }) {
  const url = pathToFileURL(path.resolve(file)).href;
  fs.mkdirSync(outDir, { recursive: true });
  const browser = await chromium.launch(exe ? { executablePath: exe, args: ['--no-sandbox'] } : {});
  try {
    const page = await browser.newPage({
      viewport: { width: 1120, height: 1400 },
      deviceScaleFactor: 1.5,
    });
    const errors = [];
    page.on('pageerror', e => errors.push(e.message));
    await page.goto(url);
    if (show) {
      const wanted = new Set(show);
      const buttons = page.locator('.legend button');
      const count = await buttons.count();
      for (let i = 0; i < count; i++) {
        const b = buttons.nth(i);
        const key = await b.getAttribute('data-k');
        const isOff = await b.evaluate(el => el.classList.contains('off'));
        if (wanted.has(key) === isOff) {
          await b.click();
        }
      }
    }
    const boxes = await page.evaluate(() => {
      const families = document.querySelector('.families');
      const grid = document.querySelector('.grid');
      if (!families || !grid) return null;
      const f = families.getBoundingClientRect();
      const g = grid.getBoundingClientRect();
      return {
        heroBottom: Math.ceil(f.bottom + window.scrollY + 18),
        fullBottom: Math.ceil(g.bottom + window.scrollY + 18),
      };
    });
    assert(boxes, 'overview page must contain .families and .grid sections');
    const heroPath = path.join(outDir, `${prefix}-hero.png`);
    const fullPath = path.join(outDir, `${prefix}.png`);
    await page.screenshot({
      path: heroPath,
      clip: { x: 0, y: 0, width: 1120, height: boxes.heroBottom },
      fullPage: true,
    });
    await page.screenshot({
      path: fullPath,
      clip: { x: 0, y: 0, width: 1120, height: boxes.fullBottom },
      fullPage: true,
    });
    assert.deepEqual(errors, []);
    return { heroPath, fullPath, heroHeight: boxes.heroBottom, fullHeight: boxes.fullBottom };
  } finally {
    await browser.close();
  }
}

module.exports = { parseArgs, renderAnnouncementPngs };
if (require.main === module) {
  renderAnnouncementPngs(parseArgs(process.argv.slice(2)))
    .then(r => console.log(`wrote ${r.heroPath} and ${r.fullPath}`))
    .catch(e => {
      console.error(e);
      process.exit(1);
    });
}
