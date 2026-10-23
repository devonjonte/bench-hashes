//! `bench-hashes overview OUT.html DIR...`: one page above the maps. Each
//! row is a machine (one published results directory), each column one
//! representative measurement (FROZEN's "The overview"), and each cell the
//! ratio of a competitor's time to BLAKE3 servil's in that run: read across
//! a row for one machine, down a column for one use across machines. The
//! cells are read from the same samples files the maps are drawn from,
//! through the same reader and summary rule; every figure on the page is
//! computed here, none typed.

use super::{read_samples, Algorithm, Measured, SamplesFile, UseCase, POINTS, SAMPLES_VERSION};
use std::fmt::Write as _;
use std::path::Path;

/// One representative measurement: a column of the overview.
pub struct Pick {
    /// The column's heading.
    pub column: &'static str,
    /// The user's situation it stands for, under the heading.
    pub situation: &'static str,
    pub cell: Cell,
}

pub enum Cell {
    /// A hashing cell: `solo|use_case|point`, BLAKE3 servil's contender in
    /// it, and whether BLAKE3 official's multithreaded form is the fair
    /// comparison (where servil's is multithreaded).
    Hashing {
        use_case: UseCase,
        point: &'static str,
        servil: Algorithm,
    },
    /// A b3sum cell: the cache state and the input, from `b3sum.samples.tsv`.
    B3sum {
        cache: &'static str,
        input: &'static str,
    },
}

/// The representative measurements, chosen once (FROZEN, "The overview").
/// The test frozen_contract_matches_frozen_md keeps this list and FROZEN's
/// block the same.
pub const PICKS: [Pick; 7] = [
    Pick {
        column: "small values",
        situation: "a key, an identifier, a small record, hashed between a program's other work",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "64 B", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "small values",
        situation: "a small record, hashed between a program's other work",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "1 KiB", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "one message, one thread",
        situation: "a buffer the size of a file, on the calling thread",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "1 MiB", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "one big message, every core",
        situation: "a download or a disk image, the library's threads at work",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "128 MiB", servil: Algorithm::Blake3ServilMt },
    },
    Pick {
        column: "nonstop, from one calling thread",
        situation: "messages arriving one after another, as fast as the program can feed them; BLAKE3 servil's stream hashes them on its threads, the others on the calling thread",
        cell: Cell::Hashing { use_case: UseCase::ContinuousMessages, point: "64 KiB", servil: Algorithm::Blake3ServilMt },
    },
    Pick {
        column: "many small messages at once",
        situation: "a Merkle layer, a content-addressed store, a database's keys: 1024 messages of 64 bytes in one call",
        cell: Cell::Hashing { use_case: UseCase::ManyMessages, point: "1024", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "files",
        situation: "b3sum over a directory of 1000 files of assorted sizes, 74 MiB, in the page cache: the command itself, start to exit",
        cell: Cell::B3sum { cache: "warm", input: "mixed tree, 1000 files, 74 MiB" },
    },
];

/// The picks as FROZEN's block states them, one line each.
#[cfg(test)]
pub fn frozen_lines() -> String {
    let mut text = String::new();
    for pick in &PICKS {
        match &pick.cell {
            Cell::Hashing {
                use_case,
                point,
                servil,
            } => {
                let _ = writeln!(
                    text,
                    "overview cell: solo {use_case:?} {point}, {} ({})",
                    servil.key(),
                    pick.column
                );
            }
            Cell::B3sum { cache, input } => {
                let _ = writeln!(
                    text,
                    "overview cell: b3sum {cache} {input} ({})",
                    pick.column
                );
            }
        }
    }
    text
}

/// The b3sum names the fork's build goes by in a run, newest convention
/// first (bench-hashes #55 settles on `b3sum`), and the competitors shown.
const FORK_B3SUM: [&str; 3] = ["b3sum", "devon", "fork"];
const B3SUM_COMPETITORS: [(&str, &str, &str); 4] = [
    ("official", "b3sum, official BLAKE3's", "#3b82f6"),
    ("sha256sum", "sha256sum", "#e07a45"),
    // Drab greys: SHA-1 and MD5 are broken as cryptographic hashes
    // (collisions are cheap to make) and kept only as checksums people
    // still run; the page's door says so.
    ("sha1sum", "sha1sum", "#b4b0a8"),
    ("md5sum", "md5sum", "#cfcbc3"),
];

/// One bar: a hash's speed in a cell.
pub struct Bar {
    pub name: String,
    /// The map's colour for it.
    pub color: &'static str,
    /// Bytes hashed per second, in GB/s (the map's unit), from the cell's
    /// mean through the shared rule.
    pub gbps: f64,
    /// A note the bar carries, such as "official on one thread".
    pub note: &'static str,
}

/// A cell's bars: BLAKE3 servil's first, then each competitor's.
pub type Bars = Vec<Bar>;

