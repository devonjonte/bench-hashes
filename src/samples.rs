//! Samples TSV format (`v10`), provenance helpers, readers, writers, and per-cell summaries.

use crate::*;
use std::fmt::Write as _;

/*
 * Every sample, for tools that do their own statistics (BLAKE3-Servil's
 * performance-regression check reads this file). Lines starting with '#'
 * carry the provenance and machine identity as `key: value`; then one row
 * per measured cell and scenario: contender key, scenario (`solo`,
 * `shared-one-cache` or `shared-two-caches`), use case, point label, the
 * unit a sample is per (`B` or `msg`), and the samples as measured,
 * comma-separated, each `ns/units` (the nanoseconds the clock gave over
 * the units they covered), in the order taken (shared: the two copies of
 * each interval in turn); then each sample's start, CPU time, energy,
 * core counts and CPU (SAMPLES_COLUMNS).
 */
/// The samples file's first line and its column row, which the reader
/// (read_samples) requires: a file in another format is read with the
/// tools of the commit that wrote it.
/// The samples format, and with it the rule the samples were taken under:
/// v10 (0.21) adds each sample's instructions retired, last-level-cache
/// references and misses beside its cycles, per core kind, and reads the
/// raw counter (Zooko, November 4: the most the counters give, kept, and
/// no clock a time daemon slews); v8 (0.20)
/// added each sample's CPU, its shared rows the multithreaded
/// contenders' alone, placed under one cache or two (bench-hashes #108,
/// #116); v7 marked samples that 0.17's summary reads with the declared
/// trim (Zooko, October 23).
pub(crate) const SAMPLES_VERSION: &str = "# bench-hashes samples v10";
pub(crate) const SAMPLES_COLUMNS: &str = "contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\tcpu ns\tenergy nJ\tcore counts\tcpu";

/// The numbers one core kind contributes to a `core counts` sample:
/// time, cycles, instructions, cache references, cache misses.
pub(crate) const LEVEL_FIELDS: usize = 5;

/// A row's `core counts` field: each sample's calling-thread counts per
/// core kind, `P time ns:P cycles:P instructions:P cache references:P
/// cache misses:E time ns:E cycles:E instructions:E cache references:E
/// cache misses` (clocks::Level), or `-` where a cell's samples carry
/// none (a platform without per-thread counts).
pub(crate) fn counts_field(counts: &[Option<clocks::Counts>]) -> String {
    match counts
        .iter()
        .copied()
        .collect::<Option<Vec<clocks::Counts>>>()
    {
        Some(c) if !c.is_empty() => c
            .iter()
            .map(|c| {
                format!(
                    "{}:{}:{}:{}:{}:{}:{}:{}:{}:{}",
                    c.p.time_ns,
                    c.p.cycles,
                    c.p.instructions,
                    c.p.cache_references,
                    c.p.cache_misses,
                    c.e.time_ns,
                    c.e.cycles,
                    c.e.instructions,
                    c.e.cache_references,
                    c.e.cache_misses
                )
            })
            .collect::<Vec<_>>()
            .join(","),
        _ => "-".to_string(),
    }
}

/// A row's `cpu` field: the CPU each sample's thread ended on, or `-`
/// where the OS names none.
pub(crate) fn cpu_of_field(cpus: &[Option<u32>]) -> String {
    match cpus.iter().copied().collect::<Option<Vec<u32>>>() {
        Some(c) if !c.is_empty() => c.iter().map(u32::to_string).collect::<Vec<_>>().join(","),
        _ => "-".to_string(),
    }
}

/// A row's `cpu ns` or `energy nJ` field: each sample's, or `-` where a
/// cell has none (a sample after gaps, a shared one, no such counter).
pub(crate) fn cpu_field(cpu: &[Option<u64>]) -> String {
    match cpu.iter().copied().collect::<Option<Vec<u64>>>() {
        Some(ns) if !ns.is_empty() => ns.iter().map(u64::to_string).collect::<Vec<_>>().join(","),
        _ => "-".to_string(),
    }
}

