// Screenshots of each mock-up page at laptop width, for the index.
const { chromium } = require('/home/agent/bench-hashes-validation/node_modules/playwright');
(async () => {
  const b = await chromium.launch(); const p = await b.newPage({ viewport: { width: 1280, height: 800 } });
  const errors = []; p.on('pageerror', e => errors.push(e.message));
  for (const s of ['a-all-nine','b-four-chosen','c-number-lines','d-families','e-heatmap','f-pick']) {
    await p.goto('file://' + __dirname + '/site/' + s + '.html'); await p.waitForTimeout(200);
    await p.screenshot({ path: __dirname + '/site/' + s + '.png', fullPage: true });
  }
  console.log(errors.length ? 'page errors: ' + errors.join('; ') : 'no page errors'); await b.close();
})();
