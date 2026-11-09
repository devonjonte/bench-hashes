# bench-hashes 0.21.0

**One copy of the timing code.** The code that reads every clock and load measurement is now part of bench-hashes itself, so a result's bench-hashes version names exactly what timed it. It measures as before: the code is the same.

**The wall clock is the raw hardware counter on Linux too.** Until now Linux runs read `CLOCK_MONOTONIC`, which the system's time daemon speeds up or slows down by up to 0.05% to track network time; a benchmark has no use for that, and the rate could be wrong or someone else's. Runs now read `CLOCK_MONOTONIC_RAW`, the counter itself, as Mac runs always did. Each result names its clock.

**A call after a pause is measured after two pauses, 20 µs and 5 ms.** Until now each such call came after 1 ms of sleep, which on some computers is the moment the core is halfway into its deep sleep: half the calls met a rested core and half a drowsy one, and the cell's figure wobbled by a third between runs. After 20 µs every core is still awake; after 5 ms every core measured has settled into its deepest rest. Each is a real program's situation, and each is steady. The map shows both as columns. Where the bench runs as root on Linux it measures the 5 ms pause once more with the core's deep rest switched off, a third column: the library's own cost after a pause, apart from the machine's.

**The check's second look is pointed by instructions.** When the first pairs find no cell slower, the cells that run again on fresh layouts are chosen first by a count the machine's clock cannot move: a cell whose instructions retired per unit moved by more than 0.5% joins them ahead of the wall-time suspects. Wall time still decides. A machine that counts no instructions chooses by wall alone, and says so.

**Every sample keeps its instructions and its cache misses beside its cycles.** The processor counts the instructions a call retired, the cycles it took, and the memory requests that reached its last-level cache and missed it, on each kind of core; results kept the cycles and now keep all four (samples format v10). Instructions are the same count whatever the core's speed or its state after a pause, so they tell a change in the code apart from a change in the machine; the cache counts tell a cold cache apart from a slow core. The counters are read in user space where Linux allows it, so the reading costs the call tens of nanoseconds where a system call cost it a microsecond. Files from earlier versions are read with those versions.

**A message received in pieces, as a server receives it.** New cells hash one 16 MiB message whose bytes arrive in network-sized pieces (1,448 B to 64 KiB) at three paces: as fast as they come, and every 2 µs or 20 µs. Each piece is read into the program's buffer and hashed as it arrives, and the cell times the whole receive, waits included.

**BLAKE3-Servil's pipeline is a contender.** Its background pipeline (`throughput::pipeline`) takes part in the received-message cells and in the continuous batch cells. In the batch cells, batches go round the pipeline: refilled, submitted, handed back with their digests, used again.

**Many short messages in small arrivals.** A second "many messages at once" point holds 1,024 open messages of 1 KiB, each arriving in 256-byte pieces, the shape a server with many small requests meets. A call is one whole cycle: every message updated four times, then finished and reset.

**Merkle trees over short leaves.** Three trees whose leaves are 32 or 16 bytes, a digest or half a digest, beside the trees of 256-byte leaves; a million leaves in the largest.

**64-byte cells read as fast as the code allows.** The bench rewrote up to 63 bytes before every message in a kept buffer, by where the buffer sat in memory, so those cells' speed moved with the process's other allocations by up to 1.6%. It writes them once now.

**The provenance says when BLAKE3-Servil's version names another release.** A build of unreleased BLAKE3-Servil code keeps the last release's version string; the line beside it now says the version names that release's code, not this build's.

**Maintainers: `bench-hashes quiet` and the local runner.** `bench-hashes quiet [--wait]` applies the quiet-machine rule `check` and `regress` use before they start. `pinned-run` runs jobs on the local machine too, each under its deadline and memory floor, its processes supervised as a group.

## Earlier: 0.20.4+6c91cfabef89d1bd52c4d73b7d2578f449689502

