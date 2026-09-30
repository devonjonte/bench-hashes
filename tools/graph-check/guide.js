// Exercise the generated guide in a real browser, including its embedded
// SVG, every decision-table route, uncertain answers, Back, and restart.
// npm install playwright; node guide.js GUIDE.html [CHROMIUM_PATH]
const { chromium } = require('playwright');
const { pathToFileURL } = require('url');
const assert = require('assert');
const path = require('path');
(async () => {
  const browser = await chromium.launch({ headless: true,
    executablePath: process.argv[3] || undefined, args: ['--no-sandbox'] });
  const page = await browser.newPage({ viewport: { width: 1300, height: 1000 } });
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));
  await page.goto(pathToFileURL(path.resolve(process.argv[2])).href);
  // Decision table independent of the page's recommendation function.
  const after = {
    message: ['hash', 'hash_multithreaded', 'OneMessage'],
    pieces: ['Hasher::update', 'Hasher::update', 'Streaming'],
    batch: ['hash_many', 'hash_many_multithreaded', 'ManyMessages']
  };
  const continuous = {
    message: ['hash', 'hash_multithreaded', 'Queue::messages', 'LentMessages', 'ContinuousMessages'],
    pieces: ['Hasher::update', 'Hasher::update_multithreaded', 'Queue::pieces', 'LentPieces', 'ContinuousMessages'],
    batch: ['hash_many', 'hash_many_multithreaded', 'Queue::fixed', 'LentBatches', 'ContinuousBatches']
  };
  let routes = 0;
  for (const threads of ['one', 'many']) for (const shape of ['message', 'pieces', 'batch']) {
    for (const keepsUp of ['yes', 'no']) for (const buffer of ['owned', 'lent']) {
      for (const efficiency of ['time', 'energy']) {
        const a = { threads, shape, keepsUp, buffer, efficiency };
        const r = await page.evaluate(a => recommendation(a), a);
        const expected = keepsUp === 'yes' ? after[shape][threads === 'many' ? 1 : 0]
          : continuous[shape][threads === 'one' ? 0 : buffer === 'owned' ? 2 : 1];
        const expectedUse = keepsUp === 'yes' ? after[shape][2]
          : continuous[shape][threads === 'many' && buffer === 'owned' ? 4 : 3];
        assert(r.api.startsWith(expected + '('), `${JSON.stringify(a)}: ${r.api}`);
        assert.equal(r.use, expectedUse);
        routes++;
      }
    }
  }
  // Click through every reachable route, then inspect the actual visible
  // plots and contender selection, rather than just the recommendation.
  let endings = 0;
  for (const threads of [0, 1]) for (const shape of [0, 1, 2]) for (const keepsUp of [0, 1]) {
    for (const buffer of threads === 0 && keepsUp === 1 ? [0, 1, 2, 3] : [null]) {
      const restart = page.locator('#restart');
      if (await restart.isVisible()) await restart.click();
      await page.locator('#choices button').nth(threads).click();
      await page.locator('#choices button').nth(shape).click();
      await page.locator('#choices button').nth(keepsUp).click();
      if (buffer !== null) await page.locator('#choices button').nth(buffer).click();
      if (threads === 0) await page.locator('#choices button').nth(0).click();
      await page.waitForFunction(() => graphReady);
      const state = await page.evaluate(() => {
        const w = document.getElementById('graph').contentWindow;
        // Script lexical state is accessible through eval in this frame.
        return w.eval(`({ uses: Object.entries(chipOn.use).filter(([k,v])=>v).map(([k])=>k),
          visible: [...document.querySelectorAll('.plot-group')].filter(g=>!g.classList.contains('plot-off')).length,
          chosen: on.flatMap((v,i)=>v?[i]:[]) })`);
      });
      const result = await page.evaluate(() => ({ r: current, keys: CONTENDERS, missing: !document.getElementById('missing').hidden }));
      // A quick run may omit the >64 KiB Queue::pieces window entirely.
      if (result.missing) {
        assert(result.r.api.startsWith('Queue::pieces('), JSON.stringify(result));
      } else {
        assert.deepEqual(state.uses, [result.r.use]);
        assert.equal(state.visible, 2);
        assert(state.chosen.includes(result.keys.indexOf(result.r.contender)));
        if (result.keys.includes('sha256-ring')) assert(state.chosen.includes(result.keys.indexOf('sha256-ring')));
        const display = await page.evaluate(() => document.getElementById('graph').contentWindow.eval(`({chosen, labels: DATA.plots.filter(p=>chipOn.use[p.use]).map(p=>p.timeUnit)})`));
        if (result.r.api.startsWith('Queue::')) assert.equal(display.chosen, 'gbps');
        else {
          assert.equal(display.chosen, 'ns');
          assert(display.labels.every(unit => ['ns/message', 'ns/batch'].includes(unit)));
        }
      }
      endings++;
    }
  }
  await page.locator('#restart').click();
  for (let i = 0; i < 3; i++) await page.locator('#choices button').last().click();
  assert((await page.locator('#api').innerText()).startsWith('hash('));
  await page.locator('#back').click();
  assert((await page.locator('#question-title').innerText()).includes('keep up'));
  await page.locator('#restart').click();
  assert((await page.locator('#question-title').innerText()).includes('several threads'));
  // Every default leads to the documented conservative answer.
  const defaults = await page.evaluate(() => Object.fromEntries(Object.entries(questions).map(([k,q]) => [k,q.choices.at(-1)[0]])));
  assert.deepEqual(defaults, { threads: 'one', shape: 'message', keepsUp: 'yes', buffer: 'lent', efficiency: 'time' });
  assert.deepEqual(errors, []);
  console.log(`${routes} table routes, ${endings} clicked endings, defaults, navigation, embedded plots: pass`);
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
