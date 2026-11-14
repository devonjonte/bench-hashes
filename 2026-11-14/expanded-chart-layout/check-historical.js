const fs=require('fs');
const path=require('path');
const {pathToFileURL}=require('url');
const assert=require('assert');
const {chromium}=require('playwright');
const {checkPhoneTargets}=require('./historical-targets.js');
(async()=>{
 const root='<development-home>/bench-zoom-layout',out='<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout';
 const maps=JSON.parse(fs.readFileSync(out+'/template-inventory.json')).maps.filter(m=>m.group>4);
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
 console.log('Five unchanged historical maps pass their version-matched target checker');
})().catch(e=>{console.error(e);process.exit(1);});
