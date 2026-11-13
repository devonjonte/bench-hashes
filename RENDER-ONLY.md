# Historical 0.21 renderer with load qualifications

This branch serves existing measurements. Build it to redraw their map and
overview; use current bench-hashes for new measurements.

Base bench: `9434d50e50de4b93dc962ccbf52346db5442358e`.
Library pin: `2037118ca1da85710aef55d7f13b3abd9095b485`.
The samples reader, clocks, contender calls, statistical arithmetic and manifests
are the base release's. Presentation-only backports add per-run load warnings,
keep the overview's current machine descriptions and legend behavior, and retain
the current page's default form selection.

The load-warning feature comes from `45f35601` on current bench-hashes. The
historical renderer passes 154 workspace tests (16 machine tests outside this
render-only scope). The two load controls hold busy/unobserved/quiet behavior
and unchanged arithmetic. For the M6 publication snapshot, its overview equals
the current presentation's generated page byte-for-byte; all 308 plotted bar
speeds agree. Its map differs from the pristine historical renderer only in
load wording. Raw sample/count/load records stay unchanged.

```sh
cargo build --release
./target/release/bench-hashes map RESULTS/AppleM6.darwin27
./target/release/bench-hashes overview index.html RESULTS
```

[Publication tracker](https://github.com/servil-software-factory/bench-hashes/issues/201).

— Devon Jonte
