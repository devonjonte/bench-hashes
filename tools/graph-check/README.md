# Checking the graph's script

`check.js` runs the script of a generated `bench-hashes.graph.svg` in jsdom
and drives it: zoom steps, zoom in and out, "all", a unit switch during a
zoom, series toggles, hover. It checks that each plot's window ends on the
plot's inner edges, that labels, value labels, and right-hand details
follow the window, that points outside it are out of view, and that no
attribute holds NaN. `snapshot.js` zooms to a byte range and writes the
resulting SVG, for `rsvg-convert` to render and a person to look at.

    npm install jsdom@22
    node tools/graph-check/check.js benchmark-results/<machine>/bench-hashes.graph.svg
    node tools/graph-check/snapshot.js GRAPH.svg /tmp/zoomed.svg 2048 8192
    rsvg-convert -w 1300 /tmp/zoomed.svg -o /tmp/zoomed.png
    node tools/graph-check/views.js GRAPH.svg /tmp/hover.svg /tmp/paths.svg

`views.js` writes two states to look at: 2-8 KiB with a hover panel open,
and the Code paths section open.

In the VM: `apt-get install -y nodejs npm` first (lost on restart).

## Checking the API guide

`guide.js` uses Playwright and a real browser to check the generated
`bench-hashes.guide.html`: 48 decision-table combinations, 21 clicked
endings, every uncertain-answer default, Back and restart, and the actual
visible plots and contenders in the embedded graph. Install Playwright
1.55.1 (works with Node 18 or later) and Chromium, then:

    npm install playwright@1.55.1
    node tools/graph-check/guide.js GUIDE.html /usr/bin/chromium

With Playwright's own Chromium installed, omit the last argument. The
guide's Rust test also checks escaping so embedded graph data stays
inside its script string.
