const assert = require('assert');
const { chromium } = require('playwright');
const { checkPhoneTargets } = require('<development-home>/bench-phone-published/tools/graph-check/map.js');
(async () => {
  const browser = await chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  try {
    const page = await browser.newPage({ viewport: { width: 420, height: 860 }, hasTouch: true, isMobile: true });
    const errors = [];
    page.on('pageerror', error => errors.push(error.message));
    await page.goto(process.argv[2]);
    await checkPhoneTargets(page);
    assert.deepEqual(errors, []);
    console.log('Deployed M6 page passes centre/call-name targets, tooltip, close and documentation pointer checks');
  } finally { await browser.close(); }
})().catch(error => { console.error(error); process.exit(1); });
