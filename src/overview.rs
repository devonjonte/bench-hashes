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
const B3SUM_COMPETITORS: [(&str, &str); 4] = [
    ("official", "official b3sum"),
    ("sha256sum", "sha256sum"),
    ("sha1sum", "sha1sum"),
    ("md5sum", "md5sum"),
];

/// A competitor's time over BLAKE3 servil's in one cell.
pub struct Ratio {
    pub competitor: String,
    /// Competitor ns per unit over servil's: above 1, servil is faster.
    pub ratio: f64,
    /// A note the figure carries, such as "official on one thread".
    pub note: &'static str,
}

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
    /// One entry per pick: its ratios, or none where the run lacks the cell.
    pub cells: Vec<Vec<Ratio>>,
}

fn mean_q64(samples: &[Measured]) -> u128 {
    clocks::summary::mean(samples.iter().map(|m| (m.ns, m.units)))
}

/// The ratio of two cells' means (competitor over servil), from the
/// shared rule's Q64.64 figures; floating point at the last step.
fn ratio_of(competitor: &[Measured], servil: &[Measured]) -> f64 {
    mean_q64(competitor) as f64 / mean_q64(servil) as f64
}

fn cell<'a>(file: &'a SamplesFile, key: &str) -> Option<&'a [Measured]> {
    file.cells
        .iter()
        .find(|(k, _)| k == key)
        .map(|(_, s)| s.as_slice())
}

fn hashing_ratios(
    file: &SamplesFile,
    use_case: UseCase,
    point: &str,
    servil: Algorithm,
) -> Vec<Ratio> {
    let key = |a: Algorithm| format!("{}|solo|{use_case:?}|{point}", a.key());
    let Some(ours) = cell(file, &key(servil)) else {
        return Vec::new();
    };
    let mut ratios = Vec::new();
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
        ratios.push(Ratio {
            competitor: a.name().to_owned(),
            ratio: ratio_of(theirs, ours),
            note,
        });
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
        ratios.push(Ratio {
            competitor: format!("{} (the fastest measured)", a.name()),
            ratio: ratio_of(theirs, ours),
            note: "",
        });
    }
    ratios
}

fn b3sum_ratios(file: &SamplesFile, cache: &str, input: &str) -> Vec<Ratio> {
    let key = |name: &str| format!("{name}|{cache}|b3sum|{input}");
    let Some(ours) = FORK_B3SUM.iter().find_map(|n| cell(file, &key(n))) else {
        return Vec::new();
    };
    B3SUM_COMPETITORS
        .iter()
        .filter_map(|(name, shown)| {
            cell(file, &key(name)).map(|theirs| Ratio {
                competitor: (*shown).to_owned(),
                ratio: ratio_of(theirs, ours),
                note: "",
            })
        })
        .collect()
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

fn header<'a>(headers: &'a [(String, String)], key: &str) -> &'a str {
    headers
        .iter()
        .find(|(k, _)| k == key)
        .map_or("", |(_, v)| v.as_str())
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
                .map_or(Vec::new(), |f| hashing_ratios(f, *use_case, point, *servil)),
            Cell::B3sum { cache, input } => b3sum
                .as_ref()
                .map_or(Vec::new(), |f| b3sum_ratios(f, cache, input)),
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

/// A ratio as the page prints it: two figures after the point below 10,
/// one above, as "1.6×" or "12×".
fn figure(ratio: f64) -> String {
    if ratio >= 10.0 {
        format!("{ratio:.0}×")
    } else {
        format!("{ratio:.2}×")
    }
}

/// The sentence above the grid, from the grid: machines counted (virtual
/// machines apart), and servil's range against each competitor family over
/// the cells shown, leaving out a figure against a baseline the run lacks
/// (the noted ones).
pub fn headline(rows: &[Row]) -> String {
    let shown: Vec<&Row> = rows.iter().filter(|r| !r.virtual_machine).collect();
    let range = |family: &dyn Fn(&str) -> bool| {
        let v: Vec<f64> = shown
            .iter()
            .flat_map(|r| r.cells.iter().flatten())
            .filter(|x| family(&x.competitor) && x.note.is_empty())
            .map(|x| x.ratio)
            .collect();
        (!v.is_empty()).then(|| {
            let (lo, hi) = v.iter().fold((f64::INFINITY, 0.0f64), |(lo, hi), &x| {
                (lo.min(x), hi.max(x))
            });
            (lo, hi, v.iter().filter(|&&x| x < 1.0).count())
        })
    };
    let phrase = |name: &str, r: Option<(f64, f64, usize)>| {
        r.map(|(lo, hi, slower)| {
            let mut s = format!("{} to {} the speed of {name}", figure(lo), figure(hi));
            if slower > 0 {
                let _ = write!(s, " (slower in {slower} of the cells shown)");
            }
            s
        })
    };
    let machines = shown.len();
    let parts: Vec<String> = [
        phrase(
            "BLAKE3 official",
            range(&|c| c.starts_with("BLAKE3 official") || c == "official b3sum"),
        ),
        phrase(
            "SHA-256",
            range(&|c| c.starts_with("SHA-256") || c == "sha256sum"),
        ),
    ]
    .into_iter()
    .flatten()
    .collect();
    if parts.is_empty() {
        return format!("{machines} machines measured; no representative cell in their runs yet.");
    }
    format!(
        "On {machines} machine{}, BLAKE3 servil runs at {}.",
        if machines == 1 { "" } else { "s" },
        parts.join(", and ")
    )
}

