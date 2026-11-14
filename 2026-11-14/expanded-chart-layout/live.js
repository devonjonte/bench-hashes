const fs=require('fs');
const assert=require('assert');
const {chromium}=require('playwright');
const {checkZoomLayout,checkPhoneTargets}=require('<development-home>/bench-zoom-layout/tools/graph-check/map.js');
(async()=>{
 const [url,out]=process.argv.slice(2);const browser=await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});const records=[];
 fs.writeFileSync(out+'/live-versions.json',JSON.stringify({playwright:require('playwright/package.json').version,chromium:browser.version()},null,2)+'\n');
 try{for(const [width,height] of [[320,568],[420,860],[1200,900]]){
  const mobile=width<1000,page=await browser.newPage({viewport:{width,height},hasTouch:mobile,isMobile:mobile});const errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.goto(url);const cell=page.locator('.cell:not(.empty)').first();if(mobile)await cell.tap();else await cell.click({position:{x:100,y:30}});await page.waitForTimeout(300);
  await checkZoomLayout(page);await page.screenshot({path:out+`/live-${width}.png`});
  if(mobile){await page.goto(url);await checkPhoneTargets(page);}assert.deepEqual(errors,[]);
  records.push({width,height,geometry:'pass',touchTargets:mobile?'pass':'not requested'});await page.context().close();
 }}finally{await browser.close();}
 fs.writeFileSync(out+'/live-checks.json',JSON.stringify(records,null,2)+'\n');console.log('Live M6 geometry and phone targets pass at all three viewports');
})().catch(e=>{console.error(e);process.exit(1);});
