**The overview** (Zooko, October 22, 2026; draft by Devon for his decision):
one page above the maps, built from every platform's published run, that
answers "how does it do on my kind of machine?" across one row and "how
does it do for my use, across machines?" down one column.

- **What a cell shows.** For one platform and one representative
  measurement, the ratio of a competitor's time per unit to BLAKE3
  servil's, from the two contenders' means in the same run (the summary
  rule, `clocks::summary`). Above 1 servil is faster; below 1 slower. Both
  directions are drawn alike. Two competitors on the page (four in the files column): BLAKE3 official
  (the `blake3` crate; its `-mt` form, update_rayon, where servil's cell is
  multithreaded) and the fastest SHA-256 the run measured (sha2, ring, or
  the OS's). Every other contender stays on the map.
- **The representative measurements**, chosen once, here. The overview
  reads these cells and no others. Each is one user's situation; the
  sizes and states we measure to see a curve's shape, to hunt
  regressions (partial chunks, after idling) or to answer a narrower
  question stay on the map, one click away from the dot that summarises
  them.

  | column | scenario, use case, point | servil's contender | the situation |
  |---|---|---|---|
  | small values | solo OneMessage 64 B; solo OneMessage 1 KiB | blake3-servil-st | a key, an identifier, a small record, hashed between a program's other work |
  | one message, one thread | solo OneMessage 1 MiB | blake3-servil-st | a buffer the size of a file, on the calling thread |
  | one big message, every core | solo OneMessage 128 MiB | blake3-servil-mt (against blake3-official-mt) | a download or a disk image, the library's threads at work |
  | nonstop, from one calling thread | solo ContinuousMessages 64 KiB | blake3-servil-mt (the stream) | messages arriving one after another, as fast as the program can feed them |
  | many small messages at once | solo ManyMessages 1024 | blake3-servil-st | a Merkle layer, a content-addressed store, a database's keys |
  | files | b3sum, warm, mixed tree, 1000 files, 74 MiB (a directory of files of assorted sizes, as `b3sum -r` meets them; one file at a time is a narrower case, on the map) | the fork's b3sum (against official b3sum and the system's sha256sum, sha1sum and md5sum: still what many people run on a download, as integrity checks, whatever their security) | the command people actually run, process start to exit |

  Seven dots. **The budget is six columns and eight dots.** Adding one
  names the one it displaces, or argues the rare exception, here.
- **Nonstop's baseline is narrow today.** In ContinuousMessages BLAKE3
  official hashes on the one calling thread, while servil's stream uses
  the machine; the ratio compares what one calling thread gets from each
  library, which is the stream's promise, and is labelled so. A pool of
  official callers (N threads, each hashing messages back to back) is the
  machine-throughput baseline, and the benchmark does not measure it.
  Adding it is a change to this contract (a contender, Zooko's decision);
  with it, the column becomes "nonstop, the whole machine", the fairer
  question.
- **Rows are platforms**, one published run each, the newest run of the
  current benchmark release on that machine: its CPU name, core count
  and OS from the run's own header, its date, and the fork commit it
  measured. A run of an older benchmark release or an older fork than
  the one the page announces is drawn grey and says so; a virtual
  machine's row is kept (it is data) but off by default and labelled VM.
  Platform rows are highlighted, not filtered: the page guesses the
  reader's kind of machine from the browser (Apple silicon; x86) and
  marks that row "yours?", which the reader can move.
- **One sentence above the grid, computed from it:** the number of
  machines, and servil's range against each competitor over the
  representative cells, including any cell where servil is slower. No
  number on the page is typed by hand.
- **One pipeline, no copies.** The overview reads the same
  `bench-hashes.samples.tsv` and `b3sum.samples.tsv` files the maps are
  drawn from, through the same Rust reader and the same summary rule, and
  is built in CI from the published runs; it refuses runs of mixed
  benchmark releases rather than averaging them. Each dot links to its
  map cell. The map keeps every cell it has; it becomes the second page.
- **What the page cannot say.** A ratio from one run on one machine is
  that run's figure; it carries the run's load reading and the same
  qualification line the map shows, and no verdict (slower/faster is the
  regression check's word, from pairs of runs). Where the fork's own
  measurement rule is under review (the trim), the overview inherits
  whatever the release's rule is, named in its footer.