fn escape(text: &str) -> String {
    text.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
}

/// The grid as text, for the terminal and the tests.
pub fn text(rows: &[Row]) -> String {
    let mut out = headline(rows);
    out.push('\n');
    for row in rows {
        let _ = writeln!(
            out,
            "\n{}{}, {} CPUs, {} · {} · bench-hashes {}, BLAKE3 servil {}",
            if row.virtual_machine { "(VM) " } else { "" },
            row.machine,
            row.cpus,
            row.os,
            row.day,
            row.version,
            row.fork
        );
        for (pick, ratios) in PICKS.iter().zip(&row.cells) {
            let point = match &pick.cell {
                Cell::Hashing { point, .. } => (*point).to_owned(),
                Cell::B3sum { input, .. } => (*input).to_owned(),
            };
            let cells: Vec<String> = ratios
                .iter()
                .map(|r| {
                    let note = if r.note.is_empty() {
                        String::new()
                    } else {
                        format!(" [{}]", r.note)
                    };
                    format!("{} vs {}{note}", figure(r.ratio), r.competitor)
                })
                .collect();
            let _ = writeln!(
                out,
                "  {:34} {}",
                format!("{}, {point}:", pick.column),
                if cells.is_empty() {
                    "not in this run".to_owned()
                } else {
                    cells.join("; ")
                }
            );
        }
    }
    out
}

