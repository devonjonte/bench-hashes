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
      const zoomsAfterTap = await page.locator('.zoom').count();
      let zoomsAfterNameTap = null;
      if (zoomsAfterTap && docs) {
        await page.locator('.zoom .close').tap();
        await page.waitForTimeout(300);
        const cell = page.locator('.cell:not(.empty)').first();
        await cell.scrollIntoViewIfNeeded();
        const c = await cell.boundingBox(), d = await cell.locator('a.doc').boundingBox();
        const x = (Math.max(c.x, d.x) + Math.min(c.x+c.width, d.x+d.width)) / 2;
        const y = (Math.max(c.y, d.y) + Math.min(c.y+c.height, d.y+d.height)) / 2;
        await page.touchscreen.tap(x, y);
        await page.waitForTimeout(300);
        zoomsAfterNameTap = await page.locator('.zoom').count();
      }
      records.push({ file: relative, charts, docs, zoomsAfterTap, zoomsAfterNameTap, errors });
      await page.context().close();
    }
  }
  await browser.close();
  console.log(JSON.stringify(records, null, 2));
})().catch(error => { console.error(error); process.exit(1); });
