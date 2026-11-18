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
    if arguments.first().is_some_and(|a| a == "--design") {
        return design(&arguments[1..]);
    }
    if arguments.first().is_some_and(|a| a == "--judge") {
        return judge(&arguments[1..]);
    }
    if arguments.first().is_some_and(|a| a == "--looks") {
        return looks(&arguments[1..]);
    }
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

/// The 97.5% point of Student's t for the few degrees of freedom this
/// study meets (standard tables).
fn t975(df: usize) -> f64 {
    match df {
        3 => 3.182_446_3,
        4 => 2.776_445_1,
        7 => 2.364_624_3,
        15 => 2.131_449_5,
        31 => 2.039_513_4,
        63 => 1.998_340_5,
        _ => panic!("no table entry for {df} degrees of freedom"),
    }
}

/// The ratio of two paired samples' arithmetic means, new over old, and
/// its interval by Fieller's theorem: the ratios q for which a t-test at
/// `t` cannot tell the mean of (new - q old) from zero. No interval where
/// the old mean is within its own noise of zero.
fn ratio_interval(pairs: &[(f64, f64)], t: f64) -> (f64, Option<(f64, f64)>) {
    let n = pairs.len() as f64;
    let mo = pairs.iter().map(|p| p.0).sum::<f64>() / n;
    let mn = pairs.iter().map(|p| p.1).sum::<f64>() / n;
    let (mut soo, mut snn, mut son) = (0.0, 0.0, 0.0);
    for &(o, w) in pairs {
        soo += (o - mo) * (o - mo);
        snn += (w - mn) * (w - mn);
        son += (o - mo) * (w - mn);
    }
    let d = n * (n - 1.0);
    let (vo, vn, von) = (soo / d, snn / d, son / d);
    let a = mo * mo - t * t * vo;
    let b = mo * mn - t * t * von;
    let c = mn * mn - t * t * vn;
    let disc = b * b - a * c;
    (
        mn / mo,
        (a > 0.0 && disc >= 0.0).then(|| ((b - disc.sqrt()) / a, (b + disc.sqrt()) / a)),
    )
}

/// One-way variance components of `groups` x `repeats` values, the k-th
/// repeat of group g at `x[g + k * groups]`: (between groups, within).
fn components(x: &[f64], groups: usize, repeats: usize) -> (f64, f64) {
    assert_eq!(x.len(), groups * repeats);
    let all = x.iter().sum::<f64>() / x.len() as f64;
    let means: Vec<f64> = (0..groups)
        .map(|g| (0..repeats).map(|k| x[g + k * groups]).sum::<f64>() / repeats as f64)
        .collect();
    let msb = repeats as f64 * means.iter().map(|m| (m - all) * (m - all)).sum::<f64>()
        / (groups - 1) as f64;
    let msw = (0..groups)
        .map(|g| {
            (0..repeats)
                .map(|k| (x[g + k * groups] - means[g]).powi(2))
                .sum::<f64>()
        })
        .sum::<f64>()
        / (groups * (repeats - 1)) as f64;
    (((msb - msw) / repeats as f64).max(0.0), msw)
}

