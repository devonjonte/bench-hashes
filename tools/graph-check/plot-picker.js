// Browser contract: direct selections, keyboard/touch activation, recovery
// from empty, and no changes to the embedded display data or plotted values.
const fs = require("fs"), assert = require("assert/strict"), {pathToFileURL} = require("url");
const {chromium} = require("playwright");
(async () => {
  const browser = await chromium.launch({executablePath:process.argv[3],headless:true,args:["--no-sandbox"]});
  try {
    const page = await browser.newPage({viewport:{width:1400,height:900},hasTouch:true});
    const errors=[];page.on("pageerror",error=>errors.push(error.message));
    await page.goto(pathToFileURL(process.argv[2]).href);
    const before = await page.evaluate(()=>JSON.stringify(DATA));
    const count = await page.locator(".plot-choice").count();
    assert(count>0);
    await page.locator("#plot-picker-button").tap();
    assert(await page.locator("#plot-picker-panel").isVisible());
    await page.locator("#plot-picker-clear").tap();
    assert(await page.locator("#empty-plots").isVisible());
    const check = async indices => assert.deepEqual(await page.evaluate(()=>DATA.plots.map((_,i)=>i).filter(i=>!document.getElementById(`plot-${i}`).classList.contains("plot-off"))),indices);
    await check([]);
    for (let p=0;p<count;p++) {
      await page.locator(`#plot-choice-${p}`).tap();await check([p]);
      await page.locator(`#plot-choice-${p}`).press("Space");await check([]);
    }
    // Select arbitrary subsets, including combinations the old Cartesian
    // filters could never express. Only clicked plots change.
    let expected=[];
    for(let p=count-1;p>=0;p-=2){await page.locator(`#plot-choice-${p}`).click();expected.push(p);}
    await check(expected.sort((a,b)=>a-b));
    await page.locator("#plot-picker-done").press("Enter");
    assert(!(await page.locator("#plot-picker-panel").isVisible()));
    await page.locator("#plot-picker-button").press("Space");
    await page.locator("#plot-picker-all").press("Enter");await check(Array.from({length:count},(_,i)=>i));
    await page.locator("#plot-picker-done").press("Escape");
    assert(!(await page.locator("#plot-picker-panel").isVisible()));
    assert.equal(await page.evaluate(()=>JSON.stringify(DATA)),before);
    await page.locator("#plot-picker-button").click();
    if(process.argv[4])await page.screenshot({path:process.argv[4]});
    assert.deepEqual(errors,[]);
    console.log(`Browser passes: ${count} individually reachable plots, arbitrary subsets, empty/recovery, mouse/touch/keyboard, unchanged data`);
  } finally {await browser.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
