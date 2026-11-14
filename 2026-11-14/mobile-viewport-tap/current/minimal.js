const { chromium } = require('playwright');
const fs = require('fs');
(async () => {
  const browser = await chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  const results = [];
  try {
    for (const isMobile of [false, true]) {
      const page = await browser.newPage({ viewport: { width: 1200, height: 900 }, hasTouch: true, isMobile });
      await page.setContent(`<!doctype html><meta name="viewport" content="width=device-width,initial-scale=1">
        <style>body{margin:0}main{position:relative;width:1534px;height:1600px}button{position:absolute;top:391px;width:210px;height:98px}</style>
        <main><button id="target" style="left:1108px" onclick="window.hit='target'">target</button>
        <button id="other" style="left:1324px" onclick="window.hit='other'">other</button></main>`);
      let failure = '';
      try { await page.locator('#target').tap({ timeout: 3000 }); } catch (e) { failure = e.message; }
      const before = await page.evaluate(() => { const r = document.querySelector('#target').getBoundingClientRect(); return { hit: window.hit, x: (r.left+r.right)/2, y:(r.top+r.bottom)/2, offsetLeft:visualViewport.offsetLeft,offsetTop:visualViewport.offsetTop,innerWidth,clientWidth:document.documentElement.clientWidth }; });
      await page.touchscreen.tap(before.x-before.offsetLeft,before.y-before.offsetTop);
      const direct = await page.evaluate(() => window.hit);
      results.push({isMobile,failure,before,direct});await page.context().close();
    }
  } finally { await browser.close(); }
  fs.writeFileSync(__dirname+'/minimal-results.json', JSON.stringify(results,null,2)+'\n');
  for (const r of results) console.log(r.isMobile, r.failure?'locator failed':'locator opened', r.direct, r.before);
})().catch(e=>{console.error(e);process.exit(1);});
