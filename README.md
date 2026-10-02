# bench-hashes

Original benchmark written by GPT-5.6 Sol, Claude Fable 5, and Claude Opus 5.5 to Zooko's specifications.

**Devon's Linux research version.** This branch adds measurements for batches
of messages longer than 64 bytes. Results guide provisional optimization on
the tested Linux host; the [full reliability acceptance procedure](https://github.com/devonjonte/bench-hashes/blob/c05a253/audit/reliability-assessment.md)
remains incomplete. Historical upstream Mac results below describe their own
versions, not validation of this extension.

## Batches of longer messages

Run `cargo run --release -- batches` for equal-length messages of 64, 128,
256, 512, 1024, 2048 and 4096 bytes. The benchmark measures lent synchronous
calls and owned queues, alone and with two copies hashing concurrently.
`batches --help` lists the options. For example:

```sh
cargo run --release -- batches --lengths 256,2048 --counts 3,6,16,129 --rounds 24
```

The standalone build measures the upstream hashing commit in `Cargo.lock`.
To measure Devon's Linux hashing changes, clone the two research branches
with the benchmark inside the BLAKE3 fork, then build through its tool:

```sh
git clone --branch candidate/devon-linux-excellence https://github.com/devonjonte/BLAKE3
git clone --branch candidate/devon-linux-excellence https://github.com/devonjonte/bench-hashes BLAKE3/bench-hashes
cd BLAKE3
pypy3 tools/perf_regress.py build
```

The tool prints the executable path. Run that executable from a scratch
directory, followed by `batches`; it names the actual hashing and benchmark
sources. Use `python3` where PyPy is unavailable.

Results go to `benchmark-results/batches/`: `bench-hashes.txt` gives each
speed's median and sample share in nanoseconds per message;
`bench-hashes.samples.tsv` preserves raw time and message counts; `clocks.csv`
records wall time and available per-thread cycle counts. Busy or unobserved
load makes comparisons descriptive only. The original 64-byte measurements
and graphs remain available through the normal command.

Compare corresponding runs with `bench-hashes compare OLD.tsv -- NEW.tsv`;
compare each version's repeats as well. A changed mix of speeds is a finding
alongside the medians. These results include the input producer and digest
handling. The official BLAKE3 contender uses its native batch kernel through
1024-byte messages and a loop of plain hash calls for longer ones.

## Is BLAKE3 faster than SHA-256?

It depends on your computer, on how long your messages are, and on how
your program calls the hash. bench-hashes measures them on your
computer, from 64-byte messages to 128 MiB and in batches of small
messages, called now and then or nonstop, and draws the answer as an
interactive graph you open in a web browser.

Results so far:

- [Apple M4 Max, macOS](https://johnservil.github.io/bench-hashes/benchmark-results/AppleM4Max.darwin25/bench-hashes.graph.svg)
- [A Linux VM on that Mac](https://johnservil.github.io/bench-hashes/benchmark-results/aarch64.linux618520virt/bench-hashes.graph.svg)

## Run it on your computer

You need [Rust](https://rustup.rs) and a C compiler: Xcode's command-line
tools on macOS (`xcode-select --install`), gcc or clang on Linux, or the
Visual Studio C++ build tools on Windows. Then:

```sh
git clone --branch candidate/devon-linux-excellence https://github.com/devonjonte/bench-hashes
cd bench-hashes
cargo run --release
```

To measure a released version, so that others can compare their results
with yours, check out its tag first: `git checkout` followed by a tag
from [Devon's repository](https://github.com/devonjonte/bench-hashes/tags).
Historical upstream releases have separate source identities.

The first build takes a minute or two; the run then measures for about
a minute and needs about 1 GB of free memory. The numbers come out most
accurate when nothing else busy runs on the computer meanwhile.

## Read your results

The run writes these files to `benchmark-results/`, in a folder named after
your CPU and operating system:

- `bench-hashes.graph.svg`: the graph. Open it in a web browser.
- `bench-hashes.result.txt`: the same numbers as text tables.
- `bench-hashes.guide.html`: for programmers who want to call BLAKE3
  from their own code (see "Which function to use", below).
- `bench-hashes.samples.tsv`: every single measurement, for your own
  analysis.
- `bench-hashes.checks.txt`: consistency checks, for people who
  maintain the benchmark or a hash.

**Choose plots** opens a table of the plots this run measured. Each checkbox
shows exactly one plot; you can combine any choices. **Clear** starts a fresh
selection, **Show all** restores every plot, and **Done** closes the table.
The empty selection invites you to choose a plot. The controls work with a
mouse, touch, or the keyboard (Space/Enter; Escape closes the table).

To give an existing graph these controls without measuring again, run
`pypy3 tools/refresh-graph-ui.py OLD.svg NEW.svg`. Choose a new output filename:
the tool preserves the original graph, its embedded display data, provenance
and source-matched plotting code. It changes only the plot controls.

The graph has a plot for each way a program hashes. A message in one
buffer, and a batch of 64-byte messages (a Merkle tree's nodes), each
called now and then: *after other work*, as a program hashes between its
other tasks, and *after idling*, as a server waits for its next request.
Messages, batches, and long messages in pieces, hashed *nonstop*, one
after another, by one program and by two at once. In every plot, higher
is faster. Hover over a dot, or tap it, to compare the hashes there; the
Choose plots button at the top right selects the plots, and "How to read this graph"
under the title explains the rest.

Under the title the graph also says when other programs were busy or the
computer ran on battery during the run. If it does, run again quieter
and plugged in: busy programs slow the results, and battery power changes
which cores run them.

The contenders:

- **BLAKE3 servil mt**: [a fork](https://github.com/johnservil/BLAKE3) of
  the official BLAKE3 Rust crate, faster on 64-bit Arm and above all on
  Apple M4-class chips (on other CPUs its kernels are the official
  crate's), with its own threads to spread large inputs over your CPU
  cores and a queue for inputs that come one after another.
- **BLAKE3 servil st**: the same on one thread.
- **SHA-256** (the `sha2` crate) and **SHA-256 ring** (the `ring`
  crate): SHA-256 with the CPU's SHA-256 instructions where it has them;
  two implementations, since each is fastest at some sizes on some
  computers.

## Which function to use

Programmers who want this speed in their own program open
`bench-hashes.guide.html`. It asks a few questions about how the program
receives its data (one thread or several; one message, pieces, or a
batch; whether the thread keeps up; whose buffer the data lands in) and
answers with one call from the servil crate, a complete Rust example, and
that call's measured speed on your computer beside SHA-256. Every
question has an "I'm not sure" answer that leads to a safe choice.

`cargo run --release -- --all` adds every other hash the benchmark knows
(the official BLAKE3 crate, SHA3-256, SHA-1DC, and on Apple
CommonCrypto's SHA-256) and takes longer; `--contenders` picks any set
by name, including the official crate on its thread pool
(`blake3-official-mt`), which runs only when named (`--list` shows the
names).

## Share your results

Your graph is one self-contained file. Post it and `bench-hashes.result.txt`
anywhere people can download them: an issue, a gist, a forum. Anyone who
opens the graph in a browser sees it just as you do.

Or publish them on the web from your own copy of this repository, as the
results above are:

1. On GitHub, fork `johnservil/bench-hashes`. If you cloned it before
   forking, point your clone at your fork:
   `git remote set-url origin https://github.com/YOU/bench-hashes`
2. Commit your results and push them:
   ```sh
   git add benchmark-results
   git commit -m "Results for my computer"
   git push
   ```
3. On GitHub, in your fork's Settings, under Pages, choose "Deploy from a
   branch", the branch `main`, and the folder `/ (root)`.

A minute later your graph is at
`https://YOU.github.io/bench-hashes/benchmark-results/FOLDER/bench-hashes.graph.svg`,
where FOLDER is the folder the run created.

We would be glad to add your results to ours: once they are pushed to
your fork, open a pull request to `johnservil/bench-hashes` on GitHub.
Say in it what computer you ran on. Results from a machine we already
have go beside ours rather than over them: rename your folder first,
for example
`git mv benchmark-results/AppleM4Max.darwin25 benchmark-results/AppleM4Max.darwin25.yourname`.

## More

`cargo run --release -- --help` lists the other options, such as more
BLAKE3 and SHA implementations. [METHODOLOGY.md](METHODOLOGY.md) explains
how bench-hashes measures, and what each contender runs. To race your own
hash against these, [CONTRIBUTING.md](CONTRIBUTING.md) says how to add
it.
