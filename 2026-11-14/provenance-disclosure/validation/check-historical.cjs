const fs=require('fs');
const path=require('path');
const {pathToFileURL}=require('url');
const assert=require('assert');
const {chromium}=require('<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current/node_modules/playwright');
const {checkPhoneTargets}=require('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout/historical-targets.js');
(async()=>{
 const root='<development-home>/bench-provenance-door',out='<development-home>/bench-hashes-validation/provenance-visibility';
 const maps=JSON.parse(fs.readFileSync('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout/template-inventory.json')).maps.filter(m=>m.group>4);
 const browser=await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});
 const records=[];
 try{for(const m of maps){
  const page=await browser.newPage({viewport:{width:420,height:860},hasTouch:true,isMobile:true});
  const errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.goto(pathToFileURL(path.join(root,m.path)).href);await checkPhoneTargets(page);assert.deepEqual(errors,[]);
  records.push({map:m.path,checker:'2059ff5e2235af6423d80c49de31f87cfd355f0c',targets:'pass'});
  await page.context().close();
 }}finally{await browser.close();}
 assert.equal(records.length,5);fs.writeFileSync(out+'/historical-target-results.json',JSON.stringify(records,null,2)+'\n');
 console.log('Five historical maps with the CSS-only record repair pass their version-matched target checker');
})().catch(e=>{console.error(e);process.exit(1);});
