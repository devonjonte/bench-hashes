# EPYC 9275F: the pool's cache-topology change on the Pipeline cells

November 15, 2026. [Pipeline caller costs](https://github.com/servil-software-factory/BLAKE3/issues/389);
John's change `3ec37f0e9d72ace57a3e094abbb5759c3f91395f` against its parent
`6e498a963c5a8a2a7ddb01a86727317e277c32ec`, bench `5c0efb96b05f` on both sides.

One gate check (`check --points`, four fresh-layout pairs, the adaptive second
stage unused: the first stage found no slower cell), blake3-servil-mt, the 19
Pipeline/pool points of the earlier pilot, under the host lock on the quiet
EPYC 9275F (three last-level caches).

**No cell slower; 37 cells faster.** Solo: continuous batches −63 to −74%,
continuous messages 64 B/64 KiB/1 MiB −67 to −73%, collections −54/−56%,
saturated receiving −70%, lent 1 MiB −53%. Shared one-cache −24 to −61%;
shared two-caches −10 to −41%. "No level cell's instructions moved beyond
+0.5%". Raw runs under `kept-topology/`; wall and process CPU are in the
samples; this host still counted no per-thread cycles during this run.

This is one machine's gate-scope verdict on the named cells, answering the
issue's request. The idle workers' 5 µs search while a Pipeline is open is
unchanged, as John said; CPU-time ownership of that stays open on the issue.
