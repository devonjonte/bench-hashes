//! Offline study only: expose this producer-matched samples reader's raw
//! values and means for the small-call investigation. No measurement or
//! comparison rule changes. The experimental v11 writer's extra event was
//! misencoded: 0x10000 is L1D read misses, not L1I. Keep that distinction in
//! every export; a v10 file has no extra event.
use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

fn paths(arguments: &[String]) -> Vec<PathBuf> {
    arguments
        .iter()
        .flat_map(|arg| {
            let path = Path::new(arg);
            if path.is_dir() {
                let mut files: Vec<_> = std::fs::read_dir(path)
                    .unwrap()
                    .map(|e| e.unwrap().path())
                    .filter(|p| {
                        p.file_name().unwrap().to_string_lossy().starts_with("run-")
                            && p.extension().is_some_and(|x| x == "tsv")
                    })
                    .collect();
                files.sort();
                files
            } else {
                vec![path.to_owned()]
            }
        })
        .collect()
}

pub fn command(arguments: &[String]) {
    let samples = arguments.first().is_some_and(|a| a == "--samples");
    let files = paths(if samples { &arguments[1..] } else { arguments });
    assert!(
        !files.is_empty(),
        "issue3-audit [--samples] FILE_OR_DIRECTORY..."
    );
    println!("# Offline export through read_samples and clocks::summary::mean; extra event is historical L1D, not L1I.");
    let columns = "file\tcell\tload\theader_pin\tsample\twall_ns\tunits\tcpu\tP_time_ns\tP_cycles\tP_instructions\tP_cache_references\tP_cache_misses\tP_historical_L1D_read_misses\tE_time_ns\tE_cycles\tE_instructions\tE_cache_references\tE_cache_misses\tE_historical_L1D_read_misses";
    if samples {
        println!("{columns}");
    } else {
        println!(
            "{}\tmean_ns_per_unit",
            columns.replace("\tsample\t", "\tsamples\t")
        );
    }
    for path in files {
        let text = std::fs::read_to_string(&path).unwrap();
        let extra = match text.lines().next() {
            Some("# bench-hashes samples v11") => true,
            Some("# bench-hashes samples v10") => false,
            _ => panic!("this historical study reads its v10 and experimental v11 producers"),
        };
        let file = crate::read_samples(path.to_str().unwrap());
        let pin = file
            .headers
            .iter()
            .find(|(k, _)| k == "measuring thread")
            .map(|(_, v)| v.as_str())
            .unwrap_or("unstated");
        let cores: BTreeMap<_, _> = file.cores.iter().map(|(k, v)| (k, v)).collect();
        let cpus: BTreeMap<_, _> = file.cpus.iter().map(|(k, v)| (k, v)).collect();
        for (key, values) in &file.cells {
            let prefix = format!("{}\t{key}\t{}\t{pin}", path.display(), file.load);
            let counts = cores.get(key);
            if samples {
                for (i, sample) in values.iter().enumerate() {
                    let cpu = cpus
                        .get(key)
                        .map(|c| c[i].to_string())
                        .unwrap_or_else(|| "-".into());
                    let counters = (0..crate::LEVEL_FIELDS * 2)
                        .map(|field| {
                            if field % crate::LEVEL_FIELDS == 5 && !extra {
                                return "-".into();
                            }
                            counts
                                .map(|c| c[i][field].to_string())
                                .unwrap_or_else(|| "-".into())
                        })
                        .collect::<Vec<String>>()
                        .join("\t");
                    println!(
                        "{prefix}\t{i}\t{}\t{}\t{cpu}\t{counters}",
                        sample.ns, sample.units
                    );
                }
            } else {
                let (ns, units) =
                    clocks::summary::mean_totals(values.iter().map(|s| (s.ns, s.units)));
                let cpu = cpus
                    .get(key)
                    .map(|c| {
                        let mut c = c.to_vec();
                        c.sort();
                        c.dedup();
                        c.into_iter()
                            .map(|c| c.to_string())
                            .collect::<Vec<_>>()
                            .join(",")
                    })
                    .unwrap_or_else(|| "-".into());
                let counters = (0..crate::LEVEL_FIELDS * 2)
                    .map(|field| {
                        if field % crate::LEVEL_FIELDS == 5 && !extra {
                            return "-".into();
                        }
                        counts
                            .map(|c| {
                                c.iter()
                                    .map(|v| u128::from(v[field]))
                                    .sum::<u128>()
                                    .to_string()
                            })
                            .unwrap_or_else(|| "-".into())
                    })
                    .collect::<Vec<String>>()
                    .join("\t");
                let mean = crate::Mean::of(values).format_ns(1);
                println!(
                    "{prefix}\t{}\t{ns}\t{units}\t{cpu}\t{counters}\t{mean}",
                    values.len()
                );
            }
        }
    }
}
