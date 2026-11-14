# Wide-touch grid input: bounded diagnosis

November14,13:50UTC. Issue224. Fifteen-minute diagnostic budget; no code change
without a clear page-versus-fixture cause. Use unchanged published renderer
2059ff5e (the c7fcc90d tree), fixed M6 data and the same far-cell input.

Compare desktop mouse, wide touch without mobile emulation, wide mobile all-touch,
and the original mixed mouse-chip/touch-chart fixture. Record viewport/client/
visual dimensions, scroll and resize events, target rectangles and actual hit
elements. The event log is ordered, with no performance measurement.

If only the fixture's coordinate conversion is wrong, fix that caller and qualify
its scope. If page redraw resets a valid scroll position, repair the one existing
mechanism. Keep failures and controls. Stop after this matrix if inconclusive.