/// One machine's row.
pub struct Row {
    pub machine: String,
    pub cpus: String,
    pub os: String,
    pub day: String,
    pub fork: String,
    pub version: String,
    pub virtual_machine: bool,
    /// The results directory, as the page links to its maps.
    pub link: String,
    /// One entry per pick: its bars, or none where the run lacks the cell.
    pub cells: Vec<Bars>,
    /// For the ribbons: each family's speed at each message size across
    /// this run's message cells (one message now and then or after a
    /// pause, nonstop lent, nonstop pipelined; single- and multi-threaded):
    /// (family, bytes, GB/s, the cell it came from).
    pub curves: Vec<(&'static str, usize, f64, String)>,
    /// Set where the run is of another release of the benchmark: its
    /// samples are not read (their rule is their own release's), the row
    /// names the machine and links its map, and says a run under this
    /// release is awaited.
    pub stale: bool,
}

fn mean_q64(samples: &[Measured]) -> u128 {
    clocks::summary::mean(samples.iter().map(|m| (m.ns, m.units)))
}

/// A cell's speed in GB/s: `bytes_per_unit` bytes over its mean ns per
/// unit (the shared rule's Q64.64 figure; floating point at the last step).
fn gbps(samples: &[Measured], bytes_per_unit: f64) -> f64 {
    bytes_per_unit * 18_446_744_073_709_551_616.0 / mean_q64(samples) as f64
}

fn cell<'a>(file: &'a SamplesFile, key: &str) -> Option<&'a [Measured]> {
    file.cells
        .iter()
        .find(|(k, _)| k == key)
        .map(|(_, s)| s.as_slice())
}

fn hashing_bars(file: &SamplesFile, use_case: UseCase, point: &str, servil: Algorithm) -> Bars {
    let key = |a: Algorithm| format!("{}|solo|{use_case:?}|{point}", a.key());
    let per_unit = if use_case.batch() {
        use_case.message_len() as f64
    } else {
        1.0
    };
    let bar = |a: Algorithm, samples: &[Measured], note| Bar {
        name: plain_name(a).to_owned(),
        color: a.color(),
        gbps: gbps(samples, per_unit),
        note,
    };
    let Some(ours) = cell(file, &key(servil)) else {
        return Vec::new();
    };
    let mut bars = vec![bar(servil, ours, "")];
    // BLAKE3 official: its multithreaded form where servil's cell is
    // multithreaded and the run measured it; else its one thread, noted.
    let official = if servil == Algorithm::Blake3ServilMt {
        match cell(file, &key(Algorithm::Blake3Rayon)) {
            Some(mt) => Some((Algorithm::Blake3Rayon, mt, "")),
            None => cell(file, &key(Algorithm::Blake3)).map(|one| {
                (
                    Algorithm::Blake3,
                    one,
                    "this run has no multi-threaded BLAKE3 official, so its single-threaded form stands beside servil's multi-threaded",
                )
            }),
        }
    } else {
        cell(file, &key(Algorithm::Blake3)).map(|one| (Algorithm::Blake3, one, ""))
    };
    if let Some((a, theirs, note)) = official {
        bars.push(bar(a, theirs, note));
    }
    // The fastest SHA-256 the run measured in this cell.
    let sha = [
        Algorithm::Sha256,
        Algorithm::Sha256Ring,
        Algorithm::Sha256CommonCrypto,
    ]
    .into_iter()
    .filter_map(|a| cell(file, &key(a)).map(|s| (a, mean_q64(s), s)))
    .min_by_key(|(_, m, _)| *m);
    if let Some((a, _, theirs)) = sha {
        bars.push(Bar {
            name: format!("SHA-256, the fastest measured ({})", a.name()),
            color: Algorithm::Sha256.color(),
            gbps: gbps(theirs, per_unit),
            note: "",
        });
    }
    bars
}

fn b3sum_bars(file: &SamplesFile, cache: &str, input: &str) -> Bars {
    let key = |name: &str| format!("{name}|{cache}|b3sum|{input}");
    // b3sum's samples are ns over the input's bytes.
    let bar = |name: &str, color, samples| Bar {
        name: name.to_owned(),
        color,
        gbps: gbps(samples, 1.0),
        note: "",
    };
    let Some(ours) = FORK_B3SUM.iter().find_map(|n| cell(file, &key(n))) else {
        return Vec::new();
    };
    let mut bars = vec![bar(
        "b3sum, BLAKE3 servil's",
        Algorithm::Blake3ServilMt.color(),
        ours,
    )];
    bars.extend(B3SUM_COMPETITORS.iter().filter_map(|(name, shown, color)| {
        cell(file, &key(name)).map(|theirs| bar(shown, color, theirs))
    }));
    bars
}

/// A contender's name in plain words: the map's "st" and "mt" spelled out.
fn plain_name(a: Algorithm) -> &'static str {
    match a {
        Algorithm::Blake3ServilSt => "BLAKE3 servil, single-threaded",
        Algorithm::Blake3ServilMt => "BLAKE3 servil, multi-threaded",
        Algorithm::Blake3 => "BLAKE3 official, single-threaded",
        Algorithm::Blake3Rayon => "BLAKE3 official, multi-threaded",
        other => other.name(),
    }
}

fn header<'a>(headers: &'a [(String, String)], key: &str) -> &'a str {
    headers
        .iter()
        .find(|(k, _)| k == key)
        .map_or("", |(_, v)| v.as_str())
}

/// A CPU's name as the vendor's string gives it, less its trademarks and
/// generation and core-count words: "12th Gen Intel(R) Core(TM) i7-12700K"
/// reads "Intel Core i7-12700K", "AMD EPYC 9654 96-Core Processor" "AMD EPYC 9654".
fn short_name(cpu: &str) -> String {
    let cleaned = cpu.replace("(R)", "").replace("(TM)", "");
    let words: Vec<&str> = cleaned.split_whitespace().collect();
    let number = |w: &str, suffix: &str| {
        w.strip_suffix(suffix)
            .is_some_and(|n| n.parse::<u32>().is_ok())
    };
    let mut out: Vec<&str> = Vec::new();
    let mut i = 0;
    while i < words.len() {
        let w = words[i];
        if number(w, "th") && words.get(i + 1) == Some(&"Gen") {
            i += 2;
        } else if w == "Processor" || w == "CPU" || number(w, "-Core") {
            i += 1;
        } else {
            out.push(w);
            i += 1;
        }
    }
    out.join(" ")
}

