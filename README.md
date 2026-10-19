# bench-hashes reference data

Measurements worth keeping: runs we expect to cite or compare against
later. They are expensive to repeat, and a later run is judged beside
them. Each folder is one question, with its own README covering what it
answers, the commits on each side, the command, the verdict, and where
the verdict was posted. The samples are the tools' own files (`samples
vN` headers), read with the tools of the commit that wrote them; the logs
are each command's own output.

This branch holds data alone, so a checkout of `main` stays the tool.
Fetch a file directly:

    https://raw.githubusercontent.com/devonjonte/bench-hashes/data/2026-10-19/release-oct19/README.md

Machine, unless a folder says otherwise: Intel i7-12700K (8 P cores with
SMT, 4 E cores), Linux 7.0, ext4 on a WD SN570 NVMe, measured quiet.
