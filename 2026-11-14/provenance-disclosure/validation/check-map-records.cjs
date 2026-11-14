const assert=require('node:assert/strict');
const fs=require('node:fs');const path=require('node:path');const {pathToFileURL}=require('node:url');const {execFileSync}=require('node:child_process');
const {chromium}=require('<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current/node_modules/playwright');
const {checkRecordStyle}=require('<development-home>/bench-provenance-door/tools/graph-check/overview.js');
(async()=>{
 const [repo,out]=process.argv.slice(2);fs.mkdirSync(out,{recursive:true});
 const maps=execFileSync('git',['ls-files','*.map.html'],{cwd:repo,encoding:'utf8'}).trim().split('\n').filter(f=>/^(benchmark-results|beside)\//.test(f));
 assert.equal(maps.length,20);
 const browser=await chromium.launch({executablePath:chromium.executablePath()});const results=[];
 try {
  for(const width of [390,1200]) for(const file of maps){
   const page=await browser.newPage({viewport:{width,height:900},isMobile:width===390,hasTouch:width===390});
   const errors=[];page.on('pageerror',e=>errors.push(e.message));
   await page.goto(pathToFileURL(path.join(repo,file)).href);
   const records=page.locator('details.run');const n=await records.count();
   for(let i=0;i<n;i++){
    const r=records.nth(i);
    if(!await r.evaluate(d=>d.open)) await r.locator(':scope > summary').click();
    await checkRecordStyle(r);
    if(file.includes('AppleM6.')&&i===0) await page.screenshot({path:path.join(out,`m6-record-${width}.png`)});
    await r.locator(':scope > summary').click();
   }
   assert.deepEqual(errors,[]);
   results.push({file,width,records:n,style:'pass'});console.log(file,width,n,'records pass');
   await page.context().close();
  }
 } finally {await browser.close();fs.writeFileSync(path.join(out,'results.json'),JSON.stringify(results,null,2)+'\n');}
})().catch(e=>{console.error(e);process.exitCode=1});
