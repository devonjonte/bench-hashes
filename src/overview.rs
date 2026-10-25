//! `bench-hashes overview OUT.html DIR...`: one page above the maps. Each
//! row is a machine (one published results directory), each column one
//! representative measurement (FROZEN's "The overview"), and each cell the
//! ratio of a competitor's time to BLAKE3 servil's in that run: read across
//! a row for one machine, down a column for one use across machines. The
//! cells are read from the same samples files the maps are drawn from,
//! through the same reader and summary rule; every figure on the page is
//! computed here, none typed.

use super::{read_samples, Algorithm, Measured, SamplesFile, UseCase, SAMPLES_VERSION};
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
        column: "64 B",
        situation: "a key, an identifier, a small record, hashed between a program's other work",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "64 B", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "1 KiB",
        situation: "a small record, hashed between a program's other work",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "1 KiB", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "1 MiB, one thread",
        situation: "a buffer the size of a file, on the calling thread",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "1 MiB", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "128 MiB, every core",
        situation: "a download or a disk image, the library's threads at work",
        cell: Cell::Hashing { use_case: UseCase::OneMessage, point: "128 MiB", servil: Algorithm::Blake3ServilMt },
    },
    Pick {
        column: "a stream of 64 KiB messages",
        situation: "messages arriving one after another, as fast as the program can feed them; BLAKE3 servil's stream hashes them on its threads, the others on the calling thread",
        cell: Cell::Hashing { use_case: UseCase::ContinuousMessages, point: "64 KiB", servil: Algorithm::Blake3ServilMt },
    },
    Pick {
        column: "a batch of 1024 messages, 64 B each",
        situation: "a Merkle layer, a content-addressed store, a database's keys: 1024 messages of 64 bytes in one call",
        cell: Cell::Hashing { use_case: UseCase::ManyMessages, point: "1024", servil: Algorithm::Blake3ServilSt },
    },
    Pick {
        column: "1000 files, b3sum",
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
pub const FORK_B3SUM: [&str; 3] = ["b3sum", "devon", "fork"];
/// (run key, name shown, identity, colour, striped): b3sum's bars join
/// their library's multi-threaded form in the legend (b3sum hashes on
/// every core).
const B3SUM_COMPETITORS: [(&str, &str, &str, &str, bool); 4] = [
    (
        "official",
        "b3sum, official BLAKE3's",
        "blake3-official-mt",
        "#3b82f6",
        true,
    ),
    ("sha256sum", "sha256sum", "sha256", "#e07a45", false),
    // Drab greys: SHA-1 and MD5 are broken as cryptographic hashes
    // (collisions are cheap to make) and kept only as checksums people
    // still run; the page's door says so.
    ("sha1sum", "sha1sum", "sha1sum", "#b4b0a8", false),
    ("md5sum", "md5sum", "md5sum", "#cfcbc3", false),
];

/// One bar: a hash's speed in a cell.
pub struct Bar {
    pub name: String,
    /// Which hash it is, for the legend's buttons: a contender's key (a
    /// b3sum bar shares its library's multi-threaded form's).
    pub id: &'static str,
    /// The map's colour for it: its library's.
    pub color: &'static str,
    /// A library's multi-threaded form: its colour in stripes.
    pub striped: bool,
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
        id: a.key(),
        color: a.color(),
        striped: a.striped(),
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
        // Named plainly; which implementation it was is the tooltip's
        // (the page's door says it is the fastest measured on the machine).
        bars.push(Bar {
            name: "SHA-256".to_owned(),
            id: Algorithm::Sha256.key(),
            color: Algorithm::Sha256.color(),
            striped: false,
            gbps: gbps(theirs, per_unit),
            note: match a {
                Algorithm::Sha256 => "the sha2 crate",
                Algorithm::Sha256Ring => "ring's",
                _ => "CommonCrypto's",
            },
        });
    }
    bars
}

fn b3sum_bars(file: &SamplesFile, cache: &str, input: &str) -> Bars {
    let key = |name: &str| format!("{name}|{cache}|b3sum|{input}");
    // b3sum's samples are ns over the input's bytes.
    let bar = |name: &str, id, color, striped, samples| Bar {
        name: name.to_owned(),
        id,
        color,
        striped,
        gbps: gbps(samples, 1.0),
        note: "",
    };
    let Some(ours) = FORK_B3SUM.iter().find_map(|n| cell(file, &key(n))) else {
        return Vec::new();
    };
    let mut bars = vec![bar(
        "b3sum, BLAKE3 servil's",
        Algorithm::Blake3ServilMt.key(),
        Algorithm::Blake3ServilMt.color(),
        true,
        ours,
    )];
    bars.extend(
        B3SUM_COMPETITORS
            .iter()
            .filter_map(|(name, shown, id, color, striped)| {
                cell(file, &key(name)).map(|theirs| bar(shown, id, color, *striped, theirs))
            }),
    );
    bars
}