/// Read one results directory into a row: its hashing run, and its b3sum
/// run where it has one.
pub fn row(directory: &Path, link: String) -> Row {
    let hashing = directory.join("bench-hashes.samples.tsv");
    let b3sum = directory.join("b3sum.samples.tsv");
    let present: Vec<&Path> = [&hashing, &b3sum]
        .into_iter()
        .filter(|p| p.exists())
        .map(|p| p.as_path())
        .collect();
    assert!(
        !present.is_empty(),
        "{} holds no samples file (bench-hashes.samples.tsv, b3sum.samples.tsv)",
        directory.display()
    );
    // A file of another release is left to its own tools: a folder with
    // none of this release's gets a row that names the machine and links
    // its map, its cells awaiting a run under this release.
    let current = |p: &Path| {
        std::fs::read_to_string(p)
            .expect("a samples file")
            .lines()
            .next()
            == Some(SAMPLES_VERSION)
    };
    if !present.iter().any(|p| current(p)) {
        let text = std::fs::read_to_string(present[0]).expect("a samples file");
        let headers: Vec<(String, String)> = text
            .lines()
            .take_while(|l| l.starts_with('#'))
            .filter_map(|l| l[1..].trim().split_once(": "))
            .map(|(k, v)| (k.to_owned(), v.to_owned()))
            .collect();
        return described(
            &headers,
            link,
            PICKS.iter().map(|_| Vec::new()).collect(),
            true,
        );
    }
    let hashing = (hashing.exists() && current(&hashing))
        .then(|| read_samples(hashing.to_str().expect("a path in UTF-8")));
    let b3sum = (b3sum.exists() && current(&b3sum))
        .then(|| read_samples(b3sum.to_str().expect("a path in UTF-8")));
    let about = hashing
        .as_ref()
        .or(b3sum.as_ref())
        .expect("a samples file read");
    let curves = hashing.as_ref().map_or(Vec::new(), curves_of);
    let cells = PICKS
        .iter()
        .map(|pick| match &pick.cell {
            Cell::Hashing {
                use_case,
                point,
                servil,
            } => hashing
                .as_ref()
                .map_or(Vec::new(), |f| hashing_bars(f, *use_case, point, *servil)),
            Cell::B3sum { cache, input } => b3sum
                .as_ref()
                .map_or(Vec::new(), |f| b3sum_bars(f, cache, input)),
        })
        .collect();
    let mut row = described(&about.headers, link, cells, false);
    row.curves = curves;
    row
}

/// The message use cases the ribbons span: a message hashed now and then
/// (after other work, after a pause), nonstop waiting for each call, and
/// nonstop pipelined; solo.
const RIBBON_CASES: [UseCase; 4] = [
    UseCase::OneMessage,
    UseCase::IdleOneMessage,
    UseCase::LentMessages,
    UseCase::ContinuousMessages,
];

/// The three families the ribbons draw, each over its contenders.
const FAMILIES: [(&str, &[Algorithm]); 3] = [
    (
        "BLAKE3 servil",
        &[Algorithm::Blake3ServilSt, Algorithm::Blake3ServilMt],
    ),
    (
        "BLAKE3 official",
        &[Algorithm::Blake3, Algorithm::Blake3Rayon],
    ),
    (
        "SHA-256",
        &[
            Algorithm::Sha256,
            Algorithm::Sha256Ring,
            Algorithm::Sha256CommonCrypto,
        ],
    ),
];

/// Every (family, bytes, GB/s, cell) of a run's message cells.
fn curves_of(file: &SamplesFile) -> Vec<(&'static str, usize, f64, String)> {
    let mut out = Vec::new();
    for (family, algorithms) in FAMILIES {
        for use_case in RIBBON_CASES {
            for point in &POINTS[use_case.points()] {
                for a in algorithms.iter() {
                    let key = format!("{}|solo|{use_case:?}|{}", a.key(), point.label);
                    if let Some(samples) = cell(file, &key) {
                        out.push((
                            family,
                            point.bytes,
                            gbps(samples, 1.0),
                            format!(
                                "{}, {}, {}",
                                plain_name(*a),
                                use_case.heading(),
                                point.label
                            ),
                        ));
                    }
                }
            }
        }
    }
    out
}

/// A row from a run's headers and its cells.
fn described(headers: &[(String, String)], link: String, cells: Vec<Bars>, stale: bool) -> Row {
    let os = header(headers, "os type");
    let os = if os.starts_with("darwin") {
        "macOS".to_owned()
    } else if os.starts_with("linux") {
        "Linux".to_owned()
    } else {
        os.to_owned()
    };
    let fork = headers
        .iter()
        .find(|(k, _)| k.starts_with("source blake3-servil"))
        .and_then(|(_, v)| v.split("commit ").nth(1))
        .map_or(String::new(), |c| c[..c.len().min(7)].to_owned());
    let identity = header(headers, "cpu identity");
    Row {
        machine: short_name(header(headers, "cpu type")),
        cpus: header(headers, "cpu count").to_owned(),
        virtual_machine: header(headers, "os type").contains("virt")
            || identity.contains("virt")
            || identity.contains("QEMU"),
        os,
        day: header(headers, "timestamp")
            .split(' ')
            .next()
            .unwrap_or("")
            .to_owned(),
        fork,
        version: header(headers, "bench-hashes version")
            .split('+')
            .next()
            .unwrap_or("")
            .to_owned(),
        link,
        cells,
        curves: Vec::new(),
        stale,
    }
}

