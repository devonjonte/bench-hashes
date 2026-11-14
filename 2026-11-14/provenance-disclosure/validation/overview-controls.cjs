const assert=require('node:assert/strict');const fs=require('node:fs');const {pathToFileURL}=require('node:url');
const {chromium}=require('<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current/node_modules/playwright');
const {checkProvenance}=require('<development-home>/bench-provenance-door/tools/graph-check/overview.js');
(async()=>{
 const out='<development-home>/bench-hashes-validation/provenance-visibility';const url=pathToFileURL('<development-home>/bench-provenance-door/index.html').href;
 const browser=await chromium.launch({executablePath:chromium.executablePath()});const results=[];
 try {
  for(const [name,expected] of [['missing-source','preserves source blake3-servil'],['exposed-version','long version/commit strings stay out'],['faint-record','readable text contrast'],['open-by-default','provenance starts collapsed']]){
   const page=await browser.newPage({viewport:{width:1280,height:900}});await page.goto(url);
   await page.evaluate(name=>{
    const door=document.querySelector('#hashes');
    if(name==='missing-source') [...door.querySelectorAll('dd')].find(d=>d.textContent.startsWith('blake3-servil')).textContent='source removed by control';
    if(name==='exposed-version') {const t=[...door.querySelectorAll('dt')].find(d=>d.textContent==='bench-hashes');document.querySelector('.grid th.col').append(t.nextElementSibling.cloneNode(true));}
    if(name==='faint-record') {const style=document.createElement('style');style.textContent='.record dd {color:#9ca3af}';document.head.append(style);}
    if(name==='open-by-default') door.open=true;
   },name);
   let error;try{await checkProvenance(page);}catch(e){error=e;}
   assert(error&&error.message.includes(expected),name+': '+error?.message);
   results.push({name,rejected:error.message});console.log(name,'rejected:',error.message);
   await page.context().close();
  }
  for(const width of [390,1280]){
   const page=await browser.newPage({viewport:{width,height:900},isMobile:width===390,hasTouch:width===390});await page.goto(url);
   await page.screenshot({path:out+`/results-${width}.png`});
   await page.getByText('About the hashes compared',{exact:true}).click();
   await page.locator('#hashes').scrollIntoViewIfNeeded();
   await page.screenshot({path:out+`/about-${width}.png`});
   const machine=page.locator('details.record').filter({has:page.locator('summary').filter({hasText:'Apple M6'})});
   await machine.locator(':scope > summary').click();
   await machine.scrollIntoViewIfNeeded();
   await page.screenshot({path:out+`/sources-${width}.png`});
   const tools=machine.locator('.run-record').filter({has:page.getByRole('heading',{name:'File-tool run',exact:true})});
   await tools.locator('h4').scrollIntoViewIfNeeded();
   await page.screenshot({path:out+`/file-sources-${width}.png`});
   await page.context().close();
  }
 }finally{await browser.close();fs.writeFileSync(out+'/overview-controls.json',JSON.stringify(results,null,2)+'\n');}
})().catch(e=>{console.error(e);process.exitCode=1});
