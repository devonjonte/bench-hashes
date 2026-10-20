//! Two charts drawn from a run's samples files, as bars in GB/s, for the
//! READMEs: `bench-hashes.chart.svg`, one 128 MiB message after a pause,
//! BLAKE3 servil multi-core and on one core beside the fastest of each other
//! family; and `b3sum.chart.svg`, the mixed tree of files in the page
//! cache, `b3sum` beside the system's `sha256sum`, `sha1sum` and `md5sum`.
//! A full run draws its chart; `bench-hashes chart SAMPLES.tsv` draws one
//! from a stored file.

use super::{read_samples, Mean, SamplesFile};
use std::fmt::Write as _;

const BLAKE3_COLOR: &str = "#7c3aed";
const WIDTH: f64 = 720.0;
const LEFT: f64 = 170.0;
const BAR: f64 = 26.0;
const GAP: f64 = 10.0;
const PLOT: f64 = WIDTH - LEFT - 100.0;
const FONT: &str = "-apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif";

/// One bar: its name, its rate in hundredths of GB/s, its colour, and
/// whether it is ours (drawn bold).
struct Bar {
    name: String,
    centi: u128,
    color: &'static str,
    ours: bool,
}

/// The hashes' chart: one 128 MiB message, after a pause (a program that
/// hashes now and then). None when the file lacks BLAKE3 servil's cells
/// there (a quick run stops below 1 MiB).
pub fn from_samples(path: &str) -> Option<String> {
    const CELL: &str = "solo|IdleOneMessage|128 MiB";
    const FAMILIES: [(&str, &[&str], &str); 3] = [
        (
            "SHA-256",
            &["sha256", "sha256-ring", "sha256-cc"],
            "#c2410c",
        ),
        ("SHA3-256", &["sha3-256"], "#db2777"),
        ("SHA-1", &["sha1dc"], "#8a7a1e"),
    ];
    let file = read_samples(path);
    let centi = |key: &str| rate(&file, &format!("{key}|{CELL}"));
    let mut bars = vec![
        Bar {
            name: "BLAKE3, multi-core".into(),
            centi: centi("blake3-servil-mt")?,
            color: BLAKE3_COLOR,
            ours: true,
        },
        Bar {
            name: "BLAKE3, one core".into(),
            centi: centi("blake3-servil-st")?,
            color: BLAKE3_COLOR,
            ours: true,
        },
    ];
    for (family, members, color) in FAMILIES {
        if let Some(best) = members.iter().filter_map(|m| centi(m)).max() {
            bars.push(Bar {
                name: family.into(),
                centi: best,
                color,
                ours: false,
            });
        }
    }
    Some(draw(
        &file,
        "Hashing one 128 MiB message, after a pause",
        bars,
    ))
}

/// b3sum's chart: the mixed tree of 1000 files, in the page cache, b3sum
/// beside the system's sum programs. None when the run lacks that cell for
/// b3sum.
pub fn b3sum_from_samples(path: &str) -> Option<String> {
    const CELL: &str = "warm|b3sum|mixed tree, 1000 files, 74 MiB";
    const OTHERS: [(&str, &str); 3] = [
        ("sha256sum", "#c2410c"),
        ("sha1sum", "#8a7a1e"),
        ("md5sum", "#2563eb"),
    ];
    let file = read_samples(path);
    let centi = |key: &str| rate(&file, &format!("{key}|{CELL}"));
    let mut bars = vec![Bar {
        name: "b3sum".into(),
        centi: centi("devon").or_else(|| centi("fork"))?,
        color: BLAKE3_COLOR,
        ours: true,
    }];
    if let Some(c) = centi("devon-1-thread") {
        bars.push(Bar {
            name: "b3sum, one thread".into(),
            centi: c,
            color: BLAKE3_COLOR,
            ours: true,
        });
    }
    for (key, color) in OTHERS {
        if let Some(c) = centi(key) {
            bars.push(Bar {
                name: key.into(),
                centi: c,
                color,
                ours: false,
            });
        }
    }
    Some(draw(&file, "Hashing a tree of 1000 files", bars))
}

/// A cell's rate in hundredths of GB/s from its mean (ns per unit, Q64.64), rounded once.
fn rate(file: &SamplesFile, cell: &str) -> Option<u128> {
    let (_, samples) = file.cells.iter().find(|(k, _)| *k == cell)?;
    let mean = Mean::of(samples).fixed().0;
    Some(((100u128 << 64) + mean / 2) / mean)
}

