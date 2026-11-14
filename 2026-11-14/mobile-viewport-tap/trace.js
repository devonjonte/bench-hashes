const fs=require('fs');
const {pathToFileURL}=require('url');
const {chromium}=require('playwright');
(async()=>{
 const out=process.argv[2];if(!out)throw Error('name the output directory');fs.mkdirSync(out,{recursive:true});
 const url=pathToFileURL('<development-home>/bench-phone-published/benchmark-results/AppleM6.darwin27/bench-hashes.map.html').href;
 const browser=await chromium.launch({executablePath:chromium.executablePath(),args:['--no-sandbox']});
 fs.writeFileSync(out+'/versions.json',JSON.stringify({playwright:require('playwright/package.json').version,chromium:browser.version(),node:process.version},null,2)+'\n');
 const results=[];
 try{for(const config of [
  {name:'desktop-mouse',hasTouch:false,isMobile:false,chip:'click',cell:'click'},
  {name:'wide-touch',hasTouch:true,isMobile:false,chip:'tap',cell:'tap'},
  {name:'wide-mobile-touch',hasTouch:true,isMobile:true,chip:'tap',cell:'tap'},
  {name:'wide-mobile-mixed',hasTouch:true,isMobile:true,chip:'click',cell:'tap'}
 ]){
  const page=await browser.newPage({viewport:{width:1200,height:900},hasTouch:config.hasTouch,isMobile:config.isMobile});
  await page.addInitScript(()=>{
   window.trace=[];
   const record=kind=>{if(window.trace.length<100)window.trace.push({kind,x:scrollX,y:scrollY,client:[document.documentElement.clientWidth,document.documentElement.clientHeight],inner:[innerWidth,innerHeight],visual:visualViewport&&{width:visualViewport.width,height:visualViewport.height,scale:visualViewport.scale,offsetLeft:visualViewport.offsetLeft,offsetTop:visualViewport.offsetTop}});};
   window.recordTrace=record;addEventListener('resize',()=>record('resize'));addEventListener('scroll',()=>record('scroll'),{passive:true});
  });
  await page.goto(url);await page.evaluate(()=>recordTrace('loaded'));
  for(const label of ['CPU','joule']){const b=page.locator('.measures button',{hasText:label}).first();if(!(await b.isDisabled()))await b[config.chip]();}
  await page.evaluate(()=>recordTrace('chips changed'));
  const cell=page.locator('.cell[data-key="0:solo|one|lent"]');
  let failure='';try{await cell[config.cell]({timeout:5000});}catch(error){failure=error.message;}
  const observed=await page.evaluate(()=>{
   recordTrace('action ended');const c=document.querySelector('.cell[data-key="0:solo|one|lent"]'),r=c.getBoundingClientRect();
   const hit=document.elementFromPoint((r.left+r.right)/2,(r.top+r.bottom)/2);
   return {trace:window.trace,target:{left:r.left,right:r.right,top:r.top,bottom:r.bottom},hit:hit?.closest('.cell')?.dataset.key||hit?.tagName,zooms:document.querySelectorAll('.zoom').length};
  });
  results.push({config,...observed,failure});await page.screenshot({path:out+'/'+config.name+'.png'});await page.context().close();
  fs.writeFileSync(out+'/results.json',JSON.stringify(results,null,2)+'\n');console.log(config.name,observed.zooms,failure?'failed':'opened',observed.trace.length,'events');
 }}finally{await browser.close();}
})().catch(error=>{console.error(error);process.exit(1);});
