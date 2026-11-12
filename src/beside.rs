//! `bench-hashes beside OUT --check KEPT --run DIR [--without NAME,...]`:
//! a results folder whose map draws BLAKE3-Servil as of the release before
//! beside this run's (map.rs's `--beside`: the earlier lines dashed, a chip
//! to hide them).
//!
//! Today's bench cannot build against a library whose calls have changed,
//! so the two versions come from a release check across benches (`check
//! --old-bench ... --keep KEPT`): its paired runs, run-*-old.tsv and
//! run-*-new.tsv, fresh link layouts, one after the other, the same sample
//! sizes. Each cell's samples from every run of a side are joined: the old
//! side's into OUT/before/, the new side's into OUT/ with the other
//! contenders' rows and the header of DIR's full run. One full run a
//! version would not do: a single link layout moved a 64 B cell by 25%
//! (November 10, 2026, data branch, maps-08-vs-today).
//!
//! `--without` leaves out the map's rows and columns named (map.rs's ids:
//! one, batch, long, merkle, many, coll; busy, brief, idle, controlled,
//! lent, piped, receiving), and `one-thread` or `every-core` the
//! contenders of that kind: a page for the calls one crate offers.

use std::path::{Path, PathBuf};

/// The columns that may hold a value a sample.
const LISTS: std::ops::Range<usize> = 5..11;

struct Run {
    headers: Vec<String>,
    rows: Vec<Vec<String>>,
}

fn read(path: &Path) -> Run {
    let text = std::fs::read_to_string(path).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    let mut lines = text.lines();
    assert_eq!(
        lines.next(),
        Some(crate::SAMPLES_VERSION),
        "{}: this release's samples format",
        path.display()
    );
    let (mut headers, mut rows) = (Vec::new(), Vec::new());
    for line in lines {
        if line.starts_with('#') {
            headers.push(line.to_owned());
        } else if line != crate::SAMPLES_COLUMNS {
            rows.push(line.split('\t').map(str::to_owned).collect());
        }
    }
    Run { headers, rows }
}

/// A side's runs joined: each cell once, in the first run's order, its
/// per-sample columns end to end. A column that holds one mark for the
/// whole cell (no CPU time, no energy) keeps the first run's.
fn joined(runs: &[Run]) -> Vec<Vec<String>> {
    let mut cells: Vec<Vec<String>> = Vec::new();
    let mut at: crate::Map<Vec<String>, usize> = crate::Map::default();
    for run in runs {
        for row in &run.rows {
            let Some(&i) = at.get(&row[..4]) else {
                at.insert(row[..4].to_vec(), cells.len());
                cells.push(row.clone());
                continue;
            };
            let samples = row[5].split(',').count();
            for column in LISTS {
                let (Some(more), Some(have)) = (row.get(column), cells[i].get_mut(column)) else {
                    continue;
                };
                let per_sample = more.split(',').count() == samples && (samples > 1 || column <= 6);
                if per_sample && !more.is_empty() {
                    have.push(',');
                    have.push_str(more);
                }
            }
        }
    }
    cells
}

/// Whether a row stays, given what the page leaves out.
fn kept(row: &[String], without: &[String]) -> bool {
    let (Some(algorithm), Some(use_case)) = (
        crate::Algorithm::ALL
            .into_iter()
            .find(|a| a.key() == row[0]),
        crate::UseCase::ALL
            .into_iter()
            .find(|u| format!("{u:?}") == row[2]),
    ) else {
        return false;
    };
    let (map_row, map_column) = crate::map::row_and_column(use_case);
    let kind = if algorithm.multithreaded() {
        "every-core"
    } else {
        "one-thread"
    };
    !without
        .iter()
        .any(|w| w == map_row || w == map_column || w == kind)
}

fn file(headers: &[String], rows: &[Vec<String>]) -> String {
    let mut out = vec![crate::SAMPLES_VERSION.to_owned()];
    out.extend(headers.iter().cloned());
    out.push(crate::SAMPLES_COLUMNS.to_owned());
    out.extend(rows.iter().map(|r| r.join("\t")));
    out.join("\n") + "\n"
}

