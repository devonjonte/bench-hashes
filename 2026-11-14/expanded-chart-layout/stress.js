const fs = require('fs');
const path = require('path');
const assert = require('assert');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
const { checkZoomLayout } = require('<development-home>/bench-zoom-layout/tools/graph-check/map.js');
(async () => {
  const [root,out] = process.argv.slice(2); fs.mkdirSync(out,{recursive:true});
  const browser = await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});
  const records=[];
  try {
    for(const folder of ['AppleM6.darwin27','12thGenIntelRCoreTMi712700K.linux70042generic']) {
      const page=await browser.newPage({viewport:{width:1200,height:900},hasTouch:true,isMobile:true});
      const errors=[];page.on('pageerror',e=>errors.push(e.message));
      await page.goto(pathToFileURL(path.join(root,'benchmark-results',folder,'bench-hashes.map.html')).href+'#'+encodeURIComponent('0:solo|one|lent'));
      await page.waitForTimeout(300);
      assert.equal(await page.locator('.zoom').count(),1,'the public chart link opens the selected input');
      const enabled=[];
      for(const label of ['CPU','joule']) {
        const button=page.locator('.measures button',{hasText:label}).first();
        if(!(await button.isDisabled())) {await button.click();enabled.push(label);}
      }
      for(const [width,height] of [[320,568],[420,860],[1200,900]]) {
        await page.setViewportSize({width,height});await page.waitForTimeout(300);
        for(const cost of [false,true]) {
          if(cost) {await page.locator('.measures .switch').click();await page.waitForTimeout(100);}
          await checkZoomLayout(page);
          const shown=page.locator('.zoom .key button:not(.off)').first();const name=await shown.textContent();
          await shown.click();await page.waitForTimeout(100);await checkZoomLayout(page);
          const button=page.locator('.zoom .key').getByRole('button',{name,exact:true});
          await button.click();await page.waitForTimeout(100);await checkZoomLayout(page);
          records.push({folder,width,height,cost,enabledMeasures:enabled,layout:'pass'});
          await page.screenshot({path:path.join(out,`${folder}-${width}-${cost?'cost':'rate'}.png`)});
          if(cost) {await page.locator('.measures .switch').click();await page.waitForTimeout(100);}
        }
      }
      assert.deepEqual(errors,[]);
      await page.context().close();
    }
  } finally {await browser.close();}
  fs.writeFileSync(path.join(out,'results.json'),JSON.stringify(records,null,2)+'\n');
  console.log(`${records.length} resize/measure/legend states pass geometry checks`);
})().catch(error=>{console.error(error);process.exit(1);});
