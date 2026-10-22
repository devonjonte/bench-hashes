//! `bench-hashes overview OUT.html DIR...`: one page above the maps. Each
//! row is a machine (one published results directory), each column one
//! representative measurement (FROZEN's "The overview"), and each cell the
//! ratio of a competitor's time to BLAKE3 servil's in that run: read across
//! a row for one machine, down a column for one use across machines. The
//! cells are read from the same samples files the maps are drawn from,
//! through the same reader and summary rule; every figure on the page is
//! computed here, none typed.

use super::{read_samples, Algorithm, Measured, SamplesFile, UseCase};
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
    ("official", "official b3sum", "#3b82f6"),
    ("sha256sum", "sha256sum", "#e07a45"),
    ("sha1sum", "sha1sum", "#8a7a1e"),
    ("md5sum", "md5sum", "#9ca3af"),
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
        name: a.name().to_owned(),
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
                    "official on one thread: this run lacks its multithreaded form",
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
        "BLAKE3 servil's b3sum",
        Algorithm::Blake3ServilMt.color(),
        ours,
    )];
    bars.extend(B3SUM_COMPETITORS.iter().filter_map(|(name, shown, color)| {
        cell(file, &key(name)).map(|theirs| bar(shown, color, theirs))
    }));
    bars
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
    let hashing = hashing
        .exists()
        .then(|| read_samples(hashing.to_str().expect("a path in UTF-8")));
    let b3sum = b3sum
        .exists()
        .then(|| read_samples(b3sum.to_str().expect("a path in UTF-8")));
    let about = hashing.as_ref().or(b3sum.as_ref()).unwrap_or_else(|| {
        panic!(
            "{} holds no samples file (bench-hashes.samples.tsv, b3sum.samples.tsv)",
            directory.display()
        )
    });
    let headers = &about.headers;
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

/// A speed as the page says it: three significant figures, as the map.
fn speed(gbps: f64) -> String {
    let digits = if gbps >= 100.0 {
        0
    } else if gbps >= 10.0 {
        1
    } else if gbps >= 1.0 {
        2
    } else if gbps >= 0.1 {
        3
    } else {
        4
    };
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
    let noted = rows
        .iter()
        .flat_map(|r| r.cells.iter().flatten())
        .any(|b| !b.note.is_empty());
    let mut legend = String::new();
    for (name, color) in &drawn {
        let _ = write!(
            legend,
            "<button style=\"--c:{color}\" data-c=\"{color}\">{}</button>",
            escape(name.split(" (").next().unwrap_or(name))
        );
        if noted && *color == Algorithm::Blake3.color() {
            let _ = write!(
                legend,
                "<button class=\"noted\" style=\"--c:{color}\" data-c=\"{color}\" data-noted=\"1\" title=\"That run has no multithreaded form of BLAKE3 official, so its one thread stands in where servil's cell uses threads.\">on one thread (that run lacks its threaded form)</button>"
            );
        }
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
        for (column, picks) in &columns {
            body.push_str("<td>");
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
                        if b.note.is_empty() { "" } else { " class=\"noted\"" },
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
        .replace("@LEGEND@", &legend)
        .replace("@BODY@", &body)
}

/// `bench-hashes overview OUT.html DIR...`: write the page from the results
/// directories, and print its text.
pub fn command(args: &[String]) {
    let usage =
        "usage: bench-hashes overview OUT.html DIR... (results directories, one per machine)";
    let [out, dirs @ ..] = args else {
        panic!("{usage}")
    };
    assert!(!dirs.is_empty(), "{usage}");
    let out = Path::new(out);
    let base = out.parent().unwrap_or(Path::new(""));
    let rows: Vec<Row> = dirs
        .iter()
        .map(|d| {
            let dir = Path::new(d);
            let link = dir
                .strip_prefix(base)
                .unwrap_or(dir)
                .to_str()
                .expect("a path in UTF-8")
                .trim_end_matches('/')
                .to_owned();
            row(dir, link)
        })
        .collect();
    let versions: Vec<&str> =
        rows.iter()
            .map(|r| r.version.as_str())
            .fold(Vec::new(), |mut v, x| {
                if !v.contains(&x) {
                    v.push(x);
                }
                v
            });
    assert!(
        versions.len() == 1,
        "the runs are of different benchmark releases ({}); the overview draws one release's runs, so their cells mean the same",
        versions.join(", ")
    );
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
        // map's, so the figure follows its selection: at these counts the
        // slowest sample of a cell goes. 1500 ns over 500 bytes is 3 ns/B,
        // 0.333 GB/s; 600 and 400 over 500 each: the 600 goes, 0.8 ns/B,
        // 1.25 GB/s. Independently fixed.
        let theirs = [Measured::new(1500, 500), Measured::new(1500, 500)];
        let ours = [Measured::new(600, 500), Measured::new(400, 500)];
        assert!((gbps(&theirs, 1.0) - 1.0 / 3.0).abs() < 1e-12);
        assert_eq!(gbps(&ours, 1.0), 1.25);
        // A batch's unit is a message of 64 bytes: 64 ns a message is 1 GB/s.
        assert_eq!(gbps(&[Measured::new(6400, 100)], 64.0), 1.0);
    }

    #[test]
    fn figures_read_as_the_page_says_them() {
        assert_eq!(figure(0.925), "0.9×");
        assert_eq!(figure(1.0), "1.0×");
        assert_eq!(figure(9.96), "10.0×");
        assert_eq!(figure(12.4), "12×");
        assert_eq!(speed(0.1234), "0.123 GB/s");
        assert_eq!(speed(0.06834), "0.0683 GB/s");
        assert_eq!(speed(23.46), "23.5 GB/s");
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
            bar("BLAKE3 servil's b3sum", "#4c1d95", 30.0, ""),
            bar("official b3sum", "#3b82f6", 10.0, ""),
            bar("md5sum", "#9ca3af", 1.5, ""),
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
            page.contains("<span class=\"scale\">1.00 GB/s</span>"),
            "the fastest's speed is the scale"
        );
        assert!(
            page.contains("class=\"noted\""),
            "a bar against a missing baseline is hatched"
        );
        assert!(
            page.contains("data-noted=\"1\""),
            "and the legend shows the hatching beside official's button"
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
            ["#7c3aed", "#4c1d95", "#3b82f6", "#e07a45", "#9ca3af"]
        );
        assert!(text(&rows).contains(
            "files, 1000 files:                 30.0 GB/s BLAKE3 servil's b3sum; 10.0 GB/s official b3sum (3.0×); 1.50 GB/s md5sum (20×)"
        ));
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