/// One checked row of a v10 samples file: shared by `read_samples()` and
/// `beside`, so every joined or read row upholds the same invariants.
#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct SampleRow {
    pub(crate) contender: String,
    pub(crate) scenario: String,
    pub(crate) use_case: String,
    pub(crate) point: String,
    pub(crate) unit: String,
    pub(crate) samples: Vec<Measured>,
    pub(crate) start_ms: Vec<u64>,
    pub(crate) cpu_ns: Option<Vec<u64>>,
    pub(crate) energy_nj: Option<Vec<u64>>,
    pub(crate) cores: Option<Vec<[u64; LEVEL_FIELDS * 2]>>,
    pub(crate) cpus: Option<Vec<u32>>,
}

impl SampleRow {
    pub(crate) fn key(&self) -> String {
        format!(
            "{}|{}|{}|{}",
            self.contender, self.scenario, self.use_case, self.point
        )
    }

    pub(crate) fn parse(line: &str, path: &str) -> Self {
        let fields: Vec<&str> = line.split('\t').collect();
        assert_eq!(fields.len(), 11, "{path}: a row of eleven fields: {line}");
        let key = fields[..4].join("|");
        let unit = fields[4];
        assert!(
            matches!(unit, "B" | "msg"),
            "{path}: unexpected unit {unit:?} for {key}"
        );
        let samples: Vec<Measured> = fields[5]
            .split(',')
            .map(|sample| {
                let (ns, units) = sample.split_once('/').expect("ns/units");
                Measured::new(ns.parse().expect("ns"), units.parse().expect("units"))
            })
            .collect();
        assert!(!samples.is_empty(), "{path}: at least one sample for {key}");
        let start_ms: Vec<u64> = fields[6]
            .split(',')
            .map(|ms| ms.parse().expect("start ms"))
            .collect();
        assert_eq!(
            start_ms.len(),
            samples.len(),
            "{path}: a start time for every sample of {key}"
        );
        let cpu_ns = if fields[7] != "-" {
            let ns: Vec<u64> = fields[7]
                .split(',')
                .map(|ns| ns.parse().expect("cpu ns"))
                .collect();
            assert_eq!(
                ns.len(),
                samples.len(),
                "{path}: a CPU time for every sample of {key}"
            );
            Some(ns)
        } else {
            None
        };
        let energy_nj = if fields[8] != "-" {
            let nj: Vec<u64> = fields[8]
                .split(',')
                .map(|nj| nj.parse().expect("energy nJ"))
                .collect();
            assert_eq!(
                nj.len(),
                samples.len(),
                "{path}: an energy for every sample of {key}"
            );
            Some(nj)
        } else {
            None
        };
        let cores = if fields[9] != "-" {
            let c: Vec<[u64; LEVEL_FIELDS * 2]> = fields[9]
                .split(',')
                .map(|sample| {
                    let v: Vec<u64> = sample
                        .split(':')
                        .map(|x| x.parse().expect("a count"))
                        .collect();
                    v.try_into().expect(
                        "P time, cycles, instructions, cache references, cache misses; then E's",
                    )
                })
                .collect();
            assert_eq!(
                c.len(),
                samples.len(),
                "{path}: counts for every sample of {key}"
            );
            Some(c)
        } else {
            None
        };
        let cpus = if fields[10] != "-" {
            let c: Vec<u32> = fields[10]
                .split(',')
                .map(|x| x.parse().expect("a CPU number"))
                .collect();
            assert_eq!(
                c.len(),
                samples.len(),
                "{path}: a CPU for every sample of {key}"
            );
            Some(c)
        } else {
            None
        };
        Self {
            contender: fields[0].to_owned(),
            scenario: fields[1].to_owned(),
            use_case: fields[2].to_owned(),
            point: fields[3].to_owned(),
            unit: unit.to_owned(),
            samples,
            start_ms,
            cpu_ns,
            energy_nj,
            cores,
            cpus,
        }
    }