/// Study only: a kept 64-pair second stage (16 layout pairs, each run four
/// times in turn) judged three ways: as the production rule judged it (64
/// pairs, geometric); with its 16 layout pairs as the count (geometric);
/// and by the ratio of arithmetic means over the 16 layout pairs with a
/// 95% interval against a 3% margin. Beside them, the spread between
/// layout pairs and between repeats (of log pair ratios), and the 95%
/// half-width three designs give: 16 x 4 counted honestly, 64 x 1, and
/// what the production rule assumes of its 64.
fn design(arguments: &[String]) {
    const G: usize = 16;
    const R: usize = 4;
    // The quantity judged: wall time (the production rule's), or one of
    // the thread's counts over the same samples (both core kinds summed).
    let (field, dirs) = match arguments.first().map(String::as_str) {
        Some("--metric") => (
            match arguments[1].as_str() {
                "wall" => None,
                "counted-time" => Some(0),
                "cycles" => Some(1),
                "instructions" => Some(2),
                other => panic!("--metric wall|counted-time|cycles|instructions, not {other}"),
            },
            &arguments[2..],
        ),
        _ => (None, arguments),
    };
    println!("# Study: per-cell 95% intervals, no correction over cells. Permille throughout; sd and half-widths are of log ratios.");
    println!("dir\tcell\traw64_ratio\traw64_verdict\tgrouped16_ratio\tgrouped16_verdict\tarith_ratio\tci_low\tci_high\tvs_3pct\tsd_layout\tsd_repeat\thalf_16x4\thalf_64x1\thalf_assumed");
    for dir in dirs {
        let files = paths(std::slice::from_ref(dir));
        let side = |ending: &str| -> Vec<Vec<(String, u128, u128)>> {
            files
                .iter()
                .filter(|p| p.to_string_lossy().ends_with(ending))
                .map(|p| {
                    let file = crate::read_samples(p.to_str().unwrap());
                    assert!(
                        file.load.starts_with("quiet"),
                        "{}: {}",
                        p.display(),
                        file.load
                    );
                    let cores: BTreeMap<&str, &Vec<[u64; crate::LEVEL_FIELDS * 2]>> =
                        file.cores.iter().map(|(k, v)| (k.as_str(), v)).collect();
                    file.cells
                        .iter()
                        .filter_map(|(k, v)| {
                            let units: u128 = v.iter().map(|s| u128::from(s.units)).sum();
                            let total: u128 = match field {
                                None => v.iter().map(|s| u128::from(s.ns)).sum(),
                                Some(f) => cores
                                    .get(k.as_str())?
                                    .iter()
                                    .map(|c| u128::from(c[f] + c[crate::LEVEL_FIELDS + f]))
                                    .sum(),
                            };
                            (total > 0).then(|| (k.clone(), total, units))
                        })
                        .collect()
                })
                .collect()
        };
        let (old, new) = (side("-old.tsv"), side("-new.tsv"));
        assert!(
            old.len() == G * R && new.len() == G * R,
            "{dir}: {} old and {} new runs",
            old.len(),
            new.len()
        );
        let keys: Vec<String> = old[0].iter().map(|c| c.0.clone()).collect();
        if keys.is_empty() {
            println!("# {dir}: its samples carry no such counts");
            continue;
        }
        let fixed = |ns: u128, units: u128| ((ns << 64) + units / 2) / units;
        let get = |runs: &Vec<Vec<(String, u128, u128)>>, i: usize, key: &str| {
            let c = runs[i]
                .iter()
                .find(|c| c.0 == key)
                .unwrap_or_else(|| panic!("{dir}: run {i} lacks {key}"));
            (c.1, c.2)
        };
        let mut raw = Vec::new();
        let mut grouped = Vec::new();
        for key in &keys {
            raw.push(
                (0..G * R)
                    .map(|i| {
                        let (o, n) = (get(&old, i, key), get(&new, i, key));
                        (fixed(o.0, o.1), fixed(n.0, n.1))
                    })
                    .collect::<Vec<_>>(),
            );
            grouped.push(
                (0..G)
                    .map(|g| {
                        let sum = |runs| {
                            (0..R)
                                .map(|k| get(runs, g + k * G, key))
                                .fold((0, 0), |a, b| (a.0 + b.0, a.1 + b.1))
                        };
                        let (o, n) = (sum(&old), sum(&new));
                        (fixed(o.0, o.1), fixed(n.0, n.1))
                    })
                    .collect::<Vec<_>>(),
            );
        }
        let (rj, _) = crate::judge_once(&raw);
        let (gj, _) = crate::judge_once(&grouped);
        let real = |v: u128| v as f64 / 18_446_744_073_709_551_616.0;
        for (c, key) in keys.iter().enumerate() {
            let pairs: Vec<(f64, f64)> = grouped[c]
                .iter()
                .map(|&(o, n)| (real(o), real(n)))
                .collect();
            let (ratio, interval) = ratio_interval(&pairs, t975(G - 1));
            let (low, high) = interval.expect("a timing's mean stands clear of zero");
            let verdict = if low > 1.03 {
                "slower"
            } else if high < 1.03 {
                "within"
            } else {
                "cannot_tell"
            };
            let logs: Vec<f64> = raw[c]
                .iter()
                .map(|&(o, n)| real(n).ln() - real(o).ln())
                .collect();
            let (between, within) = components(&logs, G, R);
            let mean = logs.iter().sum::<f64>() / logs.len() as f64;
            let total =
                logs.iter().map(|x| (x - mean) * (x - mean)).sum::<f64>() / (logs.len() - 1) as f64;
            let m = |x: f64| (x * 1000.0).round() as i64;
            println!(
                "{dir}\t{key}\t{}\t{:?}\t{}\t{:?}\t{}\t{}\t{}\t{verdict}\t{}\t{}\t{}\t{}\t{}",
                rj[c].ratio_permille,
                rj[c].verdict,
                gj[c].ratio_permille,
                gj[c].verdict,
                m(ratio),
                m(low),
                m(high),
                m(between.sqrt()),
                m(within.sqrt()),
                m(t975(G - 1) * (between / G as f64 + within / (G * R) as f64).sqrt()),
                m(t975(G * R - 1) * ((between + within) / (G * R) as f64).sqrt()),
                m(t975(G * R - 1) * (total / (G * R) as f64).sqrt()),
            );
        }
    }
}

