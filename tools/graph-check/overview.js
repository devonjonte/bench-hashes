// Drives the overview (index.html) in Chromium: no script error, and in
// every cell of the grid the fastest bar shown fills the width, as the page
// says, as it opens and after each legend button turns its contender off
// or on, and the magnitude under each cell's end is that bar's (a cell
// whose winner was hidden once drew short, its magnitude the hidden one's,
// October 24).
// npm install playwright; node overview.js INDEX.html [CHROMIUM]
const path = require('path');
const assert = require('assert');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
(async () => {
  const [file, exe] = process.argv.slice(2);
  const browser = await chromium.launch(exe ? { executablePath: exe, args: ['--no-sandbox'] } : { args: ['--no-sandbox'] });
  const page = await browser.newPage({ viewport: { width: 1400, height: 900 } });
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));
  await page.goto(pathToFileURL(path.resolve(file)).href);
  // Each shown cell's fastest shown bar, as a share of its track, and the
  // magnitude under its end against that bar's speed (GB/s).
  const cells = () => page.$$eval('a.pick', picks => picks.filter(a => a.offsetParent !== null).flatMap(a => {
    const bars = [...a.querySelectorAll('.bar:not(.off) i')];
    if (!bars.length) return [];
    const track = a.querySelector('.bars').getBoundingClientRect().width;
    const fastest = Math.max(...bars.map(i => +i.dataset.g));
    const scale = parseFloat(a.querySelector('.scale').textContent);
    return [[a.dataset.head, Math.max(...bars.map(i => i.getBoundingClientRect().width)) / track, scale / fastest]];
  }));
  // A shared grid (data-shared) has one logarithmic scale for every cell:
  // each bar's width, as a fraction of its track, is one straight line in
  // log(speed), the same in every cell.
  const shared = await page.$$eval('.grid[data-shared]', g => g.length > 0);
  const scale = () => page.$$eval('a.pick', picks => picks.filter(a => a.offsetParent !== null).flatMap(a => {
    const track = a.querySelector('.bars').getBoundingClientRect().width;
    return [...a.querySelectorAll('.bar:not(.off) i')].map(i => [Math.log10(+i.dataset.g), i.getBoundingClientRect().width / track]);
  }));
  const check = async state => {
    const all = await cells();
    if (shared) {
      const points = (await scale()).filter(([, f]) => f > 0.02);
      const [a, b] = [points[0], points.reduce((m, p) => (Math.abs(p[0] - points[0][0]) > Math.abs(m[0] - points[0][0]) ? p : m))];
      const slope = (b[1] - a[1]) / (b[0] - a[0]);
      const off = points.filter(([x, f]) => Math.abs(a[1] + slope * (x - a[0]) - f) > 0.01);
      assert.deepEqual(off, [], `${state}: every bar on the one shared scale`);
    } else {
      assert.deepEqual(all.filter(([, f]) => f < 0.98).map(c => c.slice(0, 2)), [], `${state}: the fastest bar shown fills each cell`);
    }
    // The magnitude is the fastest shown's, as rounded to two figures.
    assert.deepEqual(all.filter(([, , r]) => Math.abs(r - 1) > 0.06).map(c => [c[0], c[2]]), [], `${state}: each cell's magnitude is its fastest bar's`);
  };
  await check('as the page opens');
  const buttons = await page.locator('.legend button').count();
  for (let k = 0; k < buttons; k++) {
    const button = page.locator('.legend button').nth(k);
    const name = (await button.textContent()).trim();
    for (const turn of ['once', 'back']) {
      await button.click();
      await check(`${name} turned ${turn === 'once' ? 'over' : 'back'}`);
    }
  }
  assert.deepEqual(errors, [], 'no script error');
  // Each decade's label sits over its line in the cells, at desktop and phone widths.
  if (shared) {
    for (const width of [1400, 420]) {
      await page.setViewportSize({ width, height: 900 });
      const { labels, ticks } = await page.evaluate(() => {
        const centre = e => { const b = e.getBoundingClientRect(); return b.left + b.width / 2; };
        return {
          labels: [...document.querySelectorAll('tr.axis th:nth-child(2) span.axis i:not(.unit)')].map(centre),
          ticks: [...document.querySelector('a.pick .bars').querySelectorAll('.tick')].map(t => t.getBoundingClientRect().left),
        };
      });
      assert.equal(labels.length, ticks.length, `${width}px: a label for each decade line`);
      labels.forEach((x, k) => assert.ok(Math.abs(x - ticks[k]) <= 2, `${width}px: decade ${k} label at ${x}, its line at ${ticks[k]}`));
    }
  }
  await browser.close();
  console.log(`overview: ${buttons} buttons, ${shared ? 'one shared scale' : 'every cell filled'} in each state`);
})().catch(e => { console.error(e.message); process.exit(1); });
