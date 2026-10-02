//! Postcollection audit only: the unchanged production Rust samples reader.
use super::*;

#[test]
fn direct_counter_evidence_uses_shared_ratios_and_speed_rule() {
    let root = std::path::PathBuf::from(std::env::var("LINUX_AUDIT_ROOT").unwrap());
    for stage in ["corrected", "two-chunk", "four-chunk"] {
        let mut report = String::from("Counts are caller-thread user-only; rates are approximate MHz, wall time stays unscaled.\n");
        for cpu in [0, 16] {
            let mut data = std::collections::BTreeMap::<String, [Vec<PerUnit>; 2]>::new();
            for (position, side) in [(1, "old"), (2, "new"), (3, "new"), (4, "old")] {
                let path = root.join(stage).join("abba").join(format!("probe-cpu{cpu}-{position}-{side}/clocks.csv"));
                let csv = fs::read_to_string(path).unwrap();
                for line in csv.lines().skip(1) {
                    let f: Vec<_> = line.split(',').collect();
                    let n = |i: usize| f[i].parse::<u64>().expect("counter evidence is present");
                    let messages: u64 = f[0].split_whitespace().next().unwrap().parse().unwrap();
                    let units = n(2) * messages;
                    let counts = clocks::Counts { p: clocks::Level { cycles: n(4), instructions: n(5), time_ns: n(6) }, e: clocks::Level { cycles: n(7), instructions: n(8), time_ns: n(9) } };
                    assert_eq!(if cpu == 0 { counts.e } else { counts.p }, clocks::Level::default());
                    for (metric, value, denominator) in [("cycles/message", counts.p.cycles + counts.e.cycles, units), ("instructions/message", counts.p.instructions + counts.e.instructions, units), ("approx MHz", counts.mhz(), 1)] {
                        assert!(value > 0);
                        // Exact normalization and comparison are the production rule;
                        // these counts supply the numerator instead of wall ns.
                        let normalized = Measured::new(value, denominator).per_unit();
                        data.entry(format!("cpu{cpu}|{}|{metric}", f[0])).or_insert_with(|| [Vec::new(),Vec::new()])[usize::from(side == "new")].push(normalized);
                    }
                }
            }
            for (key, [old,new]) in data { writeln!(report, "{key}: {}", speeds_line(&old,&new)).unwrap(); }
        }
        fs::write(root.join(stage).join("counter-comparisons.txt"), report).unwrap();
    }
}

#[test]
fn placement_and_streaming_records_match_production_reader() {
    let root = std::path::PathBuf::from(std::env::var("LINUX_AUDIT_ROOT").unwrap());
    let mut files = 0;
    let mut batches = 0;
    for stage in ["placement", "queue-members"] {
        for entry in fs::read_dir(root.join(stage).join("runs")).unwrap() {
            let folder = entry.unwrap().path();
            if !folder.is_dir() { continue; }
            let custom = stage == "placement";
            let sample = if custom { folder.join("benchmark-results/batches/bench-hashes.samples.tsv") } else {
                let paths: Vec<_> = fs::read_dir(folder.join("benchmark-results")).unwrap().map(|e| e.unwrap().path().join("bench-hashes.samples.tsv")).collect();
                assert_eq!(paths.len(),1); paths[0].clone()
            };
            let trace = if custom { folder.join("benchmark-results/batches/clocks.csv") } else { folder.join("clocks.csv") };
            let read = read_samples(sample.to_str().unwrap());
            assert!(load_supplies_speed_evidence(&read.load));
            let csv = fs::read_to_string(trace).unwrap();
            let mut traced = std::collections::HashMap::<String, Vec<(u64,u64)>>::new();
            for line in csv.lines().skip(1) {
                let f: Vec<_> = line.split(',').collect();
                if custom {
                    assert_eq!(f.len(),16);
                    let messages: u64 = f[2].split_whitespace().next().unwrap().parse().unwrap();
                    let units = f[6].parse::<u64>().unwrap() * messages;
                    assert_eq!(f[7].parse::<u64>().unwrap(),units);
                    traced.entry(format!("{}|{}|{}|{}",f[0],f[3],f[1],f[2])).or_default().push((f[8].parse().unwrap(),units));
                } else {
                    assert_eq!(f.len(),29);
                    let size: usize = f[3].parse().unwrap();
                    let point = *POINTS.iter().find(|p| p.bytes == size && format!("{:?}",p.use_case) == f[12]).unwrap();
                    let units = point.use_case.units(point,f[4].parse().unwrap());
                    traced.entry(format!("{}|solo|{}|{}",f[2],f[12],point.label)).or_default().push((f[5].parse().unwrap(),units));
                    for index in [14,21] {
                        traced.entry(format!("{}|shared|{}|{}",f[2],f[12],point.label)).or_default().push((f[index].parse().unwrap(),units));
                    }
                }
            }
            assert_eq!(traced.len(),read.cells.len());
            for (key,samples) in read.cells {
                let values = traced.remove(&key).unwrap();
                assert_eq!(values,samples.iter().map(|m| (m.ns,m.units)).collect::<Vec<_>>(),"{} {key}",sample.display());
                batches += values.len();
            }
            assert!(traced.is_empty()); files += 1;
        }
    }
    assert_eq!(files,56);
    println!("Verified {files} additional files and {batches} raw measured batches");
}

#[test]
fn every_batch_matches_independent_raw_time_and_work_trace() {
    let root = std::path::PathBuf::from(std::env::var("LINUX_AUDIT_ROOT").unwrap());
    let mut files = 0;
    let mut batches = 0;
    for stage in ["corrected", "two-chunk", "four-chunk"] {
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
    assert_eq!(files, 36);
    println!("Verified {files} files and {batches} raw batches with production read_samples");
}