/// Study only: each kept comparison (its run-*-old.tsv with its
/// run-*-new.tsv, in their accepted order) judged by the production rule
/// three times over: on wall time, on the thread's user-mode cycles, and
/// on its instructions, each over the cells that carry it.
fn judge(dirs: &[String]) {
    println!("dir\tpairs\tquiet\tcell\twall_ratio\twall_verdict\tcycles_ratio\tcycles_verdict\tinstructions_ratio\tinstructions_verdict");
    for dir in dirs {
        let files = paths(std::slice::from_ref(dir));
        let mut quiet = true;
        let mut side = |ending: &str| -> Vec<BTreeMap<String, [u128; 4]>> {
            files
                .iter()
                .filter(|p| p.to_string_lossy().ends_with(ending))
                .map(|p| {
                    let file = crate::read_samples(p.to_str().unwrap());
                    quiet &= file.load.starts_with("quiet");
                    let cores: BTreeMap<&str, &Vec<[u64; crate::LEVEL_FIELDS * 2]>> =
                        file.cores.iter().map(|(k, v)| (k.as_str(), v)).collect();
                    file.cells
                        .iter()
                        .map(|(k, v)| {
                            let count = |f: usize| {
                                cores.get(k.as_str()).map_or(0, |c| {
                                    c.iter()
                                        .map(|c| u128::from(c[f] + c[crate::LEVEL_FIELDS + f]))
                                        .sum()
                                })
                            };
                            (
                                k.clone(),
                                [
                                    v.iter().map(|s| u128::from(s.ns)).sum(),
                                    v.iter().map(|s| u128::from(s.units)).sum(),
                                    count(1),
                                    count(2),
                                ],
                            )
                        })
                        .collect()
                })
                .collect()
        };
        let (old, new) = (side("-old.tsv"), side("-new.tsv"));
        assert!(
            old.len() >= 3 && old.len() == new.len(),
            "{dir}: {} old and {} new runs",
            old.len(),
            new.len()
        );
        let keys: Vec<&String> = old[0]
            .keys()
            .filter(|k| old.iter().chain(&new).all(|run| run.contains_key(*k)))
            .collect();
        let fixed = |n: u128, units: u128| ((n << 64) + units / 2) / units;
        // Each metric's cells and their judgments, by cell.
        let judged: Vec<BTreeMap<&String, clocks::summary::Judgment>> = [0usize, 2, 3]
            .iter()
            .map(|&m| {
                let cells: Vec<&String> = keys
                    .iter()
                    .copied()
                    .filter(|k| old.iter().chain(&new).all(|run| run[*k][m] > 0))
                    .collect();
                let tested: Vec<Vec<(u128, u128)>> = cells
                    .iter()
                    .map(|k| {
                        old.iter()
                            .zip(&new)
                            .map(|(o, n)| (fixed(o[*k][m], o[*k][1]), fixed(n[*k][m], n[*k][1])))
                            .collect()
                    })
                    .collect();
                if tested.is_empty() {
                    return BTreeMap::new();
                }
                cells
                    .into_iter()
                    .zip(crate::judge_once(&tested).0)
                    .collect()
            })
            .collect();
        for key in keys {
            let show = |m: usize| {
                judged[m].get(key).map_or("-\t-".to_owned(), |j| {
                    format!("{}\t{:?}", j.ratio_permille, j.verdict)
                })
            };
            println!(
                "{dir}\t{}\t{quiet}\t{key}\t{}\t{}\t{}",
                old.len(),
                show(0),
                show(1),
                show(2)
            );
        }
    }
}

