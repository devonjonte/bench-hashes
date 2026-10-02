// Drive the graph's script in jsdom: zoom steps, in/out/all, unit switch
// during a zoom, toggles, hover; check positions, labels, the zoom band and
// its fixed buttons, and that no attribute holds NaN.
const fs = require("fs");
const { JSDOM } = require("jsdom");
const path = process.argv[2];
const svg = fs.readFileSync(path, "utf8").replace(/^<\?xml[^>]*>/, "");
const script = svg.match(/<script><!\[CDATA\[([\s\S]*)\]\]><\/script>/)[1];
const markup = svg.replace(/<script><!\[CDATA\[[\s\S]*\]\]><\/script>/, "");
const dom = new JSDOM(`<!DOCTYPE html><html><body>${markup}</body></html>`, { runScripts: "outside-only", pretendToBeVisual: true });
const w = dom.window;
w.eval(script + "\n;window.__on = on; window.__t = {DATA, ALLB, setZoom, plotOn, plotShift, get belowShift() { return belowShift; }, win: () => win, currentX, get zFrom() { return zFrom; }, get zTo() { return zTo; }};");
const T = w.__t, D = T.DATA;
// Step an end of the range, as the band's grips do one tick at a time.
w.zoomStep = (end, delta) => end === "from" ? T.setZoom(T.zFrom + delta, T.zTo) : T.setZoom(T.zFrom, T.zTo + delta);
const sleep = ms => new Promise(r => setTimeout(r, ms));
let failures = 0;
const check = (cond, what) => { if (!cond) { failures++; console.log("FAIL", what); } };
const L = D.plotLeft + D.xInset, R = D.plotRight - D.xInset;

function noNaN(tag) {
  const bad = [...w.document.querySelectorAll("*")].filter(el => [...el.attributes].some(a => /NaN|Infinity|undefined/.test(a.value)));
  check(bad.length === 0, `${tag}: ${bad.length} elements with NaN/Infinity/undefined, e.g. ${bad[0] && bad[0].outerHTML.slice(0, 160)}`);
}
function checkLayout(tag) {
  D.plots.forEach((plot, p) => {
    const x = T.currentX[p], wd = T.win()[p];
    /* A plot of one point keeps it in the middle; every other window spans the plot. */
    if (x.length === 1) check(Math.abs(x[0] - (L + R) / 2) < 0.05, `${tag}: plot ${p}'s one point at ${x[0]}, not the middle`);
    else check(Math.abs(x[wd.k0] - L) < 0.05 && Math.abs(x[wd.k1] - R) < 0.05, `${tag}: plot ${p} window ends at ${x[wd.k0]}, ${x[wd.k1]}`);
    for (let k = 0; k < x.length; k++) {
      const inside = k >= wd.k0 && k <= wd.k1;
      check(inside === (x[k] >= L - 0.05 && x[k] <= R + 0.05), `${tag}: plot ${p} point ${k} at ${x[k]} inside=${inside}`);
      const label = w.document.querySelector(`.size-label[data-plot="${p}"][data-size="${k}"]`);
      check(Math.abs(+label.getAttribute("x") - x[k]) < 0.05, `${tag}: plot ${p} label ${k} x`);
      if (!(x[k] >= D.plotLeft - 12 && x[k] <= D.plotRight + 12)) check(+label.getAttribute("opacity") === 0, `${tag}: plot ${p} label ${k} outside the plot is hidden`);
    }
    // Shown labels never overlap within a row, and no second-row tick
    // crosses a first-row label; a hidden label inside the plot fits on
    // neither row beside the labels shown.
    const cols = x.map((_, k) => {
      const label = w.document.querySelector(`.size-label[data-plot="${p}"][data-size="${k}"]`);
      return { half: (label.textContent.length * 7.2 + 12) / 2, shown: +label.getAttribute("opacity") > 0,
               row: Math.round((+label.getAttribute("y") - plot.bottom - 24) / 13) };
    });
    const overlaps = (k, row) => cols.some((c, j) => j !== k && c.shown && c.row === row && Math.abs(x[j] - x[k]) < c.half + cols[k].half - 0.01);
    const coversTick = k => cols.some((c, j) => j !== k && c.shown && c.row === 1 && Math.abs(x[j] - x[k]) < cols[k].half - 0.01);
    const tickCrosses = k => cols.some((c, j) => j !== k && c.shown && c.row === 0 && Math.abs(x[j] - x[k]) < c.half - 0.01);
    for (let k = 0; k < x.length; k++) {
      const c = cols[k];
      if (c.shown) {
        check(!overlaps(k, c.row), `${tag}: plot ${p} label ${k} overlaps row ${c.row}`);
        check(c.row === 0 ? !coversTick(k) : !tickCrosses(k), `${tag}: plot ${p} label ${k} meets a tick`);
      } else if (x[k] >= D.plotLeft && x[k] <= D.plotRight) {
        check((overlaps(k, 0) || coversTick(k)) && (overlaps(k, 1) || tickCrosses(k)), `${tag}: plot ${p} label ${k} hidden though a row has room`);
      }
    }
    plot.series.forEach((s, i) => {
      if (!s || !w.__on[i]) return;
      const labels = [...w.document.getElementById(`series-${p}-${i}`).querySelectorAll(".value-label")];
      check(labels.length === x.length, `${tag}: plot ${p} series ${i} has ${labels.length} value labels`);
      const shown = labels.filter(t => t.getAttribute("display") !== "none").map(t => +t.getAttribute("data-size")).sort((a, b) => a - b);
      check(shown.every(k => k >= wd.k0 && k <= wd.k1), `${tag}: plot ${p} series ${i} labels at ${shown}`);
      const detail = w.document.getElementById(`series-${p}-${i}`).querySelector(".series-detail").textContent;
      check(detail.endsWith("at " + plot.sizes[wd.k1]), `${tag}: plot ${p} series ${i} detail "${detail}"`);
    });
  });
  noNaN(tag);
}

