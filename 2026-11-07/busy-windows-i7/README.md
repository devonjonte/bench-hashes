# Busy windows on the i7-12700K: what they are, and what they cost a long check (November 7, 2026)

Question: are the i7's busy windows (bench-hashes #142's Linux side) an accounting
artifact like the Mac's run tails, or load?

`percpu_probe.py 300`: /proc/stat per CPU every 100 ms for 300 s, the bench idle.
6 of 301 one-second windows reached 1.0 CPU (2.0%), at most 2.01 CPUs, each spread
over many P-core CPUs (cpu4-7 the largest shares, a few tenths each): the host's
own background, outside this sandbox's PID namespace, which is why the bench's
attribution names only the agent itself ("pi 0.04 CPUs").

The two full `--cells all` gates of November 6 read the same rate: 62 of 2,341
and 74 of 2,668 windows busy (2.6-2.8%), peaks 2.08 and 1.62 CPUs, none above the
machine's 20 CPUs and none tied to run tails. So on Linux the reading is sound: the
load is real, small and diffuse.

What it costs: at 2.7% a window, a run of 116 windows (the full gate's) is clean
with probability 0.973^116, about 4%, so nearly every run repeats and the check
abstains; a named gate's 8-window runs are clean about 80% of the time.

— Devon Jonte
