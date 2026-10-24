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
  const check = async state => {
    const all = await cells();
    assert.deepEqual(all.filter(([, f]) => f < 0.98).map(c => c.slice(0, 2)), [], `${state}: the fastest bar shown fills each cell`);
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
  await browser.close();
  console.log(`overview: ${buttons} buttons, every cell filled in each state`);
})().catch(e => { console.error(e.message); process.exit(1); });
