const assert = require('assert');
async function checkPhone(browser, url) {
  const errors = [];
  // A touch screen: tap a chart open, tap it for its values, tap the button.
  const phone = await browser.newPage({ viewport: { width: 420, height: 860 }, hasTouch: true, isMobile: true });
  phone.on('pageerror', e => errors.push(e.message));
  await phone.goto(url);
  await phone.locator('.cell:not(.empty)').first().tap();
  await phone.waitForTimeout(300);
  assert.equal(await phone.locator('.zoom').count(), 1, 'a phone tap opens its chart');
  assert(await phone.locator('.zoom .title a.doc').evaluate(a => getComputedStyle(a).pointerEvents !== 'none'), 'the open chart keeps its documentation link active');
  const zoom = await phone.locator('.zoom').boundingBox();
  await phone.touchscreen.tap(zoom.x + zoom.width * 0.6, zoom.y + zoom.height * 0.5);
  await phone.waitForTimeout(150);
  assert.equal(await phone.locator('.zoom').count(), 1, 'a tap on an open chart keeps it open');
  assert(await phone.locator('#tip').isVisible(), 'a tap shows the values at its point');
  // A name in the open chart is its contender's toggle: a tap hides its
  // lines (fewer drawn), marks the name off, and the chart stays open; a
  // second tap brings them back.
  // A contender's marks: a line as a polyline or a path, a lone point as a circle.
  const lines = async () => phone.locator('.zoom svg polyline, .zoom svg path, .zoom svg circle').count();
  const all = await lines();
  const shown = phone.locator('.zoom .key button:not(.off)').first();
  const name = await shown.textContent();
  const named = () => phone.locator('.zoom .key button', { hasText: new RegExp('^' + name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '$') });
  await shown.tap(); await phone.waitForTimeout(300);
  assert.equal(await phone.locator('.zoom').count(), 1, 'a name tapped keeps the chart open');
  assert(/\boff\b/.test(await named().getAttribute('class')), 'the tapped name shows off');
  assert((await lines()) < all, 'its lines are hidden');
  await named().tap(); await phone.waitForTimeout(300);
  assert.equal(await lines(), all, 'a second tap brings them back');
  await phone.locator('.zoom .close').tap();
  await phone.waitForTimeout(300);
  assert.equal(await phone.locator('.zoom').count(), 0, 'the button puts the chart back');
  // On a phone the small chart's call name is part of its opening target.
  const small = phone.locator('.cell:not(.empty)').first();
  await small.scrollIntoViewIfNeeded();
  const c = await small.boundingBox(), d = await small.locator('a.doc').boundingBox();
  const x = (Math.max(c.x, d.x) + Math.min(c.x+c.width, d.x+d.width)) / 2;
  const y = (Math.max(c.y, d.y) + Math.min(c.y+c.height, d.y+d.height)) / 2;
  await phone.touchscreen.tap(x, y);
  await phone.waitForTimeout(300);
  assert.equal(await phone.locator('.zoom').count(), 1, 'a tap on the small call name opens its chart');
  await phone.context().close();
  assert.deepEqual(errors, []);
}
module.exports = { checkPhone };