    /// Append another run's checked samples for the same cell, keeping every
    /// present optional series aligned 1:1 with wall samples (dropping an
    /// optional series to `-` if one run lacked it).
    pub(crate) fn extend_from(&mut self, other: &SampleRow) {
        assert_eq!(
            self.key(),
            other.key(),
            "joined rows belong to the same cell"
        );
        assert_eq!(self.unit, other.unit, "joined rows share the same unit");
        self.samples.extend_from_slice(&other.samples);
        self.start_ms.extend_from_slice(&other.start_ms);
        fn join_opt<T: Clone>(dst: &mut Option<Vec<T>>, src: &Option<Vec<T>>) {
            match (dst.as_mut(), src.as_ref()) {
                (Some(a), Some(b)) => a.extend_from_slice(b),
                _ => *dst = None,
            }
        }
        join_opt(&mut self.cpu_ns, &other.cpu_ns);
        join_opt(&mut self.energy_nj, &other.energy_nj);
        join_opt(&mut self.cores, &other.cores);
        join_opt(&mut self.cpus, &other.cpus);
    }

    pub(crate) fn format_tsv(&self) -> String {
        let values: Vec<String> = self
            .samples
            .iter()
            .map(|m| format!("{}/{}", m.ns, m.units))
            .collect();
        let starts: Vec<String> = self.start_ms.iter().map(u64::to_string).collect();
        let opt_u64 = |v: &Option<Vec<u64>>| match v {
            Some(s) if !s.is_empty() => s.iter().map(u64::to_string).collect::<Vec<_>>().join(","),
            _ => "-".to_owned(),
        };
        let cores = match &self.cores {
            Some(s) if !s.is_empty() => s
                .iter()
                .map(|c| c.iter().map(u64::to_string).collect::<Vec<_>>().join(":"))
                .collect::<Vec<_>>()
                .join(","),
            _ => "-".to_owned(),
        };
        let cpus = match &self.cpus {
            Some(s) if !s.is_empty() => s.iter().map(u32::to_string).collect::<Vec<_>>().join(","),
            _ => "-".to_owned(),
        };
        format!(
            "{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}",
            self.contender,
            self.scenario,
            self.use_case,
            self.point,
            self.unit,
            values.join(","),
            starts.join(","),
            opt_u64(&self.cpu_ns),
            opt_u64(&self.energy_nj),
            cores,
            cpus
        )
    }
}

pub(crate) struct ParsedSamples {
    pub(crate) raw_headers: Vec<String>,
    pub(crate) rows: Vec<SampleRow>,
}

pub(crate) fn parse_samples_rows(text: &str, path: &str) -> ParsedSamples {
    let mut lines = text.lines();
    assert_eq!(
        lines.next(),
        Some(SAMPLES_VERSION),
        "{path}: a samples file of this version begins with {SAMPLES_VERSION:?}"
    );
    let mut raw_headers = Vec::new();
    let mut columns = false;
    let mut rows: Vec<SampleRow> = Vec::new();
    let mut seen = std::collections::BTreeSet::new();
    for line in lines {
        if line.starts_with('#') {
            assert!(!columns, "{path}: header line after the column row: {line}");
            raw_headers.push(line.to_owned());
        } else if line.is_empty() {
            continue;
        } else if !columns {
            assert_eq!(line, SAMPLES_COLUMNS, "{path}: the column row");
            columns = true;
        } else {
            let row = SampleRow::parse(line, path);
            let key = row.key();
            assert!(
                seen.insert(key.clone()),
                "{path}: a samples file holds each cell once: {key} twice"
            );
            rows.push(row);
        }
    }
    assert!(columns, "{path}: missing column row {SAMPLES_COLUMNS:?}");
    ParsedSamples { raw_headers, rows }
}

pub(crate) fn read_sample_rows(path: &std::path::Path) -> ParsedSamples {
    let display = path.display().to_string();
    let text = fs::read_to_string(path)
        .unwrap_or_else(|error| panic!("failed to read {display}: {error}"));
    parse_samples_rows(&text, &display)
}

