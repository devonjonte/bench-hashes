# Changes

## 0.19.4+222a04421d109ca50f0498f2b4bd7afcc9b096d6

These are the changes since 0.18.3, which drew the published results for BLAKE3-Servil 0.8. The two versions measure "one input after another" differently, so compare results only with others from the same version.

**"One input after another" now means sustained hashing.** This covers streams, batches, Merkle trees and collections. 0.18 took each of these samples as 1 ms of hashing right after other functions' samples, so it caught the computer in whatever state they left it. 0.19 hashes for 100 ms first, then takes six samples back to back, which is what a program that keeps hashing gets.
- Most cells read within a few percent of 0.18.
- Some multithreaded and two-program cells read faster. On an Apple M4 Max, official BLAKE3's multithreaded streams read 21–27% faster.
- A few read slower. On the M4 Max, BLAKE3-Servil's multithreaded streams of 128 B to 64 KiB read up to 41% slower, because sustained load lowers its clock and slows its threads.
- The typical cell repeats more closely from run to run. On the M4 Max, the median spread fell from 1.5% to 1.1%.

**Calls after a pause or after other work are measured as before.** On the M4 Max they read about 1% slower (SHA-256 about 4%), because the longer sustained part of the run warms the chip first.

**"Buffers owned" and "buffers lent" are one measurement where the calls are the same.** That's every function except BLAKE3-Servil's multithreaded stream, for messages up to 64 KiB and for batches. Those two rows now read the same.

**The busy-computer warning sees more.** Programs that spend their time in the operating system, such as file copies, now count as well. The warning works on macOS again, and on Linux it names the busiest programs.

**A full run takes about 6 minutes on an M4 Max,** where it took 4. Your next run on the same computer, with the same options and power mode, starts measuring about a minute sooner. Before measuring, a run calibrates how much work each sample does, and 0.19 caches those settings. A later run reuses them only when nothing they depend on has changed, and calibrates afresh if its samples come out far from their intended length.

**The BLAKE3-Servil measured by default is 0.8.0 as released.** 0.18.3 measured a commit shortly before the release.

**The overview's bars:** in each cell, the fastest bar shown fills the cell, and its speed is the one written under the cell's end.