/// The two samples files: the release before's, and this run's.
pub fn merge(
    full: &Path,
    old: &[PathBuf],
    new: &[PathBuf],
    without: &[String],
) -> (String, String) {
    assert!(
        !old.is_empty() && old.len() == new.len(),
        "a check's paired runs: as many old as new, one at least"
    );
    let full = read(full);
    let (old, new): (Vec<Run>, Vec<Run>) = (
        old.iter().map(|p| read(p)).collect(),
        new.iter().map(|p| read(p)).collect(),
    );
    let ours = |key: &str| key.starts_with("blake3-servil");
    let before: Vec<Vec<String>> = joined(&old)
        .into_iter()
        .filter(|r| ours(&r[0]) && kept(r, without))
        .collect();
    let mut now: Vec<Vec<String>> = joined(&new)
        .into_iter()
        .filter(|r| ours(&r[0]) && kept(r, without))
        .collect();
    now.extend(
        full.rows
            .iter()
            .filter(|r| !ours(&r[0]) && kept(r, without))
            .cloned(),
    );
    let note = format!(
        "# beside: BLAKE3-Servil's rows are a check's {} paired runs joined; the other contenders' are a full run's",
        old.len()
    );
    let mut headers = full.headers.clone();
    headers.push(note.clone());
    let mut old_headers = old[0].headers.clone();
    // A bench from before the `blake3-servil version` line names the
    // library on its source line alone ("blake3-servil VERSION ..."): the
    // release before is named by that version.
    if !old_headers
        .iter()
        .any(|h| h.starts_with("# blake3-servil version: "))
    {
        let version = old_headers
            .iter()
            .find_map(|h| h.strip_prefix("# source blake3-servil-st: blake3-servil "))
            .and_then(|s| s.split([' ', ';']).next());
        if let Some(version) = version {
            old_headers.push(format!("# blake3-servil version: {version}"));
        }
    }
    old_headers.push(note);
    (file(&old_headers, &before), file(&headers, &now))
}

pub fn command(arguments: &[String]) {
    let usage = "usage: bench-hashes beside OUT --check KEPT --run DIR [--without NAME,...]";
    let (mut out, mut run, mut check, mut without) = (None, None, None, Vec::new());
    let mut arguments = arguments.iter();
    while let Some(argument) = arguments.next() {
        let mut value = || {
            arguments
                .next()
                .unwrap_or_else(|| panic!("{argument} takes a value\n{usage}"))
                .clone()
        };
        match argument.as_str() {
            "--run" => run = Some(value()),
            "--check" => check = Some(value()),
            "--without" => without = value().split(',').map(str::to_owned).collect(),
            _ if out.is_none() && !argument.starts_with("--") => out = Some(argument.clone()),
            _ => panic!("{usage}"),
        }
    }
    let (out, run, check) = (
        PathBuf::from(out.expect(usage)),
        run.expect(usage),
        check.expect(usage),
    );
    let side = |suffix: &str| {
        let mut paths: Vec<PathBuf> = std::fs::read_dir(&check)
            .unwrap_or_else(|e| panic!("{check}: {e}"))
            .filter_map(|e| Some(e.ok()?.path()))
            .filter(|p| {
                p.file_name()
                    .and_then(|n| n.to_str())
                    .is_some_and(|n| n.starts_with("run-") && n.ends_with(suffix))
            })
            .collect();
        paths.sort();
        paths
    };
    let (before, now) = merge(
        &Path::new(&run).join("bench-hashes.samples.tsv"),
        &side("-old.tsv"),
        &side("-new.tsv"),
        &without,
    );
    std::fs::create_dir_all(out.join("before")).unwrap();
    std::fs::write(out.join("before/bench-hashes.samples.tsv"), before).unwrap();
    std::fs::write(out.join("bench-hashes.samples.tsv"), now).unwrap();
    crate::map::write(&out, Some(&out.join("before")));
    // This folder's map is the one with the release before beside it: the
    // overview links a folder's `bench-hashes.map.html`.
    std::fs::copy(
        out.join("bench-hashes.beside.map.html"),
        out.join("bench-hashes.map.html"),
    )
    .unwrap();
}

#[cfg(test)]
mod tests {
    use super::*;

    fn run(dir: &Path, name: &str, rows: &[&str]) -> PathBuf {
        let path = dir.join(name);
        let text = format!(
            "{}\n# bench-hashes version: test\n# load: quiet\n# power: mains power\n{}\n{}\n",
            crate::SAMPLES_VERSION,
            crate::SAMPLES_COLUMNS,
            rows.join("\n")
        );
        std::fs::write(&path, text).unwrap();
        path
    }

