const fs = require('fs');
const path = require('path');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
(async () => {
  const root = '<development-home>/bench-phone-published';
  const browser = await chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  const records = [];
  for (const folder of fs.readdirSync(path.join(root, 'beside')).sort()) {
    for (const file of fs.readdirSync(path.join(root, 'beside', folder)).filter(f => f.endsWith('.map.html')).sort()) {
      const page = await browser.newPage({ viewport: { width: 420, height: 860 }, hasTouch: true, isMobile: true });
      await page.context().route('https://**/*', route => route.fulfill({ contentType: 'text/plain', body: 'documentation link opened' }));
      const errors = [];
      page.on('pageerror', error => errors.push(error.message));
      const relative = path.join('beside', folder, file);
      await page.goto(pathToFileURL(path.join(root, relative)).href);
      const charts = await page.locator('.cell:not(.empty)').count();
      const docs = await page.locator('.cell a.doc').count();
      if (charts) {
        await page.locator('.cell:not(.empty)').first().tap();
        await page.waitForTimeout(300);
      }
      records.push({ file: relative, charts, docs, zoomsAfterTap: await page.locator('.zoom').count(), errors });
      await page.context().close();
    }
  }
  await browser.close();
  console.log(JSON.stringify(records, null, 2));
})().catch(error => { console.error(error); process.exit(1); });
