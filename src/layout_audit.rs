//! EXPERIMENT ONLY: existing 64-pair second stages, grouped by their 16
//! reused layout pairs. Uses this producer-matched reader and judgment rule.
//! Grouping is a counterfactual analysis, not a proposed production verdict.
use std::collections::BTreeMap;
use std::path::Path;

const LAYOUTS: usize = 16;
const REPEATS: usize = 4;

type Pairs = Vec<(u128, u128)>;

fn variance(x: &[f64]) -> f64 {
    let mean = x.iter().sum::<f64>() / x.len() as f64;
    x.iter().map(|v| (v - mean).powi(2)).sum::<f64>() / (x.len() - 1) as f64
}

fn dependence(logs: &[f64]) -> Option<(f64, f64)> {
    assert_eq!(logs.len(), LAYOUTS * REPEATS);
    let raw_var = variance(logs);
    if raw_var == 0.0 {
        return None;
    }
    let means: Vec<_> = (0..LAYOUTS)
        .map(|g| (0..REPEATS).map(|r| logs[g + r * LAYOUTS]).sum::<f64>() / REPEATS as f64)
        .collect();
    let between = REPEATS as f64 * variance(&means);
    let within = (0..LAYOUTS)
        .map(|g| {
            (0..REPEATS)
                .map(|r| (logs[g + r * LAYOUTS] - means[g]).powi(2))
                .sum::<f64>()
        })
        .sum::<f64>()
        / (LAYOUTS * (REPEATS - 1)) as f64;
    let icc = (between - within) / (between + (REPEATS - 1) as f64 * within);
    Some((icc, (REPEATS as f64 * variance(&means) / raw_var).sqrt()))
}

pub fn command(arguments: &[String]) {
    // Independent algebraic anchors: perfect group repeats, and balanced
    // within-group noise with zero between-group variance.
    let repeated: Vec<_> = (0..64)
        .map(|i| if i % 16 < 10 { 1.0 } else { -1.0 })
        .collect();
    let (icc, se) = dependence(&repeated).unwrap();
    assert!((icc - 1.0).abs() < 1e-12 && (se - (63.0f64 / 15.0).sqrt()).abs() < 1e-12);
    let within: Vec<_> = (0..64)
        .map(|i| if i / 16 < 2 { 1.0 } else { -1.0 })
        .collect();
    let (icc, se) = dependence(&within).unwrap();
    assert!((icc + 1.0 / 3.0).abs() < 1e-12 && se == 0.0);
    assert_eq!(dependence(&[0.0; 64]), None);
    assert!(
        !arguments.is_empty(),
        "layout-audit KEPT_SECOND_STAGE_DIR..."
    );
    println!("# Offline diagnostic: 16 layout pairs, each repeated four times in turn");
    println!("# Groups also share order and can share core placement; correlation does not identify a cause");
    println!("# Grouped means are geometric means of run means, preserving the overall log-ratio estimate");
    println!("# This counterfactual grouping is not a calibration or a production rule");
    println!("directory\tcell\traw_ratio_permille\tgrouped_ratio_permille\traw_verdict\tgrouped_verdict\tICC_permille\tgroup_SE_over_raw_SE_permille");
    for directory in arguments {
        assess(Path::new(directory));
    }
}

fn assess(directory: &Path) {
    let entries: Vec<_> = std::fs::read_dir(directory)
        .unwrap()
        .map(|e| e.unwrap().path())
        .collect();
    let files = |ending: &str| {
        let mut paths: Vec<_> = entries
            .iter()
            .filter(|p| {
                p.file_name().unwrap().to_str().unwrap().starts_with("run-")
                    && p.to_str().unwrap().ends_with(ending)
            })
            .cloned()
            .collect();
        paths.sort();
        paths
    };
    let (old, new) = (files("-old.tsv"), files("-new.tsv"));
    assert_eq!(
        old.len(),
        LAYOUTS * REPEATS,
        "{} old runs",
        directory.display()
    );
    assert_eq!(new.len(), old.len());
    let mut cells: BTreeMap<String, Pairs> = BTreeMap::new();
    let mut pins = Vec::new();
    for (o, n) in old.iter().zip(&new) {
        let read = |path: &Path| {
            let file = crate::read_samples(path.to_str().unwrap());
            assert!(
                file.load.starts_with("quiet"),
                "{}: {}",
                path.display(),
                file.load
            );
            let pin = file
                .headers
                .iter()
                .find(|(k, _)| k == "measuring thread")
                .map(|(_, v)| v.clone())
                .expect("these records declare measuring-thread placement");
            (
                crate::cell_means(file)
                    .into_iter()
                    .map(|(k, m, _, _)| (k, m))
                    .collect::<BTreeMap<_, _>>(),
                pin,
            )
        };
        let (o, op) = read(o);
        let (n, np) = read(n);
        assert_eq!(o.keys().collect::<Vec<_>>(), n.keys().collect::<Vec<_>>());
        pins.push((op, np));
        for (key, a) in o {
            cells.entry(key.clone()).or_default().push((a, n[&key]));
        }
    }
    let same_pins = (0..LAYOUTS)
        .filter(|&g| (1..REPEATS).all(|r| pins[g] == pins[g + r * LAYOUTS]))
        .count();
    println!("# {}: {same_pins}/{LAYOUTS} groups retain their header pin across repeats (gap cells only)", directory.display());
    let raw: Vec<_> = cells.values().cloned().collect();
    assert!(raw.iter().all(|p| p.len() == LAYOUTS * REPEATS));
    let grouped: Vec<Pairs> = raw
        .iter()
        .map(|pairs| {
            (0..LAYOUTS)
                .map(|g| {
                    (
                        crate::geometric_mean((0..REPEATS).map(|r| pairs[g + r * LAYOUTS].0)),
                        crate::geometric_mean((0..REPEATS).map(|r| pairs[g + r * LAYOUTS].1)),
                    )
                })
                .collect()
        })
        .collect();
    let (rj, _) = crate::judge_once(&raw);
    let (gj, _) = crate::judge_once(&grouped);
    for (((key, pairs), r), g) in cells.into_iter().zip(rj).zip(gj) {
        let logs: Vec<_> = pairs
            .iter()
            .map(|p| clocks::summary::mean_log_ratio(&[*p]))
            .collect();
        let (icc, se_ratio) = dependence(&logs)
            .map(|(icc, se)| {
                (
                    format!("{:.0}", 1000.0 * icc),
                    format!("{:.0}", 1000.0 * se),
                )
            })
            .unwrap_or_else(|| ("NA".to_owned(), "NA".to_owned()));
        assert!(
            r.ratio_permille.abs_diff(g.ratio_permille) <= 1,
            "the same overall log-ratio estimate"
        );
        println!(
            "{}\t{key}\t{}\t{}\t{:?}\t{:?}\t{icc}\t{se_ratio}",
            directory.display(),
            r.ratio_permille,
            g.ratio_permille,
            r.verdict,
            g.verdict
        );
    }
}
