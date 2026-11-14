const fs=require('fs');
const {pathToFileURL}=require('url');
const {chromium}=require('playwright');
(async()=>{
 const out='<development-home>/bench-hashes-validation/autonomous-20261114/grid-input';
 const browser=await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});const results=[];
 try{for(const [version,root] of [['baseline','<development-home>/bench-phone-published'],['layout','<development-home>/bench-zoom-layout']])for(const adjusted of [false,true]){
  const page=await browser.newPage({viewport:{width:1200,height:900},hasTouch:true,isMobile:true});
  await page.goto(pathToFileURL(root+'/benchmark-results/AppleM6.darwin27/bench-hashes.map.html').href);
  for(const label of ['CPU','joule']){const b=page.locator('.measures button',{hasText:label}).first();if(!(await b.isDisabled()))await b.tap();}
  const cell=page.locator('.cell[data-key="0:solo|one|lent"]');await cell.scrollIntoViewIfNeeded();
  const before=await page.evaluate(()=>{const r=document.querySelector('.cell[data-key="0:solo|one|lent"]').getBoundingClientRect();return {x:(r.left+r.right)/2,y:(r.top+r.bottom)/2,offsetLeft:visualViewport.offsetLeft,offsetTop:visualViewport.offsetTop,scale:visualViewport.scale};});
  const x=before.x-(adjusted?before.offsetLeft:0),y=before.y-(adjusted?before.offsetTop:0);
  await page.touchscreen.tap(x,y);await page.waitForTimeout(300);
  const after=await page.evaluate(()=>{const z=document.querySelector('.zoom'),r=z?.getBoundingClientRect();return {opened:OPEN,zooms:document.querySelectorAll('.zoom').length,frame:r&&{left:r.left,right:r.right,top:r.top,bottom:r.bottom},visual:{left:visualViewport.offsetLeft,top:visualViewport.offsetTop,width:visualViewport.width,height:visualViewport.height}};});
  results.push({version,adjusted,before,input:{x,y},after});console.log(JSON.stringify(results.at(-1)));await page.context().close();
 }}finally{await browser.close();}
 fs.writeFileSync(out+'/coordinates.json',JSON.stringify(results,null,2)+'\n');
})().catch(e=>{console.error(e);process.exit(1);});
