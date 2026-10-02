//! Test-only raw-accounting audit through the production Rust read_samples.
use super::*;

fn validate(samples_path: &std::path::Path, trace_path: &std::path::Path) -> usize {
    let file = read_samples(samples_path.to_str().unwrap());
    assert_eq!(file.cells.len(), 6);
    let mut counts = std::collections::HashMap::<String, usize>::new();
    let trace = fs::read_to_string(trace_path).unwrap();
    let mut total = 0;
    for line in trace.lines().skip(1) {
        let f: Vec<_> = line.split(',').collect();
        assert_eq!(f.len(), 14);
        let key = format!("{}|solo|PositiveWorkControl|{} B", f[0], f[1]);
        let index: usize = f[2].parse().unwrap();
        let (_, values) = file.cells.iter().find(|(k, _)| *k == key).unwrap();
        assert_eq!(index, *counts.get(&key).unwrap_or(&0));
        let sample = values[index];
        let blocks: u64 = f[3].parse().unwrap();
        let calls: u64 = f[4].parse().unwrap();
        let hashes: u64 = f[5].parse().unwrap();
        let completed: u64 = f[6].parse().unwrap();
        let ns: u64 = f[7].parse().unwrap();
        assert_eq!(calls, blocks * 100);
        assert_eq!(completed, blocks * hashes);
        assert_eq!(sample.ns, ns, "raw ns retained independently of ratio");
        assert_eq!(sample.units, calls, "raw work retained independently of ratio");
        *counts.entry(key).or_default() += 1;
        total += 1;
    }
    for (key, values) in &file.cells {
        assert_eq!(counts[key], values.len());
    }
    total
}

fn visit(path: &std::path::Path, folders: &mut Vec<std::path::PathBuf>) {
    if path.join("accounting.csv").is_file() { folders.push(path.to_owned()); }
    for entry in fs::read_dir(path).unwrap() {
        let child = entry.unwrap().path();
        if child.is_dir() { visit(&child, folders); }
    }
}

#[test]
fn every_retained_sample_matches_exact_trace_ns_and_work() {
    let root = std::path::PathBuf::from(std::env::var("CURRENT_RUST_CONTROL_RECORDS").unwrap());
    let mut folders = Vec::new();
    for stage in ["diagnostic"] { visit(&root.join(stage), &mut folders); }
    assert_eq!(folders.len(), 32);
    let total: usize = folders.iter().map(|f| validate(&f.join("samples.tsv"), &f.join("clocks.csv"))).sum();
    assert_eq!(total, 24576);
}

#[test]
fn ratio_preserving_corruption_fails_raw_accounting() {
    let root = std::path::PathBuf::from(std::env::var("CURRENT_RUST_CONTROL_RECORDS").unwrap());
    let folder = root.join("diagnostic/block-01-run-1");
    let original = folder.join("samples.tsv");
    let file = read_samples(original.to_str().unwrap());
    let first = file.cells[0].1[0];
    let text = fs::read_to_string(&original).unwrap();
    let changed = text.replacen(&format!("{}/{}", first.ns, first.units), &format!("{}/{}", first.ns * 2, first.units * 2), 1);
    assert_ne!(text, changed);
    let path = std::env::temp_dir().join(format!("current-control-corruption-{}.tsv", std::process::id()));
    fs::write(&path, changed).unwrap();
    let result = std::panic::catch_unwind(|| validate(&path, &folder.join("clocks.csv")));
    fs::remove_file(path).unwrap();
    assert!(result.is_err(), "normalized ratio alone would conceal altered raw ns/work");
}