/// A bar's background: its colour, or a multi-threaded form's stripes of it.
fn paint(color: &str, striped: bool) -> String {
    if striped {
        format!("repeating-linear-gradient(135deg, {color} 0 3px, {color}73 3px 5px)")
    } else {
        color.to_owned()
    }
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
    described(&about.headers, link, cells, false)
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
        stale,
    }
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

/// The text with a non-breaking space between a number and its unit ("64 B",
/// "1 KiB"), so a row's name never wraps between the two.
fn units_kept(text: &str) -> String {
    let chars: Vec<char> = text.chars().collect();
    let mut out = String::with_capacity(text.len());
    for (i, &c) in chars.iter().enumerate() {
        let between = c == ' '
            && i > 0
            && chars[i - 1].is_ascii_digit()
            && chars.get(i + 1).is_some_and(|n| n.is_ascii_uppercase());
        if between {
            out.push_str("&nbsp;");
        } else {
            out.push(c);
        }
    }
    out
}

fn escape(text: &str) -> String {
    text.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
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
            let _ = writeln!(out, "  {:36} {line}", format!("{}:", pick.column));
        }
        out.push('\n');
    }
    out
}

/// The picks the first view draws: a short message (1 KiB on one thread,
/// between other work, where SHA-256 with the CPU's instructions leads)
/// inside the headline case (messages nonstop, 64 KiB each, every core),
/// so the view spans the range from where servil trails to where it
/// leads most (Zooko, October 24), by their index in PICKS.
const EVERYDAY: usize = 1;
const HEADLINE: usize = 4;

