const fs = require('node:fs');
const {chromium} = require('<development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current/node_modules/playwright');
(async()=>{
 const out='<development-home>/bench-hashes-validation/provenance-visibility';
 const browser=await chromium.launch({executablePath:chromium.executablePath()});
 try {
  const page=await browser.newPage({viewport:{width:1280,height:900}});
  await page.goto('https://servil-software-factory.github.io/bench-hashes/',{waitUntil:'load'});
  await page.screenshot({path:out+'/index-desktop.png'});
  const links=await page.locator('a.run').evaluateAll(nodes=>nodes.map(a=>({text:a.textContent,href:a.href,visible:a.getClientRects().length>0,top:a.getBoundingClientRect().top,color:getComputedStyle(a).color,decoration:getComputedStyle(a).textDecorationLine})));
  const first=page.locator('a.run:visible').first();
  await Promise.all([page.waitForURL('**/*#run'),first.click()]);
  const details=page.locator('details.run').first();
  await details.waitFor();
  const record=await details.evaluate(d=>({open:d.open,title:d.querySelector('summary').textContent,rows:[...d.querySelectorAll('dt')].map(t=>({label:t.textContent,value:t.nextElementSibling.textContent,href:t.nextElementSibling.querySelector('a')?.href}))}));
  await page.screenshot({path:out+'/opened-record.png',fullPage:false});
  fs.writeFileSync(out+'/observations.json',JSON.stringify({browser:browser.version(),links,url:page.url(),record},null,2)+'\n');
  console.log(JSON.stringify({links:links.length,visibleLinks:links.filter(a=>a.visible).length,firstTop:links.find(a=>a.visible).top,url:page.url(),recordOpen:record.open,recordTitle:record.title,labels:record.rows.map(r=>r.label)},null,2));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