/// The page.
pub fn html(rows: &[Row]) -> String {
    let columns = columns();
    let mut body = String::new();
    let _ = write!(
        body,
        "<p class=\"headline\">{}</p>\n",
        escape(&headline(rows))
    );
    body.push_str("<div class=\"grid\"><table><thead><tr><th class=\"machine\">machine</th>");
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
            "<tr{class} data-arch=\"{arch}\"><td class=\"machine\"><a href=\"{}/bench-hashes.map.html\"><b>{}{}</b></a><span>{} CPUs, {} · {} · BLAKE3 servil {} · bench-hashes {}</span></td>",
            escape(&row.link),
            if row.virtual_machine { "VM on " } else { "" },
            escape(&row.machine),
            escape(&row.cpus),
            escape(&row.os),
            escape(&row.day),
            escape(&row.fork),
            escape(&row.version)
        );
        for (_, picks) in &columns {
            body.push_str("<td>");
            for &i in picks {
                let ratios = &row.cells[i];
                let point = match &PICKS[i].cell {
                    Cell::Hashing { point, .. } => (*point).to_owned(),
                    Cell::B3sum { .. } => "tree".to_owned(),
                };
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
                if ratios.is_empty() {
                    let _ = write!(body, "<div class=\"pick\"><span class=\"pt\">{}</span><span class=\"none\">not in this run</span></div>", escape(&point));
                    continue;
                }
                // Two figures a line: a cell of four (files) takes two lines.
                let _ = write!(
                    body,
                    "<div class=\"pick\"><a class=\"pt\" href=\"{}\">{}</a>",
                    escape(&map),
                    escape(&point)
                );
                for (n, r) in ratios.iter().enumerate() {
                    if n > 0 && n % 2 == 0 {
                        body.push_str("</div><div class=\"pick\"><span class=\"pt\"></span>");
                    }
                    let side = if r.ratio >= 1.0 { "faster" } else { "slower" };
                    let title = format!(
                        "BLAKE3 servil's speed over {}{}",
                        r.competitor,
                        if r.note.is_empty() {
                            String::new()
                        } else {
                            format!("; {}", r.note)
                        }
                    );
                    let mark = if r.competitor.starts_with("BLAKE3 official")
                        || r.competitor == "official b3sum"
                    {
                        "b3"
                    } else if r.competitor.starts_with("SHA-256") || r.competitor == "sha256sum" {
                        "sha2"
                    } else {
                        "other"
                    };
                    let _ = write!(
                        body,
                        "<span class=\"r {side} {mark}\" title=\"{}\">{}{}</span>",
                        escape(&title),
                        figure(r.ratio),
                        if r.note.is_empty() { "" } else { "*" }
                    );
                }
                body.push_str("</div>");
            }
            body.push_str("</td>");
        }
        body.push_str("</tr>\n");
    }
    body.push_str("</tbody></table></div>\n");
    let notes: Vec<String> = rows
        .iter()
        .flat_map(|r| r.cells.iter().flatten())
        .filter(|x| !x.note.is_empty())
        .map(|x| x.note.to_owned())
        .fold(Vec::new(), |mut v, n| {
            if !v.contains(&n) {
                v.push(n);
            }
            v
        });
    if !notes.is_empty() {
        let _ = write!(
            body,
            "<p class=\"note\">* {}.</p>\n",
            escape(&notes.join("; "))
        );
    }
    include_str!("overview.html").replace("@BODY@", &body)
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
    println!("\n# Overview (HTML) is in \"{}\" .", out.display());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_ratio_is_the_competitor_mean_over_servil_s() {
        // Each side's mean is the shared rule's (clocks::summary::mean), the
        // map's, so the figure follows its selection: at these counts the
        // slowest sample of a cell goes. Theirs: 1500/500 = 3 ns a unit either
        // way; ours: 400/500 = 0.8 once the 600 goes. Independently fixed.
        let theirs = [Measured::new(1500, 500), Measured::new(1500, 500)];
        let ours = [Measured::new(600, 500), Measured::new(400, 500)];
        assert_eq!(ratio_of(&theirs, &ours), 3.75);
        assert_eq!(ratio_of(&theirs, &[Measured::new(1000, 1000)]), 3.0);
    }

    #[test]
    fn figures_read_as_the_page_prints_them() {
        assert_eq!(figure(0.925), "0.93×");
        assert_eq!(figure(1.0), "1.00×");
        assert_eq!(figure(9.994), "9.99×");
        assert_eq!(figure(12.4), "12×");
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
        assert_eq!(short_name("Apple M4 Max"), "Apple M4 Max");
        assert_eq!(
            short_name("Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz"),
            "Intel Xeon E5-2680 v4 @ 2.40GHz"
        );
    }

    fn row(machine: &str, vm: bool, cells: Vec<Vec<Ratio>>) -> Row {
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

    fn r(competitor: &str, ratio: f64, note: &'static str) -> Ratio {
        Ratio {
            competitor: competitor.to_owned(),
            ratio,
            note,
        }
    }

    #[test]
    fn the_headline_counts_machines_and_ranges_over_fair_cells() {
        let mut cells: Vec<Vec<Ratio>> = PICKS.iter().map(|_| Vec::new()).collect();
        cells[0] = vec![
            r("BLAKE3 official", 0.9, ""),
            r("SHA-256 (the fastest measured)", 1.2, ""),
        ];
        cells[3] = vec![
            r(
                "BLAKE3 official",
                12.0,
                "official on one thread: this run lacks its multithreaded form",
            ),
            r("SHA-256 (the fastest measured)", 8.0, ""),
        ];
        cells[6] = vec![
            r("official b3sum", 3.0, ""),
            r("sha256sum", 8.0, ""),
            r("md5sum", 19.0, ""),
        ];
        let vm = row(
            "virt",
            true,
            PICKS
                .iter()
                .map(|_| vec![r("BLAKE3 official", 100.0, "")])
                .collect(),
        );
        let rows = [row("A", false, cells), vm];
        assert_eq!(
            headline(&rows),
            "On 1 machine, BLAKE3 servil runs at 0.90× to 3.00× the speed of BLAKE3 official (slower in 1 of the cells shown), and 1.20× to 8.00× the speed of SHA-256."
        );
        let page = html(&rows);
        assert!(
            page.contains("class=\"r slower b3\""),
            "a figure below one is marked slower"
        );
        assert!(
            page.contains("12×*"),
            "a figure against a missing baseline carries its star"
        );
        assert!(
            page.contains("<tr class=\"vm\""),
            "a virtual machine's row is marked"
        );
        assert!(text(&rows).contains("files, mixed tree, 1000 files, 74 MiB: 3.00× vs official b3sum; 8.00× vs sha256sum; 19× vs md5sum"));
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
