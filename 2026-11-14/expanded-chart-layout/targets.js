const fs=require('fs');
const path=require('path');
const {pathToFileURL}=require('url');
const {execFileSync}=require('child_process');
const assert=require('assert');
const {chromium}=require('playwright');
const {checkPhoneTargets}=require('<development-home>/bench-zoom-layout/tools/graph-check/map.js');
(async()=>{
 const root='<development-home>/bench-zoom-layout',out='<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout';
 const maps=execFileSync('git',['ls-files','*.map.html'],{cwd:root,encoding:'utf8'}).trim().split('\n').filter(p=>p.startsWith('benchmark-results/')||p.startsWith('beside/'));assert.equal(maps.length,20);
 const browser=await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});
 const records=[];
 try {for(const map of maps){
  const phone=await browser.newPage({viewport:{width:420,height:860},hasTouch:true,isMobile:true});
  const errors=[];phone.on('pageerror',e=>errors.push(e.message));
  await phone.goto(pathToFileURL(path.join(root,map)).href);await checkPhoneTargets(phone);assert.deepEqual(errors,[]);
  records.push({map,targets:'pass'});console.log(map,'pass');await phone.context().close();
 }}finally{await browser.close();}
 fs.writeFileSync(out+'/installed-targets.json',JSON.stringify(records,null,2)+'\n');
})().catch(e=>{console.error(e);process.exit(1);});
