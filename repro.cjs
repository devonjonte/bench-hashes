const assert = require('node:assert/strict');
const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  console.log({ playwright: require('playwright/package.json').version, chromium: browser.version() });
  try {
    for (const isMobile of [false, true]) {
      const page = await browser.newPage({ viewport: { width: 1200, height: 900 }, hasTouch: true, isMobile });
      await page.setContent(`<!doctype html><meta name="viewport" content="width=device-width,initial-scale=1">
        <style>body{margin:0}main{position:relative;width:1534px;height:1600px}button{position:absolute;top:391px;width:210px;height:98px}</style>
        <main><button id="target" style="left:1108px" onclick="window.hit='target'">target</button>
        <button id="other" style="left:1324px" onclick="window.hit='other'">other</button></main>`);
      console.log({ isMobile });
      await page.locator('#target').tap({ timeout: 3000 });
      assert.equal(await page.evaluate(() => window.hit), 'target');
      await page.context().close();
    }
  } finally {
    await browser.close();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
