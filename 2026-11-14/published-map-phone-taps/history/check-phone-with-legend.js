const fs = require('fs');
const path = require('path');
const assert = require('assert');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
const { checkPhone } = require('./phone-with-legend.js');
(async () => {
  const out = '<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication';
  const launch = () => chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  for (const [file, expected] of [
    ['published-m6-before.html', 'a phone tap opens its chart'],
    ['overbroad-m6.html', 'the open chart keeps its documentation link active']
  ]) {
    const browser = await launch();
    let failure;
    try { await checkPhone(browser, pathToFileURL(path.join(out, file)).href); }
    catch (error) { failure = error; }
    finally { await browser.close(); }
    assert(failure && failure.message.includes(expected), `${file}: expected the named fault`);
    console.log(`fault detected: ${file}: ${expected}`);
  }
  const browser = await launch();
  const records = JSON.parse(fs.readFileSync(out+'/all-maps/refresh-receipt.json')).maps;
  const checked = [];
  try {
    for (const record of records) {
      await checkPhone(browser, pathToFileURL(path.join('<development-home>/bench-phone-published', record.path)).href);
      checked.push({ map: record.path, phone: 'pass' });
      fs.writeFileSync(out+'/phone-results.json', JSON.stringify(checked, null, 2)+'\n');
      console.log(`phone interaction pass: ${record.path}`);
    }
  } finally { await browser.close(); }
  assert.equal(checked.length, 20);
  console.log('20 maps pass the shared phone contract; both deliberate controls fail as intended');
})().catch(error => { console.error(error); process.exit(1); });
