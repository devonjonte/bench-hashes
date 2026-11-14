const fs = require('fs');
const path = require('path');
const assert = require('assert');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
const { checkZoomLayout, checkPhoneTargets } = require('<development-home>/bench-zoom-layout/tools/graph-check/map.js');
(async () => {
  const [root, out, mode] = process.argv.slice(2);
  fs.mkdirSync(out, { recursive: true });
  const browser = await chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  const records = [];
  try {
    for (const [width,height] of [[320,568],[320,900],[420,860],[1200,900]]) for (const file of [
      'benchmark-results/AppleM6.darwin27/bench-hashes.map.html',
      'benchmark-results/12thGenIntelRCoreTMi712700K.linux70042generic/bench-hashes.map.html'
    ]) {
      const mobile = width < 1000;
      const page = await browser.newPage({ viewport:{width,height},hasTouch:mobile,isMobile:mobile });
      const errors=[];page.on('pageerror',e=>errors.push(e.message));
      const url=pathToFileURL(path.join(root,file)).href;
      await page.goto(url);
      const cell=page.locator('.cell:not(.empty)').first();
      if(mobile) await cell.tap();else await cell.click({position:{x:100,y:30}});
      await page.waitForTimeout(600);
      const tipOnOpening=await page.locator('#tip').isVisible();
      let problems=[];
      try { await checkZoomLayout(page); }
      catch(error) { assert(Array.isArray(error.actual),String(error));problems=error.actual; }
      const tipAfterGeometry=await page.locator('#tip').isVisible();
      const record={width,height,file,problems,tipOnOpening,tipAfterGeometry,errors};records.push(record);
      await page.screenshot({path:path.join(out,`${width}-${height}-${file.includes('AppleM6')?'m6':'i7'}.png`)});
      fs.writeFileSync(path.join(out,'checks.json'),JSON.stringify(records,null,2)+'\n');
      console.log(JSON.stringify(record));
      if(mode==='before') {
        if(mobile) assert(problems.includes('title overlaps legend'));
      } else {
        assert.deepEqual(problems,[]);
        if(mobile) assert(!tipOnOpening && !tipAfterGeometry,'opening/scrolling a touch chart waits for a point tap');
        if(mobile) {await page.goto(url);await checkPhoneTargets(page);}
        assert.deepEqual(errors,[]);
      }
      await page.context().close();
    }
  } finally { await browser.close(); }
  console.log(mode==='before'?'Original layout defects reproduced':'Layout and interactions pass at every declared viewport');
})().catch(error=>{console.error(error);process.exit(1);});