**0.20.3 still stopped on a Mac, a step further; this release runs there, and a test now runs a Mac's case on every computer.** It measures as 0.20.3 does elsewhere.

## Earlier: 0.20.3+e1d7e91c397d7810d75aca9dc8ea84f86aa632d0

**0.20.2 stopped on a Mac at its first two-program cell; this release runs there.** It measures as 0.20.2 does elsewhere.

## Earlier: 0.20.2+5afd67ca61e26d9836b7184118d716ed0f57af2f

**On a Mac, "two programs at once" is measured again.** 0.20.0 and 0.20.1 placed the two copies on chosen cores, which macOS doesn't allow, and so measured no two-program cells at all on a Mac. Now, where the computer lets no program choose its cores, the copies run wherever the operating system puts them, as a row of its own. Results from other computers are unchanged.

## Earlier: 0.20.1+fb8e4df69d9dc80db735b6c8934beace93d50a8b

**Fixes; it measures as 0.20.0 does**, so results from either read alike. The Python study tools read 0.20's results files again. The map's two-programs rows show their two-figures mark again. A `crowd` run's results say that its programs are the load, where they said the run was too short to judge. The help lists every subcommand.

## Earlier: 0.20.0+62ce6faea92dd151cddb1b5a3b89059d1f22d8b1

**"Two programs at once" is measured for the multithreaded hashes alone.** Since September every nonstop cell was measured twice: alone, and as two copies of the program at once. For the single-threaded hashes the two always read the same, apart from where the operating system happened to put the two copies, so those 300 cells go. For the two multithreaded hashes the pair stays: it showed BLAKE3-Servil running faster beside a neighbour on a chip with several cache domains, which led to a fix, and two programs on one SME unit or one GPU are the same question. A full run on a one-cache computer is about a quarter shorter.

**The two copies are placed.** What two programs share decides what they cost each other, and until now the operating system chose it for every sample. Now the copies run on two cores under one cache, and, on computers with several caches, also under two, as a second row; on a two-socket computer each copy's input sits in its own socket's memory. Each sample records which CPU it ran on, and the copy that finishes first keeps working until the other has finished, so every sample is taken with its neighbour running.

**`bench-hashes crowd` is new:** many programs at once, one a CPU, each with its own thread pool, for the question whether a hash's pool degrades gracefully when twenty programs each start twenty threads. The samples files gain a `cpu` column (format v8); files from earlier versions are read with those versions.

**Every comparison names what it compares.** `bench-hashes compare` and `regress` print each side's builds: each one's bench-hashes and BLAKE3-Servil commits, and whether each tree was clean, a sigil standing for a changed tree. They say so when both sides are the same build. `build-against` puts each build in a folder named the same way, and `bench-hashes provenance` prints a build's name.

## Earlier: 0.19.7+d37df38c7c9e22f47e10d8e9adfc2e2359c8105f

**Two fixes to the map.** Each column now stays in its place through both halves of a map, so a reader scanning down a column finds the same way of calling in it. A run whose BLAKE3-Servil checkout was cloned from a local folder now writes its report and map, where it stopped after measuring.

## Earlier: 0.19.6+71c71159217a2a627fb06f270bb39890b76138f3

**Each result records the computer's idle states**: how deeply its cores can sleep, and how long each depth takes to wake from. On computers with deep sleep states, calls after a pause vary from run to run with the state the core slept in, so a reader can see why.

## Earlier: 0.19.5+8069a10c790b84158fdc9c1080ef77afb264b696

**Every result carries its whole record.** A map's "About this run" lists everything the run recorded: the exact commit of each program measured, each library's archive hash, the compiler, the CPU and its features, power and load. Each chart draws its record into the image, so a chart shared alone still says where it came from. On a phone, the overview keeps its row names in view as you scroll.

## Earlier: 0.19.4+222a04421d109ca50f0498f2b4bd7afcc9b096d6

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
