const fs=require('node:fs');const assert=require('node:assert/strict');
const {chromium}=require('<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current/node_modules/playwright');
(async()=>{
 const [url,out]=process.argv.slice(2);const expected=fs.readFileSync('<development-home>/bench-provenance-door/index.html','utf8');
 const browser=await chromium.launch({executablePath:chromium.executablePath()});
 try{for(const width of [390,1280]){
  const page=await browser.newPage({viewport:{width,height:900},isMobile:width===390,hasTouch:width===390});
  const response=await page.goto(url);assert.equal(await response.text(),expected,'deployed index is the reviewed file');
  await page.screenshot({path:out+`/results-${width}.png`});
  await page.getByText('About the hashes compared',{exact:true}).click();
  await page.locator('#hashes').scrollIntoViewIfNeeded();await page.screenshot({path:out+`/about-${width}.png`});
  const machine=page.locator('details.record').filter({has:page.locator('summary').filter({hasText:'Apple M6'})});
  await machine.locator(':scope > summary').click();await machine.scrollIntoViewIfNeeded();
  await page.screenshot({path:out+`/sources-${width}.png`});await page.context().close();
 }}finally{await browser.close();}
 console.log('Live desktop and phone screenshots match the reviewed index');
})().catch(e=>{console.error(e);process.exitCode=1});
