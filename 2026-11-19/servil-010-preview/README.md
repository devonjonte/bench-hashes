# BLAKE3-Servil 0.10.0: measured performance

> **Layout preview** using pre-release commit `2ef4c443` (final `0.10.0` numbers will replace these once the tag is cut).

**`b3sum` from BLAKE3-Servil 0.10.0 beats official `b3sum` 1.8.7 on every workload tested on Linux** (from **1.1×** to **26× faster** across six x86-64 machines), and wins **15 of 20** workloads on an Apple M6, with 1 slower (1 MiB in memory, 6% slower).

Compared with BLAKE3-Servil 0.9.0 on Linux, `b3sum` 0.10.0 hashes a cold 1 GiB file **16%–46% faster** and hashes 1,000 in-memory 16 KiB files **9%–27% faster**.

---

## `b3sum`: BLAKE3-Servil 0.10.0 vs. official `b3sum` 1.8.7

Whole-process wall time from start to exit across six x86-64 Linux machines and one Apple M6.
**In memory** hashes files already in the OS page cache; **from disk** evicts them first so they are read from storage.

| Workload | Linux in memory (6 hosts) | Linux from disk (6 hosts) | Apple M6 in memory | Apple M6 from disk |
|---|---:|---:|---:|---:|
| 1 small file (4 KiB) | **2.1×–4.3× faster** | **2.0×–4.1× faster** | same | same |
| 1 medium file (1 MiB) | **1.6×–3.9× faster** | **1.3×–2.3× faster** | 6% slower | **1.3× faster** |
| 1 large file (1 GiB) | **1.1×–2.8× faster** | **1.2×–1.9× faster** | **1.2× faster** | **2.0× faster** |
| 1,000 small files (16 KiB each) | **3.5×–7.6× faster** | **9.5×–26× faster** | **7.5× faster** | **5.9× faster** |
| Mixed directory (1,000 files, 74 MiB) | **2.6×–7.4× faster** | **6.8×–13× faster** | **4.8× faster** | **4.9× faster** |
| 16 large files (64 MiB each) | **1.1×–4.4× faster** | **1.3×–2.0× faster** | **1.2× faster** | **1.8× faster** |

*[Full 10-workload tables and per-machine wall times (`b3sum/`)](b3sum/)*

---

## `b3sum`: what changed from 0.9.0 to 0.10.0 (Linux, 6 machines)

| Workload | In memory | From disk |
|---|---|---|
| 1 small file (4 KiB) | same | same |
| 1 medium file (1 MiB) | 10%–28% faster (4 of 6) | 7% faster (1 of 6) |
| 1 large file (1 GiB) | same | **16%–46% faster** (all 6) |
| 1,000 small files (16 KiB each) | **9%–27% faster** (all 6) | 5%–44% faster (3 of 6) |
| Mixed directory (1,000 files, 74 MiB) | 7%–15% faster (4 of 6) | up to 29% faster (4 of 6); 12% slower on 2 |
| 16 large files (64 MiB each) | 14%–31% faster (5 of 6) | **13%–31% faster** (all 6) |

*[All 10 workloads, quick suite, and 0.8.0 comparison (`b3sum/`)](b3sum/)*

---

## The Rust & C library (`blake3-servil`)

Across 6 Linux machines (measured with one benchmark binary on both sides, 5% regression margin), BLAKE3-Servil 0.10.0 improved on **8–80 workloads per machine** relative to 0.9.0.

- **Known cost (> 5%):** 10 large multithreaded workloads were **7%–34% slower** across 3 machines (**2× EPYC 7443**, **EPYC 9255**, **EPYC 9275F**), while 3 machines had zero slowdowns beyond 5%. See every cell by name in [library/](library/) and the tracked causes in [known-costs.md](known-costs.md).

- **Interactive charts for every machine and workload:** [servil-software-factory.github.io/bench-hashes](https://servil-software-factory.github.io/bench-hashes/)
- **Full per-machine library breakdown (`library/`):** [library/](library/)

---

## Try it yourself

```sh
cargo install b3sum --version 1.8.7 --root official
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums --version 0.9.1 \
    --target x86_64-unknown-linux-gnu --root servil-0.9
RUSTFLAGS="-C target-feature=+crt-static" cargo install b3sums \
    --git https://github.com/servil-software-factory/BLAKE3 \
    --rev 2ef4c4431d56ad838f5260a123a8b03d48e00877 \
    --target x86_64-unknown-linux-gnu --root servil-0.10
```

Compare them on any file with [hyperfine](https://github.com/sharkdp/hyperfine):

```sh
hyperfine -N --warmup 3 'official/bin/b3sum FILE' 'servil-0.9/bin/b3sum FILE' 'servil-0.10/bin/b3sum FILE'
```

---

## Details, methodology & raw evidence

- **Per-machine `b3sum` tables (all 10 workloads + exact ms times):** [Apple M6](b3sum/apple-m6.md), [Ryzen 9700X](b3sum/x86-9700x.md), [2× EPYC 7443](b3sum/x86-avx2.md), [EPYC 9255](b3sum/x86-epyc-9255.md), [EPYC 9275F](b3sum/x86-epyc-9275f.md), [2× Xeon Gold 6330 (b)](b3sum/x86-icelake-2.md), [2× Xeon Gold 6330 (a)](b3sum/x86-icelake.md)
- **Per-machine library tables (all cells + 3%–5% band):** [Ryzen 9700X](library/x86-9700x.md), [2× EPYC 7443](library/x86-avx2.md), [EPYC 9255](library/x86-epyc-9255.md), [EPYC 9275F](library/x86-epyc-9275f.md), [2× Xeon Gold 6330 (b)](library/x86-icelake-2.md), [2× Xeon Gold 6330 (a)](library/x86-icelake.md)
- **Known costs and owners:** [known-costs.md](known-costs.md)
- **Machines, loads & exact commits:** [machines.md](machines.md)
- **Raw samples, scripts & checksums:** [`evidence/`](evidence/) (two-socket Linux machines bound to memory node 0; 0.10.0 commit `2ef4c4431d56ad838f5260a123a8b03d48e00877`)