/// A samples file read back: its `# load:` line (the run's own verdict,
/// "quiet: ..." or "busy: ..."), and each cell's samples as measured,
/// keyed "contender|scenario|use_case|point", in the file's order.
#[derive(Clone)]
pub(crate) struct SamplesFile {
    /// Its `# key: value` lines, in order.
    pub(crate) headers: Vec<(String, String)>,
    pub(crate) load: String,
    /// Its `# power:` line.
    pub(crate) power: String,
    pub(crate) cells: Vec<(String, Vec<Measured>)>,
    /// The cells whose samples carry the process's CPU time: each sample's,
    /// in nanoseconds, in the order of its wall-time samples.
    pub(crate) cpu: Vec<(String, Vec<u64>)>,
    /// The cells whose samples carry the CPU package's energy: each
    /// sample's, in nanojoules, in the same order.
    pub(crate) energy: Vec<(String, Vec<u64>)>,
    /// The cells whose samples carry the calling thread's counts per core
    /// kind: each sample's P and E [time ns, cycles, instructions, cache
    /// references, cache misses] (`LEVEL_FIELDS * 2`).
    pub(crate) cores: Vec<(String, Vec<[u64; LEVEL_FIELDS * 2]>)>,
    /// The cells whose samples name the CPU each sample's thread ended on.
    pub(crate) cpus: Vec<(String, Vec<u32>)>,
}

pub(crate) fn parse_samples(text: &str, path: &str) -> SamplesFile {
    let parsed = parse_samples_rows(text, path);
    let mut load = None;
    let mut power = None;
    let mut headers = Vec::new();
    for line in &parsed.raw_headers {
        if let Some(rest) = line.strip_prefix("# load: ") {
            load = Some(rest.to_owned());
        } else if let Some(rest) = line.strip_prefix("# power: ") {
            power = Some(rest.to_owned());
        } else if let Some((key, value)) = line
            .strip_prefix("# ")
            .and_then(|rest| rest.split_once(": "))
        {
            headers.push((key.to_owned(), value.to_owned()));
        }
    }
    let mut cells = Vec::with_capacity(parsed.rows.len());
    let mut cpu = Vec::new();
    let mut energy = Vec::new();
    let mut cores = Vec::new();
    let mut cpus = Vec::new();
    for row in parsed.rows {
        let key = row.key();
        if let Some(ns) = row.cpu_ns {
            cpu.push((key.clone(), ns));
        }
        if let Some(nj) = row.energy_nj {
            energy.push((key.clone(), nj));
        }
        if let Some(c) = row.cores {
            cores.push((key.clone(), c));
        }
        if let Some(c) = row.cpus {
            cpus.push((key.clone(), c));
        }
        cells.push((key, row.samples));
    }
    SamplesFile {
        headers,
        load: load.unwrap_or_else(|| panic!("{path}: a load line")),
        power: power.unwrap_or_else(|| panic!("{path}: a power line")),
        cells,
        cpu,
        energy,
        cores,
        cpus,
    }
}

pub(crate) fn read_samples(path: &str) -> SamplesFile {
    let text =
        fs::read_to_string(path).unwrap_or_else(|error| panic!("failed to read {path}: {error}"));
    parse_samples(&text, path)
}

/// Each cell's per-unit hardware counts (Q64.64 fixed point), both kinds of
/// core summed over all its samples, where recorded (non-zero).
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub(crate) struct CellCounters {
    pub(crate) cycles: Option<u128>,
    pub(crate) instructions: Option<u128>,
    pub(crate) cache_misses: Option<u128>,
}

/// Each cell's mean wall time, optional CPU time and energy, and optional
/// hardware counters per unit (Q64.64 fixed point).
pub(crate) struct CellSummary {
    pub(crate) key: String,
    pub(crate) wall: u128,
    pub(crate) cpu: Option<u128>,
    pub(crate) energy: Option<u128>,
    pub(crate) counters: CellCounters,
}