/// The first view: a row per machine, three bars (BLAKE3 servil, BLAKE3
/// official, the fastest SHA-256). A bar's full length is the headline
/// case, the darker part inside it the everyday case; log scale, one for
/// every machine, so bars compare across rows. No figure on the page; the
/// figures and the cells' names under the pointer.
fn families_by_machine(rows: &[Row]) -> String {
    let rows: Vec<&Row> = rows
        .iter()
        .filter(|r| {
            !r.stale
                && !r.virtual_machine
                && !r.cells[HEADLINE].is_empty()
                && !r.cells[EVERYDAY].is_empty()
        })
        .collect();
    if rows.is_empty() {
        return String::new();
    }
    // The families, in the bars' order: servil, official, SHA-256.
    let families = ["BLAKE3 servil", "BLAKE3 official", "SHA-256"];
    let all: Vec<f64> = rows
        .iter()
        .flat_map(|r| {
            r.cells[HEADLINE]
                .iter()
                .chain(&r.cells[EVERYDAY])
                .map(|b| b.gbps)
        })
        .collect();
    let lo_g = 10f64.powf(
        all.iter()
            .cloned()
            .fold(f64::INFINITY, f64::min)
            .log10()
            .floor(),
    );
    let hi_g = 10f64.powf(all.iter().cloned().fold(0.0, f64::max).log10().ceil());
    let width = |g: f64| 100.0 * (g.log10() - lo_g.log10()) / (hi_g.log10() - lo_g.log10());
    let mut out = String::from("<div class=\"families\">");
    for r in &rows {
        let _ = write!(
            out,
            "<div class=\"fam-row\"><div class=\"fam-machine\"><a href=\"{}/bench-hashes.map.html\"><b>{}</b></a><span>{} CPUs, {}</span></div><div class=\"fam-bars\">",
            escape(&r.link),
            escape(&r.machine),
            escape(&r.cpus),
            escape(&r.os)
        );
        for (k, family) in families.iter().enumerate() {
            let (Some(top), Some(inner)) = (r.cells[HEADLINE].get(k), r.cells[EVERYDAY].get(k))
            else {
                continue;
            };
            let color = inner.color;
            // Each part answers to its own form's button: the full bar to
            // the every-core form's, the inner part to the one-thread form's.
            let (hi_id, lo_id) = (top.id, inner.id);
            let (hi_paint, lo_paint) = (
                paint(top.color, top.striped),
                paint(inner.color, inner.striped),
            );
            let _ = write!(
                out,
                "<div class=\"fam-bar\" data-color=\"{color}\" data-head=\"{} · {}\" data-tip=\"{color}\t{}\t{}: {}\t{}\t{}: {}\"><i class=\"hi\" data-k=\"{hi_id}\" data-g=\"{}\" style=\"width:{:.1}%;background:{hi_paint}\"></i><i class=\"lo\" data-k=\"{lo_id}\" data-g=\"{}\" style=\"width:{:.1}%;background:{lo_paint}\"></i></div>",
                escape(&r.machine),
                escape(family),
                top.gbps,
                escape(&top.name),
                escape(PICKS[HEADLINE].situation),
                inner.gbps,
                escape(&inner.name),
                escape(PICKS[EVERYDAY].situation),
                top.gbps,
                width(top.gbps),
                inner.gbps,
                width(inner.gbps)
            );
        }
        out.push_str("</div></div>");
    }
    out.push_str("<div class=\"fam-row fam-scale\"><div class=\"fam-machine\"></div><div class=\"fam-bars\">");
    let mut e = lo_g.log10() as i32;
    while 10f64.powi(e) <= hi_g {
        let g = 10f64.powi(e);
        let _ = write!(
            out,
            "<span style=\"left:{:.1}%\">{}</span>",
            width(g),
            speed(g)
        );
        e += 1;
    }
    out.push_str("</div></div></div>");
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
    // The legend: one button a hash, named for its first bar (b3sum's
    // bars join their library's multi-threaded form; the tooltip names
    // each bar exactly), in its bar's paint. A button hides or shows every
    // bar of its hash.
    let mut drawn: Vec<(&str, &str, &str, bool)> = Vec::new();
    for b in rows.iter().flat_map(|r| r.cells.iter().flatten()) {
        if !drawn.iter().any(|(_, id, _, _)| *id == b.id) {
            drawn.push((&b.name, b.id, b.color, b.striped));
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
    let rank = |id: &str| {
        order
            .iter()
            .position(|a| a.key() == id)
            .unwrap_or(usize::MAX)
    };
    drawn.sort_by_key(|(_, id, _, _)| rank(id));
    // A library's two forms, single- and multi-threaded, stand one above
    // the other: they are one contender in two forms, which SHA-256 is
    // related to in neither (Zooko, October 23).
    let pairs = [
        (Algorithm::Blake3ServilSt, Algorithm::Blake3ServilMt),
        (Algorithm::Blake3, Algorithm::Blake3Rayon),
    ];
    let button = |name: &str, id: &str, color: &str, striped: bool| {
        format!(
            "<button style=\"--c:{}\" data-k=\"{id}\">{}</button>",
            paint(color, striped),
            escape(name.split(" (").next().unwrap_or(name))
        )
    };
    let mut legend = String::new();
    let mut done: Vec<&str> = Vec::new();
    for (name, id, color, striped) in &drawn {
        if done.contains(id) {
            continue;
        }
        match pairs.iter().find(|(a, b)| a.key() == *id || b.key() == *id) {
            Some((a, b)) => {
                legend.push_str("<span class=\"pair\">");
                for form in [a, b] {
                    if let Some((n, k, c, st)) = drawn.iter().find(|(_, k, _, _)| *k == form.key())
                    {
                        legend.push_str(&button(n, k, c, *st));
                        done.push(k);
                    }
                }
                legend.push_str("</span>");
            }
            None => {
                legend.push_str(&button(name, id, color, *striped));
                done.push(id);
            }
        }
    }
    // Each cell on its own linear scale: its fastest bar fills the width,
    // the others in proportion, so every cell shows its contest at full
    // resolution and the bracket gives the factor (Zooko, October 24).
    // The grid, turned: a column per machine, a row per use case, so a
    // glance across a row compares machines. Machines of another release
    // get a column that names their last run and links its map.
    let mut body = String::new();
    body.push_str("<div class=\"grid\"><table><thead><tr><th class=\"situation\"></th>");
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
            "<th{class} data-arch=\"{arch}\"><a href=\"{}/bench-hashes.map.html\"><b>{}{}</b></a><span>{} CPUs, {} · {}</span><span>BLAKE3 servil {} · bench-hashes {}</span>{}</th>",
            escape(&row.link),
            if row.virtual_machine { "VM on " } else { "" },
            escape(&row.machine),
            escape(&row.cpus),
            escape(&row.os),
            escape(&row.day),
            escape(&row.fork),
            escape(&row.version),
            if row.stale { "<span class=\"stale\">that release's run is on its map; a run under this release is awaited</span>" } else { "" }
        );
    }
    body.push_str("</tr></thead><tbody>\n");
    for (i, pick) in PICKS.iter().enumerate() {
        {
            let column = pick.column;
            let _ = write!(
                body,
                "<tr><td class=\"situation\" title=\"{}\">{}</td>",
                escape(pick.situation),
                units_kept(&escape(column))
            );
            for row in rows {
                let class = if row.virtual_machine {
                    " class=\"vm\""
                } else {
                    ""
                };
                if row.stale {
                    let _ = write!(body, "<td{class}></td>");
                    continue;
                }
                let bars = &row.cells[i];
                let fastest = bars.iter().map(|b| b.gbps).fold(0.0f64, f64::max);
                let width = |g: f64| {
                    if fastest > 0.0 {
                        100.0 * g / fastest
                    } else {
                        0.0
                    }
                };
                let map = match &PICKS[i].cell {
                    Cell::Hashing { use_case, .. } => format!(
                        "{}/bench-hashes.map.html#{}",
                        row.link,
                        super::map::cell_key("solo", *use_case)
                    ),
                    Cell::B3sum { .. } => {
                        format!("{}/bench-hashes.map.html#1:solo|tree|cached", row.link)
                    }
                };
                if bars.is_empty() {
                    let _ = write!(
                        body,
                        "<td{class}><div class=\"pick none\">not in this run</div></td>"
                    );
                    continue;
                }
                let tip: Vec<String> = bars
                    .iter()
                    .map(|b| {
                        format!(
                            "{}\t{}\t{}\t{}",
                            paint(b.color, b.striped),
                            b.name,
                            b.note,
                            b.gbps
                        )
                    })
                    .collect();
                let _ = write!(
                    body,
                    "<td{class}><a class=\"pick\" href=\"{}\" data-head=\"{} · {}\" data-tip=\"{}\"><span class=\"bars\">",
                    escape(&map),
                    escape(&row.machine),
                    escape(column),

                    escape(&tip.join("\n"))
                );
                for b in bars {
                    let _ = write!(
                        body,
                        "<span class=\"bar\"><i data-k=\"{}\" data-color=\"{}\" data-g=\"{}\" style=\"width:{:.1}%;background:{}\"></i></span>",
                        b.id,
                        b.color,
                        b.gbps,
                        width(b.gbps),
                        paint(b.color, b.striped)
                    );
                }
                // The scale: the speed the full width stands for, under its end.
                let _ = write!(
                    body,
                    "</span><span class=\"scale\">{}</span></a></td>",
                    speed(fastest)
                );
            }
            body.push_str("</tr>\n");
        }
    }
    body.push_str("</tbody></table></div>\n");
    include_str!("overview.html")
        .replace("@FAMILIES@", &families_by_machine(rows))
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
    // The page is HTML, and its text is printed on every run: a first
    // argument that is no .html file (\"--text\", say) is a mistake, which
    // once wrote the page into a file named after it.
    assert!(out.ends_with(".html"), "{usage}: {out:?} is no .html file");
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
    fn a_number_keeps_its_unit_on_one_line() {
        assert_eq!(
            units_kept("a batch of 1024 messages, 64 B each"),
            "a batch of 1024 messages, 64&nbsp;B each"
        );
        assert_eq!(
            units_kept("128 MiB, every core"),
            "128&nbsp;MiB, every core"
        );
        assert_eq!(units_kept("1000 files, b3sum"), "1000 files, b3sum");
    }

    #[test]
    #[should_panic(expected = "is no .html file")]
    fn the_command_takes_an_html_file_to_write() {
        command(&["--text".to_owned(), "benchmark-results".to_owned()]);
    }

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
            stale: false,
        }
    }

    /// A bar as the page's readers make it: its hash's key, colour and
    /// pattern from its name (b3sum's bars join their library's
    /// multi-threaded form).
    fn bar(name: &str, gbps: f64, note: &'static str) -> Bar {
        let (a, id) = match name {
            "BLAKE3 servil st" => (Algorithm::Blake3ServilSt, Algorithm::Blake3ServilSt.key()),
            "BLAKE3 servil mt" | "b3sum, BLAKE3 servil's" => {
                (Algorithm::Blake3ServilMt, Algorithm::Blake3ServilMt.key())
            }
            "BLAKE3 official" => (Algorithm::Blake3, Algorithm::Blake3.key()),
            "b3sum, official BLAKE3's" => (Algorithm::Blake3Rayon, Algorithm::Blake3Rayon.key()),
            "SHA-256" => (Algorithm::Sha256, Algorithm::Sha256.key()),
            "md5sum" => {
                return Bar {
                    name: name.to_owned(),
                    id: "md5sum",
                    color: "#cfcbc3",
                    striped: false,
                    gbps,
                    note,
                };
            }
            other => panic!("no test bar named {other}"),
        };
        Bar {
            name: name.to_owned(),
            id,
            color: a.color(),
            striped: a.striped(),
            gbps,
            note,
        }
    }

    #[test]
    fn the_page_draws_bars_in_proportion_and_a_legend_of_what_it_drew() {
        let mut cells: Vec<Bars> = PICKS.iter().map(|_| Vec::new()).collect();
        // Servil 0.9× official (official fills the width), 1.2× SHA-256.
        cells[0] = vec![
            bar("BLAKE3 servil st", 0.9, ""),
            bar("BLAKE3 official", 1.0, ""),
            bar("SHA-256", 0.75, ""),
        ];
        cells[3] = vec![
            bar("BLAKE3 servil mt", 12.0, ""),
            bar(
                "BLAKE3 official",
                1.0,
                "official on one thread: this run lacks its multithreaded form",
            ),
        ];
        cells[6] = vec![
            bar("b3sum, BLAKE3 servil's", 30.0, ""),
            bar("b3sum, official BLAKE3's", 10.0, ""),
            bar("md5sum", 1.5, ""),
        ];
        let vm = row("virt", true, PICKS.iter().map(|_| Vec::new()).collect());
        let rows = [row("A", false, cells), vm];
        let page = html(&rows);
        // Each cell on its own linear scale: its fastest bar fills the width
        // (official's 1.0 GB/s in the first cell; servil's b3sum in the
        // last), the others in proportion.
        assert!(
            page.contains("width:90.0%;background:#7c3aed"),
            "servil's bar in proportion to the cell's fastest"
        );
        assert!(
            page.contains("width:100.0%;background:#3b82f6"),
            "the cell's fastest fills the width"
        );
        assert!(page.contains("width:75.0%;background:#e07a45"));
        assert!(
            page.contains("width:5.0%;background:#cfcbc3"),
            "md5sum's 1.5 of b3sum's 30"
        );
        assert!(
            page.contains("<th class=\"vm\""),
            "a virtual machine's column is marked"
        );
        // The legend: one button a colour, servil first, b3sum's sharing.
        let legend: Vec<&str> = page
            .split("<button style=\"--c:")
            .skip(1)
            .map(|s| &s[..s.find('"').unwrap()])
            .collect();
        // Each library's two forms in its one colour, the multi-threaded
        // striped; official's multi-threaded button is b3sum's bar's.
        assert_eq!(
            legend,
            [
                "#7c3aed".to_owned(),
                paint("#7c3aed", true),
                "#3b82f6".to_owned(),
                paint("#3b82f6", true),
                "#e07a45".to_owned(),
                "#cfcbc3".to_owned()
            ]
        );
        assert!(text(&rows).contains(
            "1000 files, b3sum:                   30 GB/s b3sum, BLAKE3 servil's; 10 GB/s b3sum, official BLAKE3's (3.0×); 1.5 GB/s md5sum (20×)"
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
        for file in ["bench-hashes.samples.tsv", "b3sum.samples.tsv"] {
            let samples = copied[0].join(file);
            if samples.exists() {
                let text = std::fs::read_to_string(&samples)
                    .unwrap()
                    .replace(SAMPLES_VERSION, "# bench-hashes samples v0");
                std::fs::write(&samples, text).unwrap();
            }
        }
        refresh(&copied[0]);
        let drawn = std::fs::read_to_string(site.join("index.html")).unwrap();
        assert!(
            drawn.contains("a run under this release is awaited"),
            "the other release's machine is named, not drawn"
        );
        std::fs::remove_dir_all(&site).unwrap();
    }

    #[test]
    fn the_picks_keep_to_the_budget() {
        assert_eq!(PICKS.len(), 7, "the budget: at most eight cells");
        let mut labels: Vec<&str> = PICKS.iter().map(|p| p.column).collect();
        labels.dedup();
        assert_eq!(labels.len(), PICKS.len(), "each row its own label");
    }
}