    /// A check's runs joined: a cell's samples end to end, its one-mark
    /// columns kept once; the old side's rows go to the release before's
    /// file, the other contenders come from the full run, and what the
    /// page leaves out is in neither.
    #[test]
    fn a_checks_runs_join_into_the_release_before_and_this_run() {
        let dir = std::env::temp_dir().join(format!("bench-beside-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(&dir).unwrap();
        let st = |ns: &str| {
            format!("blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t{ns}/64,{ns}/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0")
        };
        let mt = "blake3-servil-mt\tsolo\tOneMessage\t64 B\tB\t9/64,9/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0";
        let piped = "blake3-servil-st\tsolo\tContinuousMessages\t64 B\tB\t7/64,7/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0";
        let sha = "sha256\tsolo\tOneMessage\t64 B\tB\t500/64,500/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0";
        let old = [
            run(&dir, "run-001-old.tsv", &[&st("100"), mt, piped]),
            run(&dir, "run-004-old.tsv", &[&st("110"), mt, piped]),
        ];
        let new = [
            run(&dir, "run-002-new.tsv", &[&st("80"), mt, piped]),
            run(&dir, "run-003-new.tsv", &[&st("90"), mt, piped]),
        ];
        let full = run(&dir, "full.tsv", &[&st("999"), sha]);
        let (before, now) = merge(
            &full,
            &old,
            &new,
            &["every-core".to_owned(), "piped".to_owned()],
        );
        let rows = |text: &str| {
            text.lines()
                .filter(|l| !l.starts_with('#') && *l != crate::SAMPLES_COLUMNS)
                .map(str::to_owned)
                .collect::<Vec<_>>()
        };
        assert_eq!(
            rows(&before),
            ["blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t100/64,100/64,110/64,110/64\t1,2,1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0,0,0"],
            "the old side: one thread's one cell, two runs end to end"
        );
        let now = rows(&now);
        assert_eq!(
            now.len(),
            2,
            "this run: BLAKE3-Servil's cell from the check, SHA-256's from the full run: {now:?}"
        );
        assert!(
            now[0].contains("\t80/64,80/64,90/64,90/64\t"),
            "the check's new runs, not the full run's 999: {}",
            now[0]
        );
        assert!(now[1].starts_with("sha256\t"));
        std::fs::remove_dir_all(&dir).unwrap();
    }

    /// Runs of one sample each: the time and work columns still join end
    /// to end, and a later column's one entry, which nothing tells apart
    /// from a mark for the whole run, is kept once.
    #[test]
    fn one_sample_runs_join_their_times_and_keep_a_single_mark_once() {
        let row = |ns: u32| {
            format!("blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t{ns}/64\t1\t-\t-\t1:2:3:0:0:0:0:0:0:0\t0")
                .split('\t')
                .map(str::to_owned)
                .collect::<Vec<_>>()
        };
        let run = |ns: u32| Run {
            headers: Vec::new(),
            rows: vec![row(ns)],
        };
        let cells = joined(&[run(100), run(110)]);
        assert_eq!(cells.len(), 1);
        assert_eq!(cells[0][5], "100/64,110/64");
        assert_eq!(cells[0][6], "1,1");
        assert_eq!(cells[0][9], "1:2:3:0:0:0:0:0:0:0");
    }

    /// The release before is named by its version: a bench from before the
    /// version line gives it on its source line, and a bench that writes
    /// the line has it once.
    #[test]
    fn the_release_before_carries_its_version_once() {
        let dir = std::env::temp_dir().join(format!("bench-beside-version-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(&dir).unwrap();
        let st = "blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t100/64,100/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0";
        let with = |name: &str, header: &str| {
            let path = dir.join(name);
            std::fs::write(
                &path,
                format!(
                    "{}\n# bench-hashes version: test\n{header}\n{}\n{st}\n",
                    crate::SAMPLES_VERSION,
                    crate::SAMPLES_COLUMNS
                ),
            )
            .unwrap();
            path
        };
        let new = [with("run-002-new.tsv", "# load: quiet")];
        let full = with("full.tsv", "# load: quiet");
        let versions = |before: &str| {
            before
                .lines()
                .filter(|l| l.starts_with("# blake3-servil version: "))
                .map(str::to_owned)
                .collect::<Vec<_>>()
        };
        let old = [with(
            "run-001-old.tsv",
            "# source blake3-servil-st: blake3-servil 0.8.0+b3c5 (https://example); commit b5b9",
        )];
        assert_eq!(
            versions(&merge(&full, &old, &new, &[]).0),
            ["# blake3-servil version: 0.8.0+b3c5"],
            "from the source line"
        );
        let old = [with(
            "run-001-old.tsv",
            "# blake3-servil version: 0.9.0+dev.abc\n# source blake3-servil-st: blake3-servil 0.9.0 x",
        )];
        assert_eq!(
            versions(&merge(&full, &old, &new, &[]).0),
            ["# blake3-servil version: 0.9.0+dev.abc"],
            "its own line, once"
        );
        std::fs::remove_dir_all(&dir).unwrap();
    }

    /// The command end to end: OUT wherever it stands among the options,
    /// the check's runs chosen by their names (`run-*-old.tsv`,
    /// `run-*-new.tsv`: a neighbour that only ends alike, or only starts
    /// alike, is left alone), `--without` applied, both files and both
    /// maps written.
    #[test]
    fn the_command_reads_a_checks_folder_and_writes_the_page() {
        let dir = std::env::temp_dir().join(format!("bench-beside-command-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        let (kept, full, out) = (dir.join("kept"), dir.join("full"), dir.join("out"));
        std::fs::create_dir_all(&kept).unwrap();
        std::fs::create_dir_all(&full).unwrap();
        let st = |ns: &str| {
            format!("blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t{ns}/64,{ns}/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0")
        };
        let mt = "blake3-servil-mt\tsolo\tOneMessage\t64 B\tB\t9/64,9/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0";
        run(&kept, "run-001-old.tsv", &[&st("100"), mt]);
        run(&kept, "run-002-new.tsv", &[&st("80"), mt]);
        // Neither is a run of the check's: one only ends as the old side's do, one only starts as a run does.
        run(&kept, "notes-old.tsv", &[&st("5")]);
        run(&kept, "run-003-new.tsv.bak", &[&st("6")]);
        run(&full, "bench-hashes.samples.tsv", &[&st("999")]);
        let text = |p: &str| p.to_owned();
        command(&[
            text("--check"),
            kept.display().to_string(),
            out.display().to_string(),
            text("--without"),
            text("every-core"),
            text("--run"),
            full.display().to_string(),
        ]);
        let read = |p: &str| std::fs::read_to_string(out.join(p)).unwrap();
        let before = read("before/bench-hashes.samples.tsv");
        let now = read("bench-hashes.samples.tsv");
        assert!(
            before.contains("\t100/64,100/64\t") && !before.contains("\t5/64"),
            "{before}"
        );
        assert!(
            now.contains("\t80/64,80/64\t") && !now.contains("\t6/64"),
            "{now}"
        );
        assert!(
            !before.contains("blake3-servil-mt") && !now.contains("blake3-servil-mt"),
            "--without every-core"
        );
        assert!(out.join("bench-hashes.map.html").exists());
        std::fs::remove_dir_all(&dir).unwrap();
    }

    /// A whole, valid command's arguments over a fresh fixture, then
    /// `extra`: what the two tests below add must stop it by itself.
    fn valid_command_and(name: &str, extra: &[&str]) -> Vec<String> {
        let dir = std::env::temp_dir().join(format!("bench-beside-{name}-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        let (kept, full) = (dir.join("kept"), dir.join("full"));
        std::fs::create_dir_all(&kept).unwrap();
        std::fs::create_dir_all(&full).unwrap();
        let st = "blake3-servil-st\tsolo\tOneMessage\t64 B\tB\t100/64,100/64\t1,2\t-\t-\t1:2:3:0:0:0:0:0:0:0,1:2:3:0:0:0:0:0:0:0\t0,0";
        run(&kept, "run-001-old.tsv", &[st]);
        run(&kept, "run-002-new.tsv", &[st]);
        run(&full, "bench-hashes.samples.tsv", &[st]);
        let mut arguments = vec![
            "--check".to_owned(),
            kept.display().to_string(),
            "--run".to_owned(),
            full.display().to_string(),
        ];
        arguments.extend(
            extra
                .iter()
                .map(|a| a.replace("DIR", &dir.display().to_string())),
        );
        arguments
    }

    #[test]
    #[should_panic(expected = "usage: bench-hashes beside")]
    fn an_unknown_option_stops_with_the_usage() {
        command(&valid_command_and("unknown", &["--bogus", "DIR/out"]));
    }

    #[test]
    #[should_panic(expected = "usage: bench-hashes beside")]
    fn a_second_folder_stops_with_the_usage() {
        command(&valid_command_and("second", &["DIR/out", "DIR/another"]));
    }
}