/// Each cell's cycles, instructions retired, and cache misses a unit (fixed
/// point), both kinds of core summed over all its samples, for the cells whose
/// samples carry counts.
pub(crate) fn cell_counters(file: &SamplesFile) -> crate::Map<String, CellCounters> {
    let cores: crate::Map<&String, &Vec<[u64; LEVEL_FIELDS * 2]>> =
        file.cores.iter().map(|(k, c)| (k, c)).collect();
    file.cells
        .iter()
        .filter_map(|(key, samples)| {
            let rows = cores.get(key)?;
            let units: u128 = samples.iter().map(|m| u128::from(m.units)).sum();
            let denom = units.max(1);
            let field = |offset: usize| {
                let sum: u128 = rows
                    .iter()
                    .map(|s| u128::from(s[offset]) + u128::from(s[LEVEL_FIELDS + offset]))
                    .sum();
                // Counts all zero are counts not taken (an older bench on a
                // platform whose counts it could not read writes them so): no
                // evidence, as a missing column is, and nothing to divide by.
                (sum > 0).then(|| (sum << 64) / denom)
            };
            let counters = CellCounters {
                cycles: field(1),
                instructions: field(2),
                cache_misses: field(4),
            };
            (counters != CellCounters::default()).then(|| (key.clone(), counters))
        })
        .collect()
}

/// Each cell's mean wall time per unit (fixed point) and, where its
/// samples carry them, its CPU time, energy, and hardware counters per unit:
/// all the samples' totals over their units.
pub(crate) fn cell_means(file: SamplesFile) -> Vec<CellSummary> {
    let counters = cell_counters(&file);
    let cpu: crate::Map<String, Vec<u64>> = file.cpu.into_iter().collect();
    let energy: crate::Map<String, Vec<u64>> = file.energy.into_iter().collect();
    file.cells
        .into_iter()
        .map(|(key, samples)| {
            let units: u128 = samples.iter().map(|m| u128::from(m.units)).sum();
            let per_unit = |column: &crate::Map<String, Vec<u64>>| {
                column
                    .get(&key)
                    .map(|v| (v.iter().map(|&n| u128::from(n)).sum::<u128>() << 64) / units.max(1))
                    .filter(|&v| v > 0)
            };
            let (c, e) = (per_unit(&cpu), per_unit(&energy));
            let cell_counts = counters.get(&key).copied().unwrap_or_default();
            CellSummary {
                key,
                wall: Mean::of(&samples).fixed().0,
                cpu: c,
                energy: e,
                counters: cell_counts,
            }
        })
        .collect()
}

/// A samples file's provenance (provenance), from its headers.
pub(crate) fn file_provenance(file: &SamplesFile) -> String {
    let header = |key: &str| {
        file.headers
            .iter()
            .find(|(k, _)| k == key)
            .map_or("", |(_, v)| v.as_str())
    };
    let servil = file
        .headers
        .iter()
        .find(|(k, _)| k.starts_with("source blake3-servil"))
        .map_or("", |(_, v)| v.as_str());
    provenance(header("git commit"), header("git clean status"), servil)
}

/// Each side's builds, as `compare` and `regress` print them (`tool: old
/// side: ...`). Matching source labels alone leave compilation and run
/// settings unspecified, so report that fact without declaring an A/A.
pub(crate) fn print_sides(tool: &str, old: &[String], new: &[String]) {
    print!("{}", sides(tool, old, new));
}

pub(crate) fn sides(tool: &str, old: &[String], new: &[String]) -> String {
    let mut text = format!(
        "{tool}: old side: {}\n{tool}: new side: {}\n",
        old.join(" | "),
        new.join(" | ")
    );
    if old == new {
        text += &format!(
            "{tool}: both sides report the same sources; build and run settings may differ\n"
        );
    }
    text
}