fn draw(file: &SamplesFile, title: &str, mut bars: Vec<Bar>) -> String {
    let header = |key: &str| {
        file.headers
            .iter()
            .find(|(k, _)| k == key)
            .map(|(_, v)| v.as_str())
            .unwrap_or("?")
    };
    bars.sort_by(|a, b| b.centi.cmp(&a.centi));
    let date = header("timestamp")
        .split(' ')
        .next()
        .unwrap_or("?")
        .to_owned();
    let subtitle = "faster to the right".to_owned();
    let footer = format!(
        "{}, {} CPUs · bench-hashes {} on {date}",
        header("cpu type"),
        header("cpu count"),
        header("bench-hashes version")
            .split('+')
            .next()
            .unwrap_or("?")
    );
    let top = bars[0].centi as f64;
    let head = 78.0;
    let height = head + bars.len() as f64 * (BAR + GAP) + 30.0;
    let mut svg = String::new();
    writeln!(svg, r#"<svg xmlns="http://www.w3.org/2000/svg" width="{WIDTH}" height="{height}" viewBox="0 0 {WIDTH} {height}" font-family="{FONT}">"#).unwrap();
    writeln!(
        svg,
        r##"<rect width="{WIDTH}" height="{height}" fill="#ffffff"/>"##
    )
    .unwrap();
    writeln!(svg, r##"<text x="{LEFT}" y="28" font-size="17" font-weight="600" fill="#111827">{title}</text>"##).unwrap();
    writeln!(
        svg,
        r##"<text x="{LEFT}" y="50" font-size="13" fill="#4b5563">{}</text>"##,
        super::xml_escape(&subtitle)
    )
    .unwrap();
    for (i, bar) in bars.iter().enumerate() {
        let y = head + i as f64 * (BAR + GAP);
        let w = PLOT * bar.centi as f64 / top;
        let weight = if bar.ours {
            r#" font-weight="600""#
        } else {
            ""
        };
        let ty = y + BAR * 0.68;
        let shown = if bar.centi >= 1000 {
            format!("{} GB/s", (bar.centi + 50) / 100)
        } else {
            format!("{}.{:02} GB/s", bar.centi / 100, bar.centi % 100)
        };
        writeln!(svg, r##"<text x="{}" y="{ty:.1}" font-size="13" fill="#111827" text-anchor="end"{weight}>{}</text>"##, LEFT - 10.0, super::xml_escape(&bar.name)).unwrap();
        writeln!(
            svg,
            r#"<rect x="{LEFT}" y="{y}" width="{w:.1}" height="{BAR}" rx="3" fill="{}"/>"#,
            bar.color
        )
        .unwrap();
        writeln!(
            svg,
            r##"<text x="{:.1}" y="{ty:.1}" font-size="13" fill="#111827"{weight}>{shown}</text>"##,
            LEFT + w + 6.0
        )
        .unwrap();
    }
    writeln!(
        svg,
        r##"<text x="{LEFT}" y="{:.1}" font-size="11" fill="#9a9a9a">{}</text>"##,
        height - 12.0,
        super::xml_escape(&footer)
    )
    .unwrap();
    svg.push_str("</svg>\n");
    svg
}

/// `bench-hashes chart SAMPLES.tsv`: draw its chart beside the samples file
/// (bench-hashes.samples.tsv -> bench-hashes.chart.svg; b3sum.samples.tsv
/// -> b3sum.chart.svg).
pub fn command(args: &[String]) {
    let [path] = args else {
        panic!("usage: bench-hashes chart SAMPLES.tsv")
    };
    let b3sum = path.ends_with("b3sum.samples.tsv");
    let svg = if b3sum {
        b3sum_from_samples(path)
    } else {
        from_samples(path)
    }
    .unwrap_or_else(|| panic!("{path} holds no cells for its chart (a full run measures them)"));
    let out = std::path::Path::new(path).with_file_name(if b3sum {
        "b3sum.chart.svg"
    } else {
        "bench-hashes.chart.svg"
    });
    std::fs::write(&out, svg).unwrap_or_else(|e| panic!("cannot write {}: {e}", out.display()));
    println!("# Speed chart (SVG) is in \"{}\" .", out.display());
}

#[cfg(test)]
mod tests {
    /// The chart from a samples file: 128 MiB in 10 ms is 13.42 GB/s
    /// (134217728 / 10000000 bytes a ns), drawn as "13"; in 40 ms, 3.36.
    #[test]
    fn bars_from_a_samples_file() {
        let path = std::env::temp_dir().join(format!(
            "bench-hashes-chart-{}.samples.tsv",
            std::process::id()
        ));
        let row = |key: &str, ns: u64| {
            format!("{key}\tsolo\tIdleOneMessage\t128 MiB\tB\t{ns}/134217728,{ns}/134217728\t1,2\t-\t-\t-\n")
        };
        let text = format!(
            "{}\n# timestamp: 2026-10-02 12:00:00 UTC\n# bench-hashes version: 0.13.0+abc\n# cpu type: Test CPU\n# cpu count: 4\n# power: n/a\n# load: quiet\n{}\n{}{}{}",
            super::super::SAMPLES_VERSION,
            super::super::SAMPLES_COLUMNS,
            row("blake3-servil-mt", 10_000_000),
            row("blake3-servil-st", 40_000_000),
            row("sha256", 80_000_000)
        );
        std::fs::write(&path, text).unwrap();
        let svg = super::from_samples(path.to_str().unwrap()).expect("a chart");
        std::fs::remove_file(&path).unwrap();
        assert!(
            svg.contains(">BLAKE3, multi-core</text>") && svg.contains(">13 GB/s</text>"),
            "{svg}"
        );
        assert!(
            svg.contains(">3.36 GB/s</text>") && svg.contains(">1.68 GB/s</text>"),
            "{svg}"
        );
        assert!(
            svg.contains("Test CPU, 4 CPUs · bench-hashes 0.13.0 on 2026-10-02"),
            "{svg}"
        );
    }
}
