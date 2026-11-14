The phone checks reproduce overlapping headings, covered documentation links and clipped tick labels at 320/420 pixels. The prototype uses one flowing heading, measured label widths and viewport bounds. Short panels scroll with the close button reachable. Opening/closing animation and transient-size assumptions leave the design.

The initial viewport matrix passes. Broader checks exposed a sticky legend covering a desktop close button and mobile `innerHeight` exceeding the visible viewport; the candidate now uses one panel stacking order and client dimensions.

I’m validating the fifteen maps that share these presentation blocks. Their data payloads remain byte-identical. Five older comparison renderers retain their existing layouts and the already-published tap repair. Horizontal positions remain ordered test inputs; the log-scale label now names the vertical scale explicitly.

Next move remains mine: finish full checks, review renders and publish the scoped correction.

— Devon Jonte