/*
 * A samples file's header, the same in every samples file the benchmark
 * writes (the main run's, b3sum's, leaves'): the format's version; what measured
 * (this build of the benchmark, its compiler and target) and on what
 * machine; then `run`'s own keys, what this run measured; then the
 * machine's power and other programs' load over the run.
 */
pub(crate) fn samples_header(
    machine: &MachineMetadata,
    run: &[(String, String)],
    load: &str,
) -> String {
    let mut out = String::new();
    writeln!(out, "{SAMPLES_VERSION}").unwrap();
    for (key, value) in [
        ("timestamp", machine.timestamp.as_str()),
        ("bench-hashes version", BENCH_VERSION),
        ("bench-hashes source", GIT_SOURCE),
        ("git commit", GIT_COMMIT),
        ("git clean status", GIT_CLEAN_STATUS),
        ("blake3-servil version", BLAKE3_SERVIL_VERSION),
        ("dependency lock", LOCK_FINGERPRINT),
        ("rust compiler", RUSTC_VERSION),
        ("c compiler", C_COMPILER),
        ("rustflags", RUSTFLAGS),
        ("build target", BUILD_TARGET),
        ("target features", TARGET_FEATURES),
        ("sample clock", clocks::WALL_CLOCK),
        ("clocks source", CLOCKS_SOURCE_INFO),
        ("cpu type", machine.cpu_type.as_str()),
        ("cpu count", machine.cpu_count.to_string().as_str()),
        ("os type", machine.os_type.as_str()),
        ("cpu identity", machine.cpu_identity.as_str()),
        ("idle states", machine.idle_states.as_str()),
        (
            "effective idle states",
            machine.effective_idle_states.as_str(),
        ),
        ("idle control", machine.idle_control.as_str()),
        ("shared placements", machine.placements.as_str()),
        ("counts read overhead", machine.read_overhead.as_str()),
    ]
    .into_iter()
    .chain(
        run.iter()
            .map(|(key, value)| (key.as_str(), value.as_str())),
    ) {
        writeln!(out, "# {key}: {value}").unwrap();
    }
    writeln!(out, "# power: {}", machine.describe_power()).unwrap();
    if let Some(allocator) = diag_alloc::DESCRIPTION {
        writeln!(out, "# global allocator: {allocator}").unwrap();
    }
    writeln!(out, "# load: {load}").unwrap();
    let windows: Vec<String> = machine
        .load
        .iter()
        .map(|w| {
            format!(
                "{}-{}:{}:{}",
                w.start_ns / 1_000_000,
                w.end_ns / 1_000_000,
                w.other_milli_cpus,
                w.steal_milli_cpus
            )
        })
        .collect();
    writeln!(
        out,
        "# load windows (start ms-end ms:other milli-CPUs:steal milli-CPUs): {}",
        windows.join(",")
    )
    .unwrap();
    out
}

