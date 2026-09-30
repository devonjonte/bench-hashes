// Exercise the generated guide in a real browser: every decision-table
// route, every uncertain default, Back and restart, and each ending's
// example, chart, and table. npm install playwright; node guide.js GUIDE.html [CHROMIUM]
const { chromium } = require('playwright');
const { pathToFileURL } = require('url');
const assert = require('assert');
const path = require('path');
(async () => {
  const browser = await chromium.launch({ headless: true, executablePath: process.argv[3] || undefined, args: ['--no-sandbox'] });
  const page = await browser.newPage({ viewport: { width: 900, height: 1000 } });
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));
  await page.goto(pathToFileURL(path.resolve(process.argv[2])).href);
  // The table, written independently of the page's function.
  const after = { message: ['hash', 'hash_multithreaded', 'OneMessage'], pieces: ['update', 'update', 'Streaming'], batch: ['hash_many', 'hash_many_multithreaded', 'ManyMessages'] };
  const continuous = {
    message: ['hash', 'hash_multithreaded', 'Queue::messages', 'LentMessages', 'ContinuousMessages'],
    pieces: ['update', 'update_multithreaded', 'Queue::pieces', 'LentPieces', 'ContinuousMessages'],
    batch: ['hash_many', 'hash_many_multithreaded', 'Queue::fixed', 'LentBatches', 'ContinuousBatches'],
  };
  let routes = 0;
  for (const threads of ['one', 'many']) for (const shape of ['message', 'pieces', 'batch']) for (const keepsUp of ['yes', 'no']) for (const buffer of ['owned', 'lent']) for (const efficiency of ['time', 'energy']) {
    const a = { threads, shape, keepsUp, buffer, efficiency };
    const r = await page.evaluate(a => recommendation(a), a);
    const call = keepsUp === 'yes' ? after[shape][threads === 'many' ? 1 : 0] : continuous[shape][threads === 'one' ? 0 : buffer === 'owned' ? 2 : 1];
    const use = keepsUp === 'yes' ? after[shape][2] : continuous[shape][threads === 'many' && buffer === 'owned' ? 4 : 3];
    assert.equal(r.call, call, JSON.stringify(a));
    assert.equal(r.use, use, JSON.stringify(a));
    routes++;
  }
  // Click every reachable ending; check what the reader sees.
  let endings = 0, measured = 0;
  for (const threads of [0, 1]) for (const shape of [0, 1, 2]) for (const keepsUp of [0, 1]) for (const buffer of threads === 0 && keepsUp === 1 ? [0, 1, 2, 3] : [null]) {
    if (await page.locator('#restart').isVisible()) await page.locator('#restart').click();
    for (const i of [threads, shape, keepsUp]) await page.locator('#choices button').nth(i).click();
    if (buffer !== null) await page.locator('#choices button').nth(buffer).click();
    if (threads === 0) await page.locator('#choices button').nth(0).click();
    const state = await page.evaluate(() => ({
      call: current.call, example: document.getElementById('example').textContent, unmeasured: !document.getElementById('unmeasured').hidden,
      rows: document.querySelectorAll('#latency tbody tr').length, dots: document.querySelectorAll('#chart circle').length,
      cells: [...document.querySelectorAll('#latency tbody td')].map(td => td.textContent),
      summary: document.getElementById('speed-summary').textContent, resultVisible: !document.getElementById('result').hidden,
    }));
    assert(state.resultVisible);
    assert(state.example.includes('fn main'), `${state.call}: a complete program`);
    assert(state.example.includes(state.call.replace('Queue::', '')), `${state.call}: the example calls it`);
    if (state.unmeasured) { assert.equal(state.call, 'Queue::pieces', 'only the >64 KiB queue cells may be absent from a quick run'); }
    else {
      measured++;
      assert(state.rows >= 1 && state.dots >= 2 * state.rows, `${state.call}: chart and table agree`);
      // Every latency reads as three significant digits with a unit.
      for (const cell of state.cells.filter((_, i) => i % (state.cells.length / state.rows) === 1)) assert(/^\d+(\.\d+)? (ns|µs|ms|s)/.test(cell), cell);
      assert(/ran faster|measured alone/.test(state.summary), state.summary);
      // The shared scenario redraws.
      await page.locator('#chip-shared').click();
      assert.equal(await page.evaluate(() => document.getElementById('chip-shared').getAttribute('aria-pressed')), 'true');
      await page.locator('#chip-solo').click();
    }
    endings++;
  }
  await page.locator('#restart').click();
  for (let i = 0; i < 3; i++) await page.locator('#choices button').last().click();
  assert.equal(await page.evaluate(() => current.call), 'hash');
  await page.locator('#back').click();
  assert((await page.locator('#q-title').innerText()).includes('keep up'));
  await page.locator('#restart').click();
  assert((await page.locator('#q-title').innerText()).includes('several threads'));
  const defaults = await page.evaluate(() => Object.fromEntries(Object.entries(QUESTIONS).map(([k, q]) => [k, q.choices.at(-1)[0]])));
  assert.deepEqual(defaults, { threads: 'one', shape: 'message', keepsUp: 'yes', buffer: 'lent', efficiency: 'time' });
  assert.deepEqual(errors, []);
  console.log(`${routes} table routes, ${endings} clicked endings (${measured} measured), defaults, Back, restart, examples, charts, tables: pass`);
  await browser.close();
})().catch(e => { console.error(e); process.exit(1); });
