const fs = require('fs');
const path = require('path');
const { pathToFileURL } = require('url');
const { chromium } = require('playwright');
(async () => {
  const root = '<development-home>/bench-zoom-layout';
  const out = '<development-home>/bench-hashes-validation/autonomous-20261114/zoom-layout';
  const browser = await chromium.launch({ executablePath: chromium.executablePath(), args: ['--no-sandbox'] });
  const records = [];
  try {
    for (const width of [320, 420, 1200]) for (const file of [
      'benchmark-results/AppleM6.darwin27/bench-hashes.map.html',
      'benchmark-results/12thGenIntelRCoreTMi712700K.linux70042generic/bench-hashes.map.html'
    ]) {
      const phone = width < 1000;
      const page = await browser.newPage({ viewport: { width, height: 900 }, hasTouch: phone, isMobile: phone });
      await page.goto(pathToFileURL(path.join(root, file)).href);
      const cell = page.locator('.cell:not(.empty)').first();
      if (phone) await cell.tap(); else await cell.click({ position: { x: 100, y: 30 } });
      await page.waitForTimeout(300);
      const result = await page.evaluate(() => {
        const box = el => { const r = el.getBoundingClientRect(); return { left:r.left, right:r.right, top:r.top, bottom:r.bottom, width:r.width, height:r.height }; };
        const z = document.querySelector('.zoom'), svg = z.querySelector(':scope > svg');
        const title = box(z.querySelector('.title')), legend = box(z.querySelector('.key')), frame = box(z), plot = box(svg);
        const cursor = svg.querySelector('.cursor');
        const plotTop = plot.top + Number(cursor.getAttribute('y1')) * plot.height / Number(svg.getAttribute('height'));
        const doc = z.querySelector('.title a.doc'), dr = doc.getClientRects()[0];
        const x = (Math.max(dr.left, frame.left) + Math.min(dr.right, frame.right, innerWidth))/2;
        const y = (Math.max(dr.top, frame.top) + Math.min(dr.bottom, frame.bottom, innerHeight))/2;
        const hit = document.elementFromPoint(x, y);
        const clipped = [...svg.querySelectorAll('text')].map(t => ({ text:t.textContent, ...box(t) }))
          .filter(t => t.left < frame.left+1 || t.right > frame.right-1 || t.top < frame.top+1 || t.bottom > frame.bottom-1);
        return { title, legend, frame, plotTop, titleLegendOverlap:title.bottom > legend.top,
          headerReachesPlot:Math.max(title.bottom,legend.bottom)>plotTop, docHit:!!hit && (hit===doc || doc.contains(hit)), hit:hit?.className, clipped };
      });
      records.push({ width, file, ...result });
      await page.screenshot({ path:out+`/before-${width}-${file.includes('AppleM6')?'m6':'i7'}.png` });
      await page.context().close();
    }
  } finally { await browser.close(); }
  fs.writeFileSync(out+'/before-geometry.json', JSON.stringify(records,null,2)+'\n');
  for (const r of records) console.log(r.width,r.file,JSON.stringify({overlap:r.titleLegendOverlap,headerReachesPlot:r.headerReachesPlot,docHit:r.docHit,clipped:r.clipped.length}));
})().catch(error => { console.error(error); process.exit(1); });