/// The 99.5% point of Student's t at the looks' degrees of freedom
/// (standard tables).
fn t995(df: usize) -> f64 {
    match df {
        7 => 3.499_483_3,
        15 => 2.946_712_9,
        31 => 2.744_041_9,
        63 => 2.656_145_3,
        _ => panic!("no table entry for {df} degrees of freedom"),
    }
}

/// The pairs counted at each look of the study's stopping rule.
const LOOKS: [usize; 4] = [8, 16, 32, 64];

/// The study's stopping rule for one cell: at each look that the pairs
/// reach, the ratio of arithmetic means over the pairs so far and its 99%
/// interval; the cell is decided at the first look whose interval lies
/// wholly beyond `margin` ("slower") or wholly inside it ("within"), and
/// "cannot_tell" where no look decides. Each look's (pairs, ratio,
/// interval), and the decision with the pairs it took.
#[allow(clippy::type_complexity)]
fn decide(
    pairs: &[(f64, f64)],
    margin: f64,
    t: fn(usize) -> f64,
) -> (Vec<(usize, f64, Option<(f64, f64)>)>, (&'static str, usize)) {
    let mut seen = Vec::new();
    let mut decision = None;
    for look in LOOKS.into_iter().filter(|&l| l <= pairs.len()) {
        let (ratio, interval) = ratio_interval(&pairs[..look], t(look - 1));
        seen.push((look, ratio, interval));
        if decision.is_none() {
            decision = match interval {
                Some((low, _)) if low > margin => Some(("slower", look)),
                Some((_, high)) if high < margin => Some(("within", look)),
                _ => None,
            };
        }
    }
    let last = seen.last().map_or(0, |l| l.0);
    (seen, decision.unwrap_or(("cannot_tell", last)))
}

/// Study only: each kept comparison whose pairs each ran a layout of their
/// own, judged by the stopping rule on wall time against `--margin`
/// (permille, 50 unless given), beside the production rule's verdict on
/// all its pairs and the instructions each cell's call retires: their
/// ratio over all pairs, and over the first four whether every pair moved
/// them the same way beyond 0.5% (the check's own rule for a suspect).
fn looks(arguments: &[String]) {
    let (margin, dirs) = match arguments {
        [flag, value, rest @ ..] if flag == "--margin" => {
            (value.parse::<u64>().expect("--margin takes permille"), rest)
        }
        rest => (50, rest),
    };
    // The interval's level at every look: 99% unless `--level 95` follows the margin.
    let (level, t, dirs): (u32, fn(usize) -> f64, &[String]) = match dirs {
        [flag, value, rest @ ..] if flag == "--level" => match value.as_str() {
            "95" => (95, t975, rest),
            "99" => (99, t995, rest),
            other => panic!("--level takes 95 or 99, and {other} is neither"),
        },
        rest => (99, t995, rest),
    };
    println!("# The stopping rule: looks at 8, 16, 32 and 64 pairs, the ratio of arithmetic means with a {level}% interval, against a margin of {margin} permille. Permille throughout.");
    println!("dir\tpairs\tcell\trule_ratio\trule_verdict\tdecision\tdecided_at\tpairs_to_decide\tpair_spread\tlooks(pairs:ratio[low,high])\tinstructions_ratio\tinstructions_first4");
    for dir in dirs {
        let files = paths(std::slice::from_ref(dir));
        let side = |ending: &str| -> Vec<BTreeMap<String, [u128; 3]>> {
            files
                .iter()
                .filter(|p| p.to_string_lossy().ends_with(ending))
                .map(|p| {
                    let file = crate::read_samples(p.to_str().unwrap());
                    assert!(
                        file.load.starts_with("quiet"),
                        "{}: {}",
                        p.display(),
                        file.load
                    );
                    let cores: BTreeMap<&str, &Vec<[u64; crate::LEVEL_FIELDS * 2]>> =
                        file.cores.iter().map(|(k, v)| (k.as_str(), v)).collect();
                    file.cells
                        .iter()
                        .map(|(k, v)| {
                            let instructions = cores.get(k.as_str()).map_or(0, |c| {
                                c.iter()
                                    .map(|c| u128::from(c[2] + c[crate::LEVEL_FIELDS + 2]))
                                    .sum()
                            });
                            (
                                k.clone(),
                                [
                                    v.iter().map(|s| u128::from(s.ns)).sum(),
                                    v.iter().map(|s| u128::from(s.units)).sum(),
                                    instructions,
                                ],
                            )
                        })
                        .collect()
                })
                .collect()
        };
        let (old, new) = (side("-old.tsv"), side("-new.tsv"));
        assert!(
            old.len() >= 3 && old.len() == new.len(),
            "{dir}: {} old and {} new runs",
            old.len(),
            new.len()
        );
        let keys: Vec<&String> = old[0]
            .keys()
            .filter(|k| old.iter().chain(&new).all(|run| run.contains_key(*k)))
            .collect();
        let fixed = |n: u128, units: u128| ((n << 64) + units / 2) / units;
        let tested: Vec<Vec<(u128, u128)>> = keys
            .iter()
            .map(|k| {
                old.iter()
                    .zip(&new)
                    .map(|(o, n)| (fixed(o[*k][0], o[*k][1]), fixed(n[*k][0], n[*k][1])))
                    .collect()
            })
            .collect();
        let ruled = crate::judge_once(&tested).0;
        let permille = |x: f64| (x * 1000.0).round() as i64;
        for (key, rule) in keys.iter().zip(&ruled) {
            let per = |run: &BTreeMap<String, [u128; 3]>, field: usize| {
                run[*key][field] as f64 / run[*key][1] as f64
            };
            let wall: Vec<(f64, f64)> = old
                .iter()
                .zip(&new)
                .map(|(o, n)| (per(o, 0), per(n, 0)))
                .collect();
            let (seen, (decision, at)) = decide(&wall, 1.0 + margin as f64 / 1000.0, t);
            let shown: Vec<String> = seen
                .iter()
                .map(|(look, ratio, interval)| match interval {
                    Some((low, high)) => format!(
                        "{look}:{}[{},{}]",
                        permille(*ratio),
                        permille(*low),
                        permille(*high)
                    ),
                    None => format!("{look}:{}[-,-]", permille(*ratio)),
                })
                .collect();
            // Where no look decided: the pairs at which the last look's interval,
            // narrowing as the root of the pairs, would clear the margin from the
            // ratio it found ("-" where decided, or where the ratio sits on the margin).
            let to_decide = match (decision, seen.last()) {
                ("cannot_tell", Some(&(look, ratio, Some((low, high))))) => {
                    let gap = (1.0 + margin as f64 / 1000.0 - ratio).abs();
                    let need = look as f64 * ((high - low) / 2.0 / gap).powi(2);
                    if need.is_finite() && need < 100_000.0 {
                        (need.ceil() as u64).max(look as u64 + 1).to_string()
                    } else {
                        "-".to_owned()
                    }
                }
                _ => "-".to_owned(),
            };
            // The spread of one pair: the standard deviation of the pairs' log ratios.
            let logs: Vec<f64> = wall.iter().map(|(o, n)| (n / o).ln()).collect();
            let mean = logs.iter().sum::<f64>() / logs.len() as f64;
            let spread = permille(
                (logs.iter().map(|l| (l - mean).powi(2)).sum::<f64>() / (logs.len() - 1) as f64)
                    .sqrt(),
            );
            let counted = old.iter().chain(&new).all(|run| run[*key][2] > 0);
            let (all, first) = if counted {
                let total = |runs: &[BTreeMap<String, [u128; 3]>]| {
                    runs.iter().map(|r| r[*key][2]).sum::<u128>() as f64
                        / runs.iter().map(|r| r[*key][1]).sum::<u128>() as f64
                };
                let moves: Vec<f64> = old
                    .iter()
                    .zip(&new)
                    .take(4)
                    .map(|(o, n)| per(n, 2) / per(o, 2))
                    .collect();
                let first = if moves.iter().all(|&m| m > 1.005) {
                    "up"
                } else if moves.iter().all(|&m| m < 0.995) {
                    "down"
                } else {
                    "same"
                };
                (permille(total(&new) / total(&old)).to_string(), first)
            } else {
                ("-".to_owned(), "-")
            };
            println!(
                "{dir}\t{}\t{key}\t{}\t{:?}\t{decision}\t{at}\t{to_decide}\t{spread}\t{}\t{all}\t{first}",
                old.len(),
                rule.ratio_permille,
                rule.verdict,
                shown.join(" ")
            );
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// A new side exactly twice the old: the ratio is 2 and so is its
    /// whole interval.
    #[test]
    fn a_proportional_pair_has_its_ratio_as_its_interval() {
        let pairs: Vec<(f64, f64)> = [1.0, 2.0, 5.0, 3.0].iter().map(|&o| (o, 2.0 * o)).collect();
        let (ratio, interval) = ratio_interval(&pairs, t975(3));
        let (low, high) = interval.unwrap();
        assert!(
            (ratio - 2.0).abs() < 1e-12 && (low - 2.0).abs() < 1e-9 && (high - 2.0).abs() < 1e-9
        );
    }

    /// At each end of the interval, the t statistic of (new - q old) is the
    /// table's value: the definition, computed apart from the formula.
    #[test]
    fn the_interval_ends_where_the_t_test_turns() {
        let pairs = [(1.0, 1.2), (2.0, 1.9), (3.0, 3.6), (4.0, 4.1), (5.0, 5.9)];
        let (ratio, interval) = ratio_interval(&pairs, t975(4));
        assert!((ratio - 16.7 / 15.0).abs() < 1e-12);
        let (low, high) = interval.unwrap();
        assert!(low < ratio && ratio < high);
        for q in [low, high] {
            let d: Vec<f64> = pairs.iter().map(|&(o, w)| w - q * o).collect();
            let mean = d.iter().sum::<f64>() / 5.0;
            let sd = (d.iter().map(|x| (x - mean) * (x - mean)).sum::<f64>() / 4.0).sqrt();
            assert!(((mean / (sd / 5f64.sqrt())).abs() - t975(4)).abs() < 1e-6);
        }
    }

    /// Groups that differ with repeats alike are all between; repeats that
    /// differ in groups alike are all within.
    #[test]
    fn components_part_the_variance_between_groups_and_repeats() {
        let between: Vec<f64> = (0..8).map(|i| [1.0, 3.0][i % 2]).collect();
        assert_eq!(components(&between, 2, 4), (2.0, 0.0));
        let within: Vec<f64> = (0..8).map(|i| [1.0, 3.0][(i / 2) % 2]).collect();
        let (b, w) = components(&within, 2, 4);
        assert!(b == 0.0 && (w - 4.0 / 3.0).abs() < 1e-12);
    }

    #[test]
    fn the_stopping_rule_decides_at_the_first_look_that_can() {
        // A cell 10% slower in every pair, with a little spread: slower at 8 pairs.
        let slower: Vec<(f64, f64)> = (0..32)
            .map(|i| (100.0 + (i % 4) as f64, 110.0 + (i % 3) as f64))
            .collect();
        assert_eq!(super::decide(&slower, 1.05, super::t995).1, ("slower", 8));
        // The same code: within the margin at 8 pairs.
        let same: Vec<(f64, f64)> = (0..32)
            .map(|i| (100.0 + (i % 4) as f64, 100.0 + ((i + 1) % 4) as f64))
            .collect();
        assert_eq!(super::decide(&same, 1.05, super::t995).1, ("within", 8));
        // Pairs that swing between half and double: no look can tell.
        let wild: Vec<(f64, f64)> = (0..32)
            .map(|i| {
                if i % 2 == 0 {
                    (100.0, 200.0)
                } else {
                    (200.0, 100.0)
                }
            })
            .collect();
        assert_eq!(
            super::decide(&wild, 1.05, super::t995).1,
            ("cannot_tell", 32)
        );
        // Fewer pairs than the first look: nothing looked at.
        assert_eq!(
            super::decide(&same[..5], 1.05, super::t995),
            (vec![], ("cannot_tell", 0))
        );
    }
}