pub(crate) fn generate_samples_tsv(
    roster: &Roster,
    samples: &RunSamples,
    machine: &MachineMetadata,
    selection_note: &str,
) -> String {
    // Each contender's source, every one the run measured (a contender added
    // later has its line without anyone remembering to add it).
    let mut run: Vec<(String, String)> = roster
        .algorithms
        .iter()
        .map(|a| (format!("source {}", a.key()), a.source().to_owned()))
        .collect();
    run.extend([
        ("contenders".to_owned(), selection_note.to_owned()),
        ("rounds".to_owned(), roster.rounds.to_string()),
        ("measuring thread".to_owned(), describe_pinning()),
        ("sample sizes".to_owned(), roster.sample_sizes.clone()),
        (
            "buffers owned".to_owned(),
            "where a contender makes the same calls as with buffers lent, one measurement, shown in both rows".to_owned(),
        ),
        (
            "nonstop train".to_owned(),
            format!(
                "{} ms warm-up, {} samples a visit",
                roster.train.warm_ns / 1_000_000,
                roster.train.samples
            ),
        ),
        (
            "points".to_owned(),
            roster
                .points
                .iter()
                .map(|&index| POINTS[index].label)
                .collect::<Vec<_>>()
                .join(","),
        ),
    ]);
    if roster
        .points
        .iter()
        .any(|&p| POINTS[p].use_case == UseCase::ReceivingMessage)
    {
        run.push(("receive trace".to_owned(), receive::description()));
    }
    let mut out = samples_header(machine, &run, &clocks::load::describe(&machine.load));
    writeln!(out, "{SAMPLES_COLUMNS}").unwrap();
    for (algorithm_index, &algorithm) in roster.algorithms.iter().enumerate() {
        for scenario in Scenario::ALL {
            let rows = match scenario {
                Scenario::Solo => &samples.solo,
                Scenario::Shared(p) => &samples.shared[p.index()],
            };
            for (point_index, point) in POINTS.iter().enumerate() {
                let cell_samples = &rows[algorithm_index][point_index];
                if cell_samples.is_empty() {
                    continue;
                }
                let values: Vec<String> = cell_samples
                    .iter()
                    .map(|m| format!("{}/{}", m.ns, m.units))
                    .collect();
                let timestamps = match scenario {
                    Scenario::Solo => &samples.solo_started_ns,
                    Scenario::Shared(p) => &samples.shared_started_ns[p.index()],
                };
                let cell_starts = &timestamps[algorithm_index][point_index];
                assert_eq!(
                    cell_starts.len(),
                    cell_samples.len(),
                    "each sample has its own load timestamp"
                );
                let starts: Vec<String> = cell_starts
                    .iter()
                    .map(|ns| (ns / 1_000_000).to_string())
                    .collect();
                let (cpu, energy, counts, on) = match scenario {
                    Scenario::Solo => (
                        cpu_field(&samples.solo_cpu_ns[algorithm_index][point_index]),
                        cpu_field(&samples.solo_energy_nj[algorithm_index][point_index]),
                        counts_field(&samples.solo_counts[algorithm_index][point_index]),
                        cpu_of_field(&samples.solo_cpu[algorithm_index][point_index]),
                    ),
                    Scenario::Shared(p) => (
                        "-".to_string(),
                        "-".to_string(),
                        counts_field(
                            &samples.shared_counts[p.index()][algorithm_index][point_index],
                        ),
                        cpu_of_field(&samples.shared_cpu[p.index()][algorithm_index][point_index]),
                    ),
                };
                writeln!(
                    out,
                    "{}\t{}\t{:?}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}",
                    algorithm.key(),
                    scenario.key(),
                    point.use_case,
                    point.label,
                    point.use_case.unit_key(),
                    values.join(","),
                    starts.join(","),
                    cpu,
                    energy,
                    counts,
                    on,
                )
                .unwrap();
            }
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    #[should_panic(expected = "missing column row")]
    fn parse_samples_rejects_missing_column_row() {
        let text = format!("{SAMPLES_VERSION}\n# load: quiet\n# power: mains power\n");
        let _ = parse_samples(&text, "missing-columns.tsv");
    }

    #[test]
    #[should_panic(expected = "a start time for every sample")]
    fn parse_samples_rejects_mismatched_start_times() {
        let text = format!(
            "{SAMPLES_VERSION}\n# load: quiet\n# power: mains power\n{SAMPLES_COLUMNS}\n\
             blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t100/64,110/64\t1\t-\t-\t-\t-\n"
        );
        let _ = parse_samples(&text, "bad-starts.tsv");
    }

    #[test]
    #[should_panic(expected = "unexpected unit")]
    fn parse_samples_rejects_unknown_unit() {
        let text = format!(
            "{SAMPLES_VERSION}\n# load: quiet\n# power: mains power\n{SAMPLES_COLUMNS}\n\
             blake3-servil-st\tsolo\tOneMessage\t64 B\tKiB\t100/64\t1\t-\t-\t-\t-\n"
        );
        let _ = parse_samples(&text, "bad-unit.tsv");
    }
}