/// The columns, each with the indexes of its picks (two picks may share one).
fn columns() -> Vec<(&'static str, Vec<usize>)> {
    let mut columns: Vec<(&'static str, Vec<usize>)> = Vec::new();
    for (i, pick) in PICKS.iter().enumerate() {
        match columns.iter_mut().find(|(c, _)| *c == pick.column) {
            Some((_, picks)) => picks.push(i),
            None => columns.push((pick.column, vec![i])),
        }
    }
    columns
}

/// A ratio as the page says it, under the pointer: one figure after the
/// point below 10 ("2.5×"), whole numbers above ("12×"). Two figures would
/// claim a precision one run does not have.
fn figure(ratio: f64) -> String {
    if ratio >= 10.0 {
        format!("{ratio:.0}×")
    } else {
        format!("{ratio:.1}×")
    }
}

/// A speed as the page says it: two significant figures, the precision one
/// run on one machine has.
fn speed(gbps: f64) -> String {
    if gbps <= 0.0 {
        return "0 GB/s".to_owned();
    }
    let digits = (1 - gbps.log10().floor() as i32).max(0) as usize;
    format!("{gbps:.digits$} GB/s")
}

fn escape(text: &str) -> String {
    text.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
}

fn point_of(pick: &Pick) -> String {
    match &pick.cell {
        Cell::Hashing { point, .. } => (*point).to_owned(),
        Cell::B3sum { .. } => "1000 files".to_owned(),
    }
}

/// The grid as text, for the terminal and the tests: each cell's speeds,
/// and servil's over each competitor's.
pub fn text(rows: &[Row]) -> String {
    let mut out = String::new();
    for row in rows {
        let _ = writeln!(
            out,
            "{}{}, {} CPUs, {} · {} · bench-hashes {}, BLAKE3 servil {}",
            if row.virtual_machine { "(VM) " } else { "" },
            row.machine,
            row.cpus,
            row.os,
            row.day,
            row.version,
            row.fork
        );
        if row.stale {
            let _ = writeln!(
                out,
                "  last measured under bench-hashes {}: a run under this release is awaited\n",
                row.version
            );
            continue;
        }
        for (pick, bars) in PICKS.iter().zip(&row.cells) {
            let line = match bars.split_first() {
                None => "not in this run".to_owned(),
                Some((ours, others)) => {
                    let mut line = format!("{} {}", speed(ours.gbps), ours.name);
                    for b in others {
                        let note = if b.note.is_empty() {
                            String::new()
                        } else {
                            format!(" [{}]", b.note)
                        };
                        let _ = write!(
                            line,
                            "; {} {} ({}){note}",
                            speed(b.gbps),
                            b.name,
                            figure(ours.gbps / b.gbps)
                        );
                    }
                    line
                }
            };
            let _ = writeln!(
                out,
                "  {:34} {line}",
                format!("{}, {}:", pick.column, point_of(pick))
            );
        }
        out.push('\n');
    }
    out
}

/// The ribbons: one chart over message size, a filled band per family
/// from its slowest to its fastest cell at each size, over every machine
/// of this release and every message use case, single- and multi-
/// threaded. It hides every figure but the edges (the band's bottom is a
/// message between other work on one thread; its top is every core
/// nonstop) and shows the families' order at a glance. Points at a size
/// are shown in the tooltip with the cells that set each edge.
fn ribbons(rows: &[Row]) -> String {
    let rows: Vec<&Row> = rows
        .iter()
        .filter(|r| !r.stale && !r.virtual_machine)
        .collect();
    // The sizes every ribbon use case measures (the nonstop ones' points:
    // 64 B to 64 MiB by fours), so each edge is the same kind of cell at
    // every size and the bands run smooth; the odd sizes a single use case
    // adds stay on the map.
    let mut sizes: Vec<usize> = POINTS[UseCase::ContinuousMessages.points()]
        .iter()
        .map(|p| p.bytes)
        .collect();
    sizes.retain(|b| rows.iter().any(|r| r.curves.iter().any(|c| c.1 == *b)));
    sizes.sort_unstable();
    sizes.dedup();
    if sizes.len() < 2 {
        return String::new();
    }
    // Each family's edges at each size: (min, who, max, who).
    let mut bands: Vec<(&str, &str, Vec<(usize, f64, String, f64, String)>)> = Vec::new();
    for (family, algorithms) in FAMILIES {
        let color = algorithms[0].color();
        let mut edges = Vec::new();
        for &size in &sizes {
            let mut lo: Option<(f64, String)> = None;
            let mut hi: Option<(f64, String)> = None;
            for r in &rows {
                for (f, b, g, who) in &r.curves {
                    if *f != family || *b != size {
                        continue;
                    }
                    let who = format!("{} ({})", who, r.machine);
                    if lo.as_ref().is_none_or(|(l, _)| *g < *l) {
                        lo = Some((*g, who.clone()));
                    }
                    if hi.as_ref().is_none_or(|(h, _)| *g > *h) {
                        hi = Some((*g, who));
                    }
                }
            }
            if let (Some((l, lw)), Some((h, hw))) = (lo, hi) {
                edges.push((size, l, lw, h, hw));
            }
        }
        if !edges.is_empty() {
            bands.push((family, color, edges));
        }
    }
    let (w, h, left, right, top, bottom) = (980.0, 300.0, 56.0, 150.0, 16.0, 36.0);
    let (lo_b, hi_b) = (
        *sizes.first().unwrap() as f64,
        *sizes.last().unwrap() as f64,
    );
    let all: Vec<f64> = bands
        .iter()
        .flat_map(|(_, _, e)| e.iter().flat_map(|x| [x.1, x.3]))
        .collect();
    let (lo_g, hi_g) = (
        all.iter().cloned().fold(f64::INFINITY, f64::min),
        all.iter().cloned().fold(0.0, f64::max),
    );
    let (lo_g, hi_g) = (
        10f64.powf(lo_g.log10().floor()),
        10f64.powf(hi_g.log10().ceil()),
    );
    let x =
        |b: f64| left + (b.log2() - lo_b.log2()) / (hi_b.log2() - lo_b.log2()) * (w - left - right);
    let y = |g: f64| {
        top + (hi_g.log10() - g.log10()) / (hi_g.log10() - lo_g.log10()) * (h - top - bottom)
    };
    let mut svg =
        format!("<svg class=\"ribbons\" viewBox=\"0 0 {w} {h}\" width=\"{w}\" height=\"{h}\">");
    // Gridlines: a line per factor of ten, labelled in GB/s.
    let mut e = lo_g.log10() as i32;
    while 10f64.powi(e) <= hi_g {
        let g = 10f64.powi(e);
        let _ = write!(svg, "<line x1=\"{left}\" x2=\"{}\" y1=\"{:.1}\" y2=\"{:.1}\" stroke=\"#eceae6\"/><text x=\"{}\" y=\"{:.1}\" font-size=\"10\" fill=\"#9ca3af\" text-anchor=\"end\">{}</text>", w - right, y(g), y(g), left - 6.0, y(g) + 3.5, speed(g));
        e += 1;
    }
    // Size ticks, a few.
    for &size in &sizes {
        if size.is_power_of_two() && size.trailing_zeros() % 4 == 0 {
            let label = if size >= 1 << 20 {
                format!("{} MiB", size >> 20)
            } else if size >= 1 << 10 {
                format!("{} KiB", size >> 10)
            } else {
                format!("{size} B")
            };
            let _ = write!(svg, "<text x=\"{:.1}\" y=\"{}\" font-size=\"10\" fill=\"#9ca3af\" text-anchor=\"middle\">{label}</text>", x(size as f64), h - bottom + 16.0);
        }
    }
    let _ = write!(svg, "<text x=\"{:.1}\" y=\"{}\" font-size=\"10\" fill=\"#9ca3af\" text-anchor=\"middle\">message size</text>", (left + w - right) / 2.0, h - 2.0);
    let mut label_ys: Vec<f64> = Vec::new();
    for (family, color, edges) in &bands {
        let upper: Vec<String> = edges
            .iter()
            .map(|(b, _, _, hi, _)| format!("{:.1},{:.1}", x(*b as f64), y(*hi)))
            .collect();
        let lower: Vec<String> = edges
            .iter()
            .rev()
            .map(|(b, lo, _, _, _)| format!("{:.1},{:.1}", x(*b as f64), y(*lo)))
            .collect();
        let _ = write!(svg, "<path d=\"M{} L{} Z\" fill=\"{color}\" fill-opacity=\"0.28\" stroke=\"{color}\" stroke-opacity=\"0.9\" stroke-width=\"1\"><title>{}</title></path>", upper.join(" L"), lower.join(" L"), escape(family));
        let last = edges.last().unwrap();
        let mut ly = (y(last.3) + y(last.1)) / 2.0 + 4.0;
        while label_ys.iter().any(|&other| (other - ly).abs() < 13.0) {
            ly += 13.0;
        }
        label_ys.push(ly);
        let _ = write!(svg, "<text x=\"{:.1}\" y=\"{:.1}\" font-size=\"11\" fill=\"{color}\" font-weight=\"600\">{}</text>", x(last.0 as f64) + 6.0, ly, escape(family));
    }
    // One invisible column per size carries the tooltip's text.
    for (i, &size) in sizes.iter().enumerate() {
        let x0 = if i == 0 {
            left
        } else {
            (x(size as f64) + x(sizes[i - 1] as f64)) / 2.0
        };
        let x1 = if i + 1 == sizes.len() {
            w - right
        } else {
            (x(size as f64) + x(sizes[i + 1] as f64)) / 2.0
        };
        let mut lines = Vec::new();
        for (family, color, edges) in &bands {
            if let Some((_, lo, lw, hi, hw)) = edges.iter().find(|e| e.0 == size) {
                lines.push(format!("{color}\t{family}\t{}\t{}\t{}\t{}", hi, hw, lo, lw));
            }
        }
        let label = if size >= 1 << 20 {
            format!("{} MiB", size >> 20)
        } else if size >= 1 << 10 && size % 1024 == 0 {
            format!("{} KiB", size >> 10)
        } else {
            format!("{size} B")
        };
        let _ = write!(svg, "<rect class=\"col\" x=\"{x0:.1}\" y=\"{top}\" width=\"{:.1}\" height=\"{:.1}\" fill=\"transparent\" data-size=\"{}\" data-tip=\"{}\"/>", x1 - x0, h - top - bottom, escape(&label), escape(&lines.join("\n")));
    }
    svg.push_str("</svg>");
    svg
}

/// The page: a row per machine, a column per situation, and in each cell
/// a small bar chart in the map's colours, BLAKE3 servil's bar first and
/// each competitor's under it, lengths in proportion to speed (the fastest
/// in the cell fills the width, its speed at the end as the scale). The
/// legend's buttons are the hashes drawn, each in its bar's colour, and
/// hide or show its bars; a pick under the pointer shows its figures in
/// the map's tooltip.
pub fn html(rows: &[Row]) -> String {
    let columns = columns();
    // The legend: one button a colour, named for the hash first drawn in
    // it (b3sum's bars share their library's colour; the tooltip names
    // each bar exactly). A button hides or shows every bar of its colour.
    let mut drawn: Vec<(&str, &str)> = Vec::new();
    for b in rows.iter().flat_map(|r| r.cells.iter().flatten()) {
        if !drawn.iter().any(|(_, c)| *c == b.color) {
            drawn.push((&b.name, b.color));
        }
    }
    // Servil's two first, then official's two, then the SHA-256s, then the
    // rest as drawn (sha1sum, md5sum).
    let order = [
        Algorithm::Blake3ServilSt,
        Algorithm::Blake3ServilMt,
        Algorithm::Blake3,
        Algorithm::Blake3Rayon,
        Algorithm::Sha256,
        Algorithm::Sha256Ring,
        Algorithm::Sha256CommonCrypto,
    ];
    let rank = |color: &str| {
        order
            .iter()
            .position(|a| a.color() == color)
            .unwrap_or(usize::MAX)
    };
    drawn.sort_by_key(|(_, c)| rank(c));
    let mut legend = String::new();
    for (name, color) in &drawn {
        let _ = write!(
            legend,
            "<button style=\"--c:{color}\" data-c=\"{color}\">{}</button>",
            escape(name.split(" (").next().unwrap_or(name))
        );
    }
    let mut body = String::new();
    body.push_str("<div class=\"grid\"><table><thead><tr><th class=\"machine\"></th>");
    for (column, picks) in &columns {
        let situations: Vec<String> = picks.iter().map(|&i| escape(PICKS[i].situation)).collect();
        let _ = write!(
            body,
            "<th title=\"{}\">{}</th>",
            situations.join(" · "),
            escape(column)
        );
    }
    body.push_str("</tr></thead><tbody>\n");
    for row in rows {
        let class = if row.virtual_machine {
            " class=\"vm\""
        } else {
            ""
        };
        let arch = if row.machine.contains("Apple") {
            "apple"
        } else {
            "x86"
        };
        let _ = write!(
            body,
            "<tr{class} data-arch=\"{arch}\"><td class=\"machine\"><a href=\"{}/bench-hashes.map.html\"><b>{}{}</b></a><span>{} CPUs, {} · {}</span><span>BLAKE3 servil {} · bench-hashes {}</span></td>",
            escape(&row.link),
            if row.virtual_machine { "VM on " } else { "" },
            escape(&row.machine),
            escape(&row.cpus),
            escape(&row.os),
            escape(&row.day),
            escape(&row.fork),
            escape(&row.version)
        );
        if row.stale {
            let _ = write!(
                body,
                "<td class=\"stale\" colspan=\"{}\">last measured under bench-hashes {}, on {}: <a href=\"{}/bench-hashes.map.html\">its map</a>; a run under this release is awaited</td></tr>\n",
                columns.len(),
                escape(&row.version),
                escape(&row.day),
                escape(&row.link)
            );
            continue;
        }
        for (column, picks) in &columns {
            let _ = write!(body, "<td data-col=\"{}\">", escape(column));
            for &i in picks {
                let bars = &row.cells[i];
                let point = point_of(&PICKS[i]);
                let map = match &PICKS[i].cell {
                    Cell::Hashing { use_case, .. } => {
                        format!(
                            "{}/bench-hashes.map.html#{}",
                            row.link,
                            super::map::cell_key("solo", *use_case)
                        )
                    }
                    Cell::B3sum { .. } => {
                        format!("{}/bench-hashes.map.html#1:solo|tree|cached", row.link)
                    }
                };
                let Some(_) = bars.first() else {
                    let _ = write!(
                        body,
                        "<div class=\"pick none\"><span class=\"pt\">{}</span>not in this run</div>",
                        escape(&point)
                    );
                    continue;
                };
                let fastest = bars.iter().map(|b| b.gbps).fold(0.0f64, f64::max);
                // Colour, name, the note, and GB/s as a number (last: never empty):
                // the script rounds and words it.
                let tip: Vec<String> = bars
                    .iter()
                    .map(|b| format!("{}\t{}\t{}\t{}", b.color, b.name, b.note, b.gbps))
                    .collect();
                let _ = write!(
                    body,
                    "<a class=\"pick\" href=\"{}\" data-head=\"{} · {} · {}\" data-tip=\"{}\"><span class=\"pt\">{}</span><span class=\"chart\"><span class=\"bars\">",
                    escape(&map),
                    escape(&row.machine),
                    escape(column),
                    escape(&point),
                    escape(&tip.join("\n")),
                    escape(&point)
                );
                for (n, b) in bars.iter().enumerate() {
                    let _ = write!(
                        body,
                        "<span class=\"bar\"><i data-c=\"{}\" data-g=\"{}\" style=\"width:{}%;background:{}\"{}></i>{}</span>",
                        b.color,
                        b.gbps,
                        (100.0 * b.gbps / fastest).round(),
                        b.color,
                        "",
                        ""
                    );
                    let _ = n;
                }
                let _ = write!(
                    body,
                    "</span><span class=\"under\"><em class=\"mult\"></em><span class=\"scale\">{}</span></span></span></a>",
                    escape(&speed(fastest))
                );
            }
            body.push_str("</td>");
        }
        body.push_str("</tr>\n");
    }
    body.push_str("</tbody></table></div>\n");
    include_str!("overview.html")
        .replace("@RIBBONS@", &ribbons(rows))
        .replace("@LEGEND@", &legend)
        .replace("@BODY@", &body)
}

/// The rows of the results directories under `results`, in the order they
/// are named (so the page is the same from any shell), linked from `base`'s
/// directory. A machine whose last run is another release's gets a row
/// with no cells (its samples are its release's to read), so one page
/// shows one release's cells and names every machine.
pub fn rows(results: &Path, base: &Path) -> Vec<Row> {
    let dirs = results_dirs(results);
    assert!(
        !dirs.is_empty(),
        "{} holds no results directory with a samples file",
        results.display()
    );
    let rows: Vec<Row> = dirs
        .iter()
        .map(|dir| {
            let link = dir
                .strip_prefix(base)
                .unwrap_or(dir)
                .to_str()
                .expect("a path in UTF-8")
                .to_owned();
            row(dir, link)
        })
        .collect();
    rows
}

/// The results directories under `results` that hold a samples file, in
/// name order.
fn results_dirs(results: &Path) -> Vec<std::path::PathBuf> {
    let mut dirs: Vec<_> = std::fs::read_dir(results)
        .unwrap_or_else(|e| panic!("cannot read {}: {e}", results.display()))
        .map(|entry| entry.expect("a directory entry").path())
        .filter(|p| {
            p.join("bench-hashes.samples.tsv").exists() || p.join("b3sum.samples.tsv").exists()
        })
        .collect();
    dirs.sort();
    dirs
}

/// After a run into `directory` (`benchmark-results/<machine>`): redraw
/// the overview beside it, `index.html` in the directory above the
/// results, so a run keeps the front page current. A machine whose last
/// run is another release's keeps its row, with its map and a note that
/// a run under this release is awaited, and no cells.
pub fn refresh(directory: &Path) {
    let Some(results) = directory.parent().filter(|p| !p.as_os_str().is_empty()) else {
        return;
    };
    let base = results.parent().unwrap_or(Path::new(""));
    let index = base.join("index.html");
    if !index.exists() {
        return;
    }
    let rows: Vec<Row> = results_dirs(results)
        .iter()
        .map(|dir| {
            row(
                dir,
                dir.strip_prefix(base)
                    .unwrap_or(dir)
                    .to_str()
                    .expect("a path in UTF-8")
                    .to_owned(),
            )
        })
        .collect();
    std::fs::write(&index, html(&rows))
        .unwrap_or_else(|e| panic!("cannot write {}: {e}", index.display()));
    println!("# Overview (HTML) is in \"{}\" .", index.display());
}

/// `bench-hashes overview OUT.html RESULTS`: write the page from every
/// results directory under RESULTS (`benchmark-results`), and print its
/// text. The test the_index_is_the_overview_of_the_published_runs keeps
/// the repository's index.html equal to this command's output.
pub fn command(args: &[String]) {
    let usage =
        "usage: bench-hashes overview OUT.html RESULTS (the directory of results directories)";
    let [out, results] = args else {
        panic!("{usage}")
    };
    let (out, results) = (Path::new(out), Path::new(results));
    let base = out.parent().unwrap_or(Path::new(""));
    let rows = rows(results, base);
    std::fs::write(out, html(&rows))
        .unwrap_or_else(|e| panic!("cannot write {}: {e}", out.display()));
    print!("{}", text(&rows));
    println!("# Overview (HTML) is in \"{}\" .", out.display());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_speed_is_bytes_over_the_shared_rule_s_mean() {
        // Each cell's mean is the shared rule's (clocks::summary::mean), the
        // map's: total time over total work, every sample counted. 1500 ns
        // over 500 bytes twice is 3 ns/B, 0.333 GB/s; 600 and 400 over 500
        // each is 1 ns/B, 1 GB/s. Independently fixed.
        let theirs = [Measured::new(1500, 500), Measured::new(1500, 500)];
        let ours = [Measured::new(600, 500), Measured::new(400, 500)];
        assert!((gbps(&theirs, 1.0) - 1.0 / 3.0).abs() < 1e-12);
        assert_eq!(gbps(&ours, 1.0), 1.0);
        // A batch's unit is a message of 64 bytes: 64 ns a message is 1 GB/s.
        assert_eq!(gbps(&[Measured::new(6400, 100)], 64.0), 1.0);
    }

    #[test]
    fn figures_read_as_the_page_says_them() {
        assert_eq!(figure(0.925), "0.9×");
        assert_eq!(figure(1.0), "1.0×");
        assert_eq!(figure(9.96), "10.0×");
        assert_eq!(figure(12.4), "12×");
        assert_eq!(speed(0.1234), "0.12 GB/s");
        assert_eq!(speed(0.06834), "0.068 GB/s");
        assert_eq!(speed(3.61), "3.6 GB/s");
        assert_eq!(speed(23.46), "23 GB/s");
        assert_eq!(speed(159.4), "159 GB/s");
    }

    #[test]
    fn vendor_strings_lose_their_trademarks_generations_and_core_counts() {
        assert_eq!(
            short_name("12th Gen Intel(R) Core(TM) i7-12700K"),
            "Intel Core i7-12700K"
        );
        assert_eq!(
            short_name("AMD EPYC 9654 96-Core Processor"),
            "AMD EPYC 9654"
        );
        assert_eq!(
            short_name("AMD EPYC 9255 24-Core Processor"),
            "AMD EPYC 9255"
        );
        assert_eq!(short_name("Apple M4 Max"), "Apple M4 Max");
        assert_eq!(
            short_name("Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz"),
            "Intel Xeon E5-2680 v4 @ 2.40GHz"
        );
    }

    fn row(machine: &str, vm: bool, cells: Vec<Bars>) -> Row {
        Row {
            machine: machine.to_owned(),
            cpus: "8".to_owned(),
            os: "Linux".to_owned(),
            day: "2026-10-22".to_owned(),
            fork: "abc1234".to_owned(),
            version: "0.17.0".to_owned(),
            virtual_machine: vm,
            link: "benchmark-results/x".to_owned(),
            cells,
            curves: Vec::new(),
            stale: false,
        }
    }

    fn bar(name: &str, color: &'static str, gbps: f64, note: &'static str) -> Bar {
        Bar {
            name: name.to_owned(),
            color,
            gbps,
            note,
        }
    }

    #[test]
    fn the_page_draws_bars_in_proportion_and_a_legend_of_what_it_drew() {
        let mut cells: Vec<Bars> = PICKS.iter().map(|_| Vec::new()).collect();
        // Servil 0.9× official (official fills the width), 1.2× SHA-256.
        cells[0] = vec![
            bar("BLAKE3 servil st", "#7c3aed", 0.9, ""),
            bar("BLAKE3 official", "#3b82f6", 1.0, ""),
            bar("SHA-256", "#e07a45", 0.75, ""),
        ];
        cells[3] = vec![
            bar("BLAKE3 servil mt", "#4c1d95", 12.0, ""),
            bar(
                "BLAKE3 official",
                "#3b82f6",
                1.0,
                "official on one thread: this run lacks its multithreaded form",
            ),
        ];
        cells[6] = vec![
            bar("b3sum, BLAKE3 servil's", "#4c1d95", 30.0, ""),
            bar("b3sum, official BLAKE3's", "#3b82f6", 10.0, ""),
            bar("md5sum", "#cfcbc3", 1.5, ""),
        ];
        let vm = row("virt", true, PICKS.iter().map(|_| Vec::new()).collect());
        let rows = [row("A", false, cells), vm];
        let page = html(&rows);
        assert!(
            page.contains("width:90%;background:#7c3aed"),
            "servil's bar in proportion to the fastest"
        );
        assert!(
            page.contains("width:100%;background:#3b82f6"),
            "the fastest fills the width"
        );
        assert!(page.contains("width:75%;background:#e07a45"));
        assert!(
            page.contains("<span class=\"scale\">1.0 GB/s</span>"),
            "the fastest's speed is the scale"
        );
        assert!(
            page.contains("<tr class=\"vm\""),
            "a virtual machine's row is marked"
        );
        // The legend: one button a colour, servil first, b3sum's sharing.
        let legend: Vec<&str> = page
            .split("<button style=\"--c:")
            .skip(1)
            .map(|s| &s[..s.find('"').unwrap()])
            .collect();
        assert_eq!(
            legend,
            ["#7c3aed", "#4c1d95", "#3b82f6", "#e07a45", "#cfcbc3"]
        );
        assert!(text(&rows).contains(
            "files, 1000 files:                 30 GB/s b3sum, BLAKE3 servil's; 10 GB/s b3sum, official BLAKE3's (3.0×); 1.5 GB/s md5sum (20×)"
        ));
    }

    /// The front page is the command's output for the published runs, so it
    /// cannot drift from the data: a new or redrawn run means
    /// `bench-hashes overview index.html benchmark-results`.
    #[test]
    fn the_index_is_the_overview_of_the_published_runs() {
        let root = Path::new(env!("CARGO_MANIFEST_DIR"));
        let want = html(&rows(&root.join("benchmark-results"), root));
        let have = std::fs::read_to_string(root.join("index.html")).expect("index.html");
        assert!(
            have == want,
            "index.html is stale: run `bench-hashes overview index.html benchmark-results`"
        );
    }

    /// A run redraws the overview above its results directory, and leaves
    /// a machine's row without cells where its run is another release's.
    #[test]
    fn a_run_refreshes_the_overview_above_its_results() {
        let root = Path::new(env!("CARGO_MANIFEST_DIR"));
        let site = std::env::temp_dir().join(format!("overview-refresh-{}", std::process::id()));
        let results = site.join("benchmark-results");
        std::fs::create_dir_all(&results).unwrap();
        let mut copied = Vec::new();
        for dir in results_dirs(&root.join("benchmark-results")) {
            let to = results.join(dir.file_name().unwrap());
            std::fs::create_dir(&to).unwrap();
            for file in ["bench-hashes.samples.tsv", "b3sum.samples.tsv"] {
                if dir.join(file).exists() {
                    std::fs::copy(dir.join(file), to.join(file)).unwrap();
                }
            }
            copied.push(to);
        }
        std::fs::write(site.join("index.html"), "stale").unwrap();
        refresh(&copied[0]);
        let drawn = std::fs::read_to_string(site.join("index.html")).unwrap();
        assert_eq!(
            drawn,
            html(&rows(&results, &site)),
            "the page above the results is redrawn"
        );
        // Another release among the results: its machine keeps a row
        // that says so, with its map, and no cells.
        let samples = copied[0].join("bench-hashes.samples.tsv");
        let text = std::fs::read_to_string(&samples)
            .unwrap()
            .replace(SAMPLES_VERSION, "# bench-hashes samples v0");
        std::fs::write(&samples, text).unwrap();
        refresh(&copied[0]);
        let drawn = std::fs::read_to_string(site.join("index.html")).unwrap();
        assert!(
            drawn.contains("a run under this release is awaited"),
            "the other release's machine is named, not drawn"
        );
        std::fs::remove_dir_all(&site).unwrap();
    }

    #[test]
    fn the_columns_group_picks_that_share_a_heading() {
        let columns = columns();
        assert_eq!(columns.len(), 6);
        assert_eq!(columns[0], ("small values", vec![0, 1]));
        assert_eq!(
            PICKS.len(),
            7,
            "the budget: six columns, at most eight cells"
        );
    }
}
