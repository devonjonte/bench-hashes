/* Each checkbox selects one measured plot. No dependent filters or
 * disabled choices: every subset, including the empty set, is reachable. */
const plotOn = DATA.plots.map(() => true);
const plotShift = DATA.plots.map(() => 0);
let belowShift = 0;

function selectorElement(tag, attributes, parent, text) {
  const element = document.createElementNS("http://www.w3.org/2000/svg", tag);
  for (const [key, value] of Object.entries(attributes)) element.setAttribute(key, value);
  if (text !== undefined) element.textContent = text;
  parent.appendChild(element);
  return element;
}
function selectorAction(element, action) {
  element.addEventListener("click", event => { event.stopPropagation(); action(); });
  element.addEventListener("keydown", event => {
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault(); event.stopPropagation(); action();
    }
  });
}
function togglePlot(p) { plotOn[p] = !plotOn[p]; layoutPlots(); }
function setAllPlots(show) { plotOn.fill(show); layoutPlots(); }
function togglePlotPicker(open) {
  const panel = document.getElementById("plot-picker-panel");
  const show = open === undefined ? panel.getAttribute("display") === "none" : open;
  panel.setAttribute("display", show ? "inline" : "none");
  document.getElementById("plot-picker-button").setAttribute("aria-expanded", String(show));
  if (show) {
    // Above plots and hover panels, without moving or covering the title.
    panel.parentNode.appendChild(panel);
    document.getElementById("plot-picker-done").focus();
  } else document.getElementById("plot-picker-button").focus();
}
function initPlotSelector() {
  const svg = document.querySelector("svg");
  selectorElement("style", {}, svg, `
    .plot-choice, .plot-action { cursor: pointer; }
    .plot-choice rect, .plot-action rect { fill: #fff; stroke: #b8b8b2; }
    .plot-choice text, .plot-action text { font-size: 12px; fill: #444; }
    .plot-choice[aria-checked="true"] rect { fill: #ede9fe; stroke: #8b5cf6; }
    .plot-choice[aria-checked="true"] text { fill: #4c1d95; }
    .plot-choice path { fill: none; stroke: #5b21b6; stroke-width: 2; }
    .plot-choice[aria-checked="false"] path { visibility: hidden; }
    .plot-choice:hover rect, .plot-action:hover rect { stroke: #5b21b6; stroke-width: 2; }
    .plot-choice:focus, .plot-action:focus { outline: none; }
    .plot-choice:focus rect, .plot-action:focus rect { stroke: #5b21b6; stroke-width: 3; }
    .picker-heading { font-size: 13px; font-weight: 600; fill: #333; }
    .picker-detail { font-size: 11px; fill: #666; }
    .picker-row { font-size: 13px; font-weight: 600; fill: #333; }
    .picker-missing { font-size: 12px; fill: #aaa; }
  `);
  const action = (id, parent, x, y, width, label, run) => {
    const group = selectorElement("g", { id, class: "plot-action", role: "button", tabindex: "0", "aria-label": label, transform: `translate(${x} ${y})` }, parent);
    selectorElement("rect", { width, height: 28, rx: 6 }, group);
    selectorElement("text", { x: width / 2, y: 19, "text-anchor": "middle" }, group, label);
    selectorAction(group, run);
    return group;
  };
  const button = action("plot-picker-button", document.getElementById("header"), DATA.plotRight + 14, 44, 254, "Choose plots", () => togglePlotPicker());
  button.setAttribute("aria-expanded", "false"); button.setAttribute("aria-controls", "plot-picker-panel");

  const columns = [
    { pattern: "idle", scenario: "solo", heading: "After idling", detail: "Alone" },
    { pattern: "busy", scenario: "solo", heading: "After other work", detail: "Alone" },
    { pattern: "nonstop", buffers: "owned", scenario: "solo", heading: "Hand over buffers", detail: "Alone" },
    { pattern: "nonstop", buffers: "owned", scenario: "shared", heading: "Hand over buffers", detail: "Two programs" },
    { pattern: "nonstop", buffers: "lent", scenario: "solo", heading: "Wait for each call", detail: "Alone" },
    { pattern: "nonstop", buffers: "lent", scenario: "shared", heading: "Wait for each call", detail: "Two programs" }
  ].filter(c => DATA.plots.some(p => p.pattern === c.pattern && p.scenario === c.scenario && (p.pattern !== "nonstop" || p.buffers === c.buffers)));
  const rows = [["messages", "Messages"], ["batches", "Batches"], ["pieces", "Pieces"]].filter(([key]) => DATA.plots.some(p => p.what === key));
  const left = DATA.plotLeft, top = 106, width = DATA.svgWidth - left - 30;
  const height = 138 + rows.length * 38;
  const panel = selectorElement("g", { id: "plot-picker-panel", display: "none", role: "group", "aria-label": "Choose the plots to show" }, svg);
  panel.addEventListener("click", event => event.stopPropagation());
  panel.addEventListener("keydown", event => {
    if (event.key === "Escape") { event.stopPropagation(); togglePlotPicker(false); }
  });
  selectorElement("rect", { x: left - 10, y: top, width: width + 20, height, rx: 8, fill: "#fff", stroke: "#b8b8b2" }, panel);
  selectorElement("text", { x: left + 8, y: top + 27, class: "picker-heading" }, panel, "Choose plots");
  selectorElement("text", { id: "plot-picker-count", x: left + 124, y: top + 27, class: "picker-detail", "aria-live": "polite" }, panel);
  action("plot-picker-all", panel, left + width - 278, top + 10, 84, "Show all", () => setAllPlots(true));
  action("plot-picker-clear", panel, left + width - 184, top + 10, 84, "Clear", () => setAllPlots(false));
  action("plot-picker-done", panel, left + width - 90, top + 10, 84, "Done", () => togglePlotPicker(false));
  const start = left + 120, step = (width - 120) / columns.length;
  columns.forEach((column, c) => {
    const center = start + (c + .5) * step;
    if (column.pattern !== "nonstop") selectorElement("text", { x: center, y: top + 75, class: "picker-heading", "text-anchor": "middle" }, panel, column.heading);
    selectorElement("text", { x: center, y: top + 93, class: "picker-detail", "text-anchor": "middle" }, panel, column.detail);
  });
  // Shared headings make the grouping visible without repeating labels.
  for (const [test, label, y, style] of [
    [c => c.pattern === "nonstop", "Nonstop", 57, "picker-detail"],
    [c => c.buffers === "owned", "Hand over buffers", 75, "picker-heading"],
    [c => c.buffers === "lent", "Wait for each call", 75, "picker-heading"]
  ]) {
    const indices = columns.map((c, i) => test(c) ? i : -1).filter(i => i >= 0);
    if (indices.length) selectorElement("text", { x: start + (indices[0] + indices[indices.length - 1] + 1) * step / 2, y: top + y, class: style, "text-anchor": "middle" }, panel, label);
  }
  rows.forEach(([what, name], r) => {
    const y = top + 107 + r * 38;
    selectorElement("text", { x: left + 8, y: y + 19, class: "picker-row" }, panel, name);
    columns.forEach((column, c) => {
      const x = start + c * step + 4, cellWidth = step - 8;
      const p = DATA.plots.findIndex(p => p.what === what && p.pattern === column.pattern && p.scenario === column.scenario && (p.pattern !== "nonstop" || p.buffers === column.buffers));
      if (p < 0) {
        const missing = selectorElement("text", { x: x + cellWidth / 2, y: y + 19, class: "picker-missing", "text-anchor": "middle" }, panel, "—");
        selectorElement("title", {}, missing, "This run has no plot for this combination.");
        return;
      }
      const label = `${name}, ${column.pattern === "nonstop" ? "nonstop, " : ""}${column.heading.toLowerCase()}, ${column.detail.toLowerCase()}`;
      const choice = selectorElement("g", { id: `plot-choice-${p}`, class: "plot-choice", "data-plot": p, role: "checkbox", tabindex: "0", "aria-label": label, "aria-checked": "true", transform: `translate(${x} ${y})` }, panel);
      selectorElement("title", {}, choice, label);
      selectorElement("rect", { width: cellWidth, height: 28, rx: 5 }, choice);
      selectorElement("path", { d: "M10 14 l4 4 l8 -9" }, choice);
      selectorElement("text", { x: cellWidth / 2 + 6, y: 19, "text-anchor": "middle" }, choice, "Shown");
      selectorAction(choice, () => togglePlot(p));
    });
  });
  selectorElement("text", { x: left + 8, y: top + height - 13, class: "picker-detail" }, panel, "Each checkbox shows one plot. Mix any choices.");
  const empty = selectorElement("g", { id: "empty-plots", display: "none" }, svg);
  selectorElement("text", { x: left, y: DATA.plots[0].top + 30, class: "plot-title" }, empty, "Choose a plot to explore");
  selectorElement("text", { x: left, y: DATA.plots[0].top + 54, class: "plot-sub" }, empty, "Open Choose plots and select any checkbox, or Show all.");
}
function layoutPlots() {
  const pitch = DATA.plots.length > 1 ? DATA.plots[1].top - DATA.plots[0].top : 0;
  let shown = 0;
  DATA.plots.forEach((plot, p) => {
    const group = document.getElementById("plot-" + p);
    group.classList.toggle("plot-off", !plotOn[p]);
    plotShift[p] = plotOn[p] ? (shown - p) * pitch : 0;
    group.setAttribute("transform", `translate(0 ${plotShift[p]})`);
    if (plotOn[p]) shown++;
    const choice = document.getElementById("plot-choice-" + p);
    choice.setAttribute("aria-checked", String(plotOn[p]));
    choice.querySelector("text").textContent = plotOn[p] ? "Shown" : "Show";
  });
  // Reserve the first plot's space for the empty-state invitation.
  belowShift = (Math.max(1, shown) - DATA.plots.length) * pitch;
  document.querySelectorAll(".below").forEach(g => g.setAttribute("transform", `translate(0 ${belowShift})`));
  document.getElementById("empty-plots").setAttribute("display", shown ? "none" : "inline");
  document.getElementById("plot-picker-button").querySelector("text").textContent = `Choose plots · ${shown} shown ▾`;
  document.getElementById("plot-picker-count").textContent = `${shown} of ${DATA.plots.length} shown`;
  if (hovered && !plotOn[hovered[0]]) hideHover();
  layoutProv();
}
