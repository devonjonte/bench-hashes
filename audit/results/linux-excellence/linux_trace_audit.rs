//! Postcollection audit only: the unchanged production Rust samples reader.
use super::*;

#[test]
fn every_batch_matches_independent_raw_time_and_work_trace() {
    let root = std::path::PathBuf::from(std::env::var("LINUX_AUDIT_ROOT").unwrap());
    let mut files = 0;
    let mut batches = 0;
    for stage in ["corrected", "two-chunk"] {
        for entry in fs::read_dir(root.join(stage).join("abba")).unwrap() {
            let folder = entry.unwrap().path();
            if !folder.is_dir() { continue; }
            let probe = folder.join("samples.tsv").exists();
            let sample = if probe { folder.join("samples.tsv") } else { folder.join("benchmark-results/batches/bench-hashes.samples.tsv") };
            let trace = if probe { folder.join("clocks.csv") } else { folder.join("benchmark-results/batches/clocks.csv") };
            let read = read_samples(sample.to_str().unwrap());
            assert!(load_supplies_speed_evidence(&read.load));
            let csv = fs::read_to_string(trace).unwrap();
            let mut traced = std::collections::HashMap::<String, Vec<(u64,u64)>>::new();
            for line in csv.lines().skip(1) {
                let f: Vec<_> = line.split(',').collect();
                let (key, ns, units) = if probe {
                    assert_eq!(f.len(), 10);
                    let messages: u64 = f[0].split_whitespace().next().unwrap().parse().unwrap();
                    (format!("blake3-servil-st|solo|TwoChunkBatchProbe|{}", f[0]), f[3].parse().unwrap(), f[2].parse::<u64>().unwrap() * messages)
                } else {
                    assert_eq!(f.len(), 16);
                    let messages: u64 = f[2].split_whitespace().next().unwrap().parse().unwrap();
                    let calls: u64 = f[6].parse().unwrap();
                    assert_eq!(f[7].parse::<u64>().unwrap(), calls * messages);
                    (format!("{}|{}|{}|{}", f[0], f[3], f[1], f[2]), f[8].parse().unwrap(), calls * messages)
                };
                traced.entry(key).or_default().push((ns,units));
            }
            assert_eq!(traced.len(), read.cells.len());
            for (key, samples) in read.cells {
                let rows = traced.remove(&key).unwrap();
                assert_eq!(rows, samples.iter().map(|m| (m.ns,m.units)).collect::<Vec<_>>(), "{} {key}", sample.display());
                batches += rows.len();
            }
            assert!(traced.is_empty());
            files += 1;
        }
    }
    assert_eq!(files, 24);
    println!("Verified {files} files and {batches} raw batches with production read_samples");
}
