# Checking the map's script

`map.js` drives a generated `bench-hashes.map.html` in Chromium: every chart
opens in place and closes, with its headers lit and the values under the
pointer; a header greys its charts; every call name links to its
documentation; a link to one chart opens it.

    npm install playwright
    node tools/graph-check/map.js benchmark-results/<machine>/bench-hashes.map.html /usr/bin/chromium

`overview.js` drives the overview (`index.html`): no script error, and in
every cell of the grid the fastest bar shown fills the width, as the page
opens and after each legend button turns its contender off and back on.

    node tools/graph-check/overview.js index.html /usr/bin/chromium
