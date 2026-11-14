const fs = require('fs');
const path = require('path');
const assert = require('assert');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
const { checkPhoneTargets } = require('<development-home>/bench-phone-published/tools/graph-check/map.js');
(async () => {
  const out = '<development-home>/bench-hashes-validation/autonomous-20261114/phone-publication';
  const browser = await chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  const check = async file => {
    const phone = await browser.newPage({ viewport: { width: 420, height: 860 }, hasTouch: true, isMobile: true });
    const errors = [];
    phone.on('pageerror', error => errors.push(error.message));
    try {
      await phone.goto(pathToFileURL(file).href);
      await checkPhoneTargets(phone);
      assert.deepEqual(errors, []);
    } finally { await phone.context().close(); }
  };
  try {
    for (const [file, expected] of [
      ['published-m6-before.html', 'a phone tap opens its chart'],
      ['overbroad-m6.html', 'the open chart keeps its documentation link active']
    ]) {
      let failure;
      try { await check(path.join(out, file)); } catch (error) { failure = error; }
      assert(failure && failure.message.includes(expected), `${file}: expected the named fault`);
      console.log(`fault detected: ${file}: ${expected}`);
    }
    const records = JSON.parse(fs.readFileSync(out+'/all-maps/refresh-receipt.json')).maps;
    const checked = [];
    for (const record of records) {
      await check(path.join('<development-home>/bench-phone-published', record.path));
      checked.push({ map: record.path, phoneTargets: 'pass' });
      fs.writeFileSync(out+'/phone-target-results.json', JSON.stringify(checked, null, 2)+'\n');
      console.log(`phone target pass: ${record.path}`);
    }
    assert.equal(checked.length, 20);
    console.log('20 maps pass the shared target contract; both deliberate controls fail as intended');
  } finally { await browser.close(); }
})().catch(error => { console.error(error); process.exit(1); });