(async () => {
  // The static render hid the same labels the script hides.
  {
    const staticDom = new JSDOM(`<!DOCTYPE html><html><body>${markup}</body></html>`);
    D.plots.forEach((plot, p) => plot.x.forEach((_, k) => {
      const sel = `.size-label[data-plot="${p}"][data-size="${k}"]`;
      const before = staticDom.window.document.querySelector(sel).getAttribute("opacity") === "0";
      const after = +w.document.querySelector(sel).getAttribute("opacity") === 0;
      check(before === after, `static and script disagree on label ${p}/${k}`);
    }));
  }
  // Initial layout matches the static render's x positions.
  D.plots.forEach((plot, p) => plot.x.forEach((x, k) => check(Math.abs(T.currentX[p][k] - x) < 0.02, `initial x plot ${p} point ${k}: ${T.currentX[p][k]} vs ${x}`)));
  checkLayout("initial");
  // The range shown, as the band covers it (no numbers in the controls).
  const range = () => `${T.ALLB[T.zFrom]} to ${T.ALLB[T.zTo]} bytes`;
  const tx = id => +((w.document.getElementById(id).getAttribute("transform") || "").match(/translate\(([-\d.]+)/) || [0, 0])[1];
  const buttons = ["zoom-all"];
  const buttonsAt = buttons.map(tx);
  const lg = v => Math.log2(v), a = lg(T.ALLB[0]), b = lg(T.ALLB[T.ALLB.length - 1]);
  const stripX = v => D.stripLeft + (lg(v) - a) / (b - a) * (D.stripRight - D.stripLeft);
  function checkControls(tag) {
    const offs = buttons.map(id => w.document.getElementById(id).getAttribute("data-off") === "true");
    const last = T.ALLB.length - 1;
    const want = [T.zFrom === 0 && T.zTo === last];
    check(offs.every((o, i) => o === want[i]), `${tag}: exactly the buttons that can act show (${offs})`);
    check(buttons.every((id, i) => Math.abs(tx(id) - buttonsAt[i]) < 0.01), `${tag}: the zoom buttons never move`);
    const band = w.document.getElementById("zoom-band"), x0 = +band.getAttribute("x") + 3, x1 = x0 + +band.getAttribute("width") - 6;
    check(Math.abs(x0 - stripX(T.ALLB[T.zFrom])) < 0.1 && Math.abs(x1 - stripX(T.ALLB[T.zTo])) < 0.1, `${tag}: the band covers ${range()}`);
    check(Math.abs(stripX(T.ALLB[0]) - L) < 0.1 && Math.abs(stripX(T.ALLB[T.ALLB.length - 1]) - R) < 0.1, `${tag}: the strip spans the plots' inputs`);
  }
  checkControls("initial");
  // Hiding plots never makes the page shorter than it loaded (mobile
  // WebKit zooms a page whose content shrinks), and showing them again
  // restores it.
  {
    const svgEl = w.document.querySelector("svg");
    const loaded = +svgEl.getAttribute("height");
    const shared = D.plots.map((p, i) => p.scenario === "shared" ? i : -1).filter(i => i >= 0);
    shared.forEach(p => w.togglePlot(p));
    check(+svgEl.getAttribute("height") >= loaded, "hiding the shared plots keeps the page's height");
    check(+w.document.getElementById("page").getAttribute("height") === +svgEl.getAttribute("height"), "the page background spans the page");
    shared.forEach(p => w.togglePlot(p));
    check(+svgEl.getAttribute("height") === loaded, "showing them again restores the height");
  }
  {
    const staticDom = new JSDOM(`<!DOCTYPE html><html><body>${markup}</body></html>`);
    check(buttons.every(id => staticDom.window.document.getElementById(id).getAttribute("data-off") === w.document.getElementById(id).getAttribute("data-off")),
      "the static render hides the same buttons as the script at the full range");
  }
  // The better arrows: the script draws what the static render drew, and flips with the unit.
  const arrows = () => D.plots.map((_, p) => w.document.getElementById(`y-better-${p}`).getAttribute("d"));
  const staticArrows = arrows();
  D.plots.forEach((_, p) => w.betterArrow(p, w.document.getElementById(`y-title-${p}`).textContent, true));
  check(arrows().every((d, p) => d === staticArrows[p]), "the script's better arrows match the static render's");
  const headY = d => +d.match(/M[\d.]+ ([\d.]+) L[\d.]+ ([\d.]+)/).slice(1)[1];
  const tailY = d => +d.match(/M[\d.]+ ([\d.]+)/)[1];
  check(arrows().every(d => headY(d) < tailY(d)), "in rate the better arrows point up");
  console.log("ALLB", T.ALLB.length, "values;", range());
  // Step the lower end up five points.
  for (let i = 0; i < 5; i++) w.zoomStep("from", 1);
  await sleep(700);
  checkLayout("from+5"); checkControls("from+5");
  console.log("after from+5:", range(), "windows", T.win().map(x => `${x.k0}-${x.k1}`).join(" "));
  // Zoom to 2 KiB .. 4 KiB exactly by steps.
  w.zoomAll(); await sleep(700);
  while (T.ALLB[T.zFrom] < 2048) w.zoomStep("from", 1);
  while (T.ALLB[T.zTo] > 4096) w.zoomStep("to", -1);
  await sleep(700);
  checkLayout("2-4 KiB"); checkControls("2-4 KiB");
  console.log("2-4 KiB:", range(), "windows", T.win().map(x => `${x.k0}-${x.k1}`).join(" "),
    "sizes", D.plots.map((pl, p) => pl.sizes.slice(T.win()[p].k0, T.win()[p].k1 + 1).join(",")).join(" | "));
  // Step both ends, switching the unit mid-transition.
  w.zoomAll(); await sleep(700);
  w.zoomStep("from", 3); w.zoomStep("to", -3); await sleep(100); w.flipUnit(); await sleep(900);
  checkLayout("steps + unit"); checkControls("steps + unit");
  check(arrows().every(d => headY(d) > tailY(d)), "in time the better arrows point down");
  console.log("steps + unit:", range());
  // Drag each grip and the band: an end follows the pointer's travel to the nearest input, never past the other end.
  w.zoomAll(); await sleep(700);
  const pev = x => ({ clientX: x, pointerId: 1, stopPropagation() {}, preventDefault() {} });
  w.gripDown(pev(stripX(T.ALLB[0])), "from"); w.gripMove(pev(stripX(T.ALLB[4]) + 1));
  check(w.document.getElementById("zoom-tick-4").getAttribute("data-at") === "true", "while dragging, the tick under the end lights up");
  w.gripUp();
  check(T.zFrom === 4, `dragging the start grip to input 4 moved the start to ${T.zFrom}`);
  check(w.document.getElementById("zoom-tick-4").getAttribute("data-at") === "false", "after the drag, the ticks go quiet");
  w.gripDown(pev(stripX(T.ALLB[T.zTo])), "to"); w.gripMove(pev(stripX(T.ALLB[2]))); w.gripUp();
  check(T.zTo === 5, `dragging the end grip past the start stops one input after it (${T.zTo})`);
  w.gripMove(pev(stripX(T.ALLB[T.ALLB.length - 1])));
  check(T.zTo === 5, "a pointer moving after release moves nothing");
  T.setZoom(3, 9); await sleep(700);
  w.gripDown(pev(stripX(T.ALLB[3]) + 5), "both"); w.gripMove(pev(stripX(T.ALLB[5]) + 5)); w.gripUp();
  check(T.zFrom === 5 && T.zTo === 11, `dragging the band moves both ends by two inputs (${T.zFrom}-${T.zTo})`);
  w.gripDown(pev(stripX(T.ALLB[T.zFrom])), "both"); w.gripMove(pev(stripX(T.ALLB[0]) - 500)); w.gripUp();
  check(T.zFrom === 0 && T.zTo === 6, `the band stops at the strip's start (${T.zFrom}-${T.zTo})`);
  // A slow drag moves at a third of the pointer's travel.
  T.setZoom(0, T.ALLB.length - 1); await sleep(700);
  const now0 = w.performance.now;
  let clock = 0; w.performance.now = () => clock;
  w.gripDown(pev(stripX(T.ALLB[0])), "from");
  const target = stripX(T.ALLB[6]) - stripX(T.ALLB[0]);
  for (let moved = 0; moved < target; moved += 2) { clock += 20; w.gripMove(pev(stripX(T.ALLB[0]) + moved + 2)); }
  w.gripUp(); w.performance.now = now0;
  check(T.zFrom < 6 && T.zFrom >= 1, `a slow drag of six inputs' distance moves the start less far (${T.zFrom})`);
  await sleep(300); checkLayout("dragged"); checkControls("dragged");
  const grip = +((w.document.getElementById("zoom-grip-from").getAttribute("transform") || "").match(/translate\(([-\d.]+)/) || [0, 0])[1];
  check(Math.abs(grip - stripX(T.ALLB[T.zFrom])) < 0.1, "the start grip sits at the band's start");
  // One checkbox per measured plot: each acts independently, even from
  // an empty selection. Every plotted scenario can be explored alone.
  w.zoomAll(); await sleep(700);
  {
    const pitch = D.plots.length > 1 ? D.plots[1].top - D.plots[0].top : 0;
    const off = p => w.document.getElementById("plot-" + p).classList.contains("plot-off");
    const choice = p => w.document.getElementById("plot-choice-" + p);
    const ranks = tag => {
      let shown = 0;
      D.plots.forEach((_, p) => {
        check(choice(p).getAttribute("aria-checked") === String(!off(p)), `${tag}: checkbox ${p} matches its plot`);
        if (!off(p)) { check(T.plotShift[p] === (shown - p) * pitch, `${tag}: plot ${p} closes ranks`); shown++; }
      });
      check(T.belowShift === (Math.max(1, shown) - D.plots.length) * pitch, `${tag}: what lies below follows`);
      check(w.document.getElementById("empty-plots").getAttribute("display") === (shown ? "none" : "inline"), `${tag}: empty selection has an invitation`);
      check(w.document.getElementById("plot-picker-count").textContent === `${shown} of ${D.plots.length} shown`, `${tag}: count comes from the actual selection`);
    };
    check(w.document.querySelectorAll(".plot-choice").length === D.plots.length, "exactly one checkbox per measured plot");
    check(w.document.querySelectorAll(".chip, [aria-disabled], [data-live]").length === 0, "no dependent or disabled filters remain");
    w.togglePlotPicker(true);
    w.document.getElementById("plot-picker-clear").dispatchEvent(new w.MouseEvent("click", {bubbles:true}));
    ranks("clear");
    D.plots.forEach((_, p) => {
      choice(p).dispatchEvent(new w.MouseEvent("click", {bubbles:true}));
      check(D.plots.every((_, i) => off(i) === (i !== p)), `checkbox ${p} alone shows exactly its plot`);
      ranks(`only ${p}`);
      choice(p).dispatchEvent(new w.KeyboardEvent("keydown", {key:" ",bubbles:true,cancelable:true}));
      ranks(`keyboard off ${p}`);
    });
    // The formerly impossible diagonal: owned+solo beside lent+shared,
    // without also selecting either of the other cross combinations.
    const selected = D.plots.map((p, i) => p.what === "messages" && p.pattern === "nonstop" && ((p.buffers === "owned" && p.scenario === "solo") || (p.buffers === "lent" && p.scenario === "shared")) ? i : -1).filter(i => i >= 0);
    selected.forEach(p => w.togglePlot(p));
    check(D.plots.every((_, i) => off(i) === !selected.includes(i)), "nonstop messages show exactly the chosen combinations, with both gap types off");
    ranks("independent combinations");
    w.document.getElementById("plot-picker-all").dispatchEvent(new w.KeyboardEvent("keydown", {key:"Enter",bubbles:true,cancelable:true}));
    check(D.plots.every((_, p) => !off(p) && T.plotShift[p] === 0) && T.belowShift === 0, "Show all restores every plot");
    w.document.getElementById("plot-picker-done").dispatchEvent(new w.MouseEvent("click", {bubbles:true}));
    check(w.document.getElementById("plot-picker-panel").getAttribute("display") === "none", "Done closes the picker");
    w.togglePlotPicker(true);
    w.document.getElementById("plot-picker-panel").dispatchEvent(new w.KeyboardEvent("keydown", {key:"Escape",bubbles:true}));
    check(w.document.getElementById("plot-picker-button").getAttribute("aria-expanded") === "false", "Escape closes the picker");
    noNaN("plot picker");
  }
  // Hover every point of every plot  // Hover every point of every plot: the panel holds its widest line.
  w.zoomAll(); await sleep(700);
  const ev0 = { pointerType: "mouse", stopPropagation() {} };
  let widest = 0;
  D.plots.forEach((plot, p) => plot.series.forEach((s, i) => { if (!s) return; plot.x.forEach((_, k) => {
    w.hoverDot(ev0, p, i, k);
    const box = w.document.getElementById("hover-box"), W = +box.getAttribute("width");
    widest = Math.max(widest, W);
    const bx = +box.getAttribute("x");
    [...w.document.getElementById("hover-body").querySelectorAll("text")].forEach(t => {
      const x = +t.getAttribute("x"), n = t.textContent.length, cls = t.getAttribute("class").split(" ")[0];
      const cw = { "hover-head": 7.2, "hover-row": 6.4, "hover-ratio": 6.8, "hover-sub": 5.8, "hover-note": 5.0 }[cls] || 6.4;
      const anchor = t.getAttribute("text-anchor");
      const [lo, hi] = anchor === "end" ? [x - n * cw, x] : [x, x + n * cw];
      check(lo >= -0.5 && hi <= W + 0.5 || W >= 640, `hover ${p}/${i}/${k}: "${t.textContent}" spans ${lo.toFixed(0)}-${hi.toFixed(0)} in a ${W}-wide panel`);
    });
  }); }));
  console.log("widest hover panel", widest);
  noNaN("hover all");
  // Beyond the batch axis: the batch plots keep their two nearest points.
  w.zoomAll(); await sleep(700);
  while (T.zTo - T.zFrom > 1) w.zoomStep("from", 1);
  await sleep(700); checkLayout("last two"); checkControls("last two");
  console.log("last two:", range(), "windows", T.win().map(x => `${x.k0}-${x.k1}`).join(" "));
  // Toggle a series, hover a visible dot and a hidden one.
  w.toggleSeries(0); await sleep(50); checkLayout("toggle");
  const ev = { pointerType: "mouse", stopPropagation() {} };
  const wd = T.win()[0];
  const vis = D.names.findIndex((_, i) => w.__on[i] && D.plots[0].series[i]);
  w.hoverDot(ev, 0, vis, wd.k1);
  check(w.document.getElementById("hover").style.display === "", "hover on a shown point shows the panel");
  w.hoverDot(ev, 0, vis, 0);
  check(wd.k0 === 0 || w.document.getElementById("hover").style.display === "none", "hover on a point outside the window hides the panel");
  w.zoomAll(); await sleep(700); checkLayout("all again");
  w.toggleSeries(0); await sleep(50); checkLayout("shown again");
  console.log(failures ? `${failures} failures` : "all checks pass");
  process.exit(failures ? 1 : 0);
})();
