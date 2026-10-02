#!/usr/bin/env python3
"""Refresh a graph's controls using this checkout; preserve its data/provenance.

Usage: pypy3 tools/refresh-graph-ui.py INPUT.svg OUTPUT.svg
Reads the SVG's embedded display data, never samples or speed statistics.
Writes a separate file; the original evidence stays unchanged.
"""
import argparse
import json
from pathlib import Path
import re

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('input', type=Path)
p.add_argument('output', type=Path)
a = p.parse_args()
assert a.input.resolve() != a.output.resolve(), 'choose a separate output file to preserve the original graph'
assert not a.output.exists(), 'choose a new output file; existing records stay unchanged'
svg = a.input.read_text()
pattern = r'<script><!\[CDATA\[([\s\S]*?)\]\]></script>'
script = re.search(pattern, svg)
assert script, 'expected a self-contained bench-hashes graph script'
start = re.search(r'const DATA =\s*', script[1])
assert start, 'expected the embedded DATA object'
data, end = json.JSONDecoder().raw_decode(script[1][start.end():])
assert data['plots'] and all(all(k in plot for k in ('what', 'pattern', 'buffers', 'scenario')) for plot in data['plots']), 'use the source-matched viewer for an older graph format'
literal = script[1][start.end():start.end() + end]
repo = Path(__file__).resolve().parents[1]
# Keep the original source-matched renderer: older graphs can have other
# path/axis representations. Replace only the controls being redesigned.
body = script[1]
controls = re.search(r'/\*\n \* The chips show and hide plots\.[\s\S]*?(?=/\* The door under the title opens)', body)
assert controls, 'expected the original dependent plot controls; use a new output from the original graph'
body = body[:controls.start()] + (repo / 'src/plot_selector.js').read_text() + '\n' + body[controls.end():]
assert 'window.toggleChip = toggleChip;' in body
body = body.replace('window.toggleChip = toggleChip;', 'window.togglePlot = togglePlot;\nwindow.setAllPlots = setAllPlots;\nwindow.togglePlotPicker = togglePlotPicker;\ninitPlotSelector();\nlayoutPlots();')
assert 'function tapAway() { pinned = null; hideHover(); }' in body
body = body.replace('function tapAway() { pinned = null; hideHover(); }', 'function tapAway() { pinned = null; hideHover(); if (document.getElementById("plot-picker-panel").getAttribute("display") !== "none") togglePlotPicker(false); }')
new_script = '<script><![CDATA[' + body + ']]></script>'
svg = svg[:script.start()] + new_script + svg[script.end():]
svg = re.sub(r'  <g class="chip"[^>]*>[\s\S]*?</g>\n', '', svg)
svg = re.sub(r'  <path class="chip-tie"[^>]*/>\n', '', svg)
svg = re.sub(r'^\s*\.chip[^\n]*\n', '', svg, flags=re.M)
# These blocks are evidence, not regenerated descriptions.
for block in ('metadata',):
    match = lambda text: re.search(r'(?m)^\s*<'+block+r'\b[^>]*>[\s\S]*?</'+block+r'>', text)[0]
    assert match(svg) == match(a.input.read_text())
assert literal in svg
svg = svg.replace('<svg ', '<!-- Viewer controls refreshed; embedded measurements and original provenance preserved. -->\n<svg ', 1)
a.output.parent.mkdir(parents=True, exist_ok=True)
a.output.write_text(svg)
print(a.output)
