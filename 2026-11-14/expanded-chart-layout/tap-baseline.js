const fs=require('fs');
const {pathToFileURL}=require('url');
const {chromium}=require('playwright');
(async()=>{
 const browser=await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});
 try {
  const page=await browser.newPage({viewport:{width:1200,height:900},hasTouch:true,isMobile:true});
  await page.goto(pathToFileURL('<development-home>/bench-zoom-layout/benchmark-results/AppleM6.darwin27/bench-hashes.map.html').href);
  const enabled=[];
  for(const label of ['CPU','joule']) {const b=page.locator('.measures button',{hasText:label}).first();if(!(await b.isDisabled())){await b.click();enabled.push(label);}}
  let result='opened',error='';
  try {await page.locator('.cell[data-key="0:solo|one|lent"]').tap({timeout:5000});}
  catch(e){result='tap failed before opening';error=e.message;}
  const record={source:'2059ff5e2235af6423d80c49de31f87cfd355f0c',enabled,result,zooms:await page.locator('.zoom').count(),error};
  fs.writeFileSync('<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout/tap-baseline.json',JSON.stringify(record,null,2)+'\n');
  console.log(JSON.stringify(record));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
