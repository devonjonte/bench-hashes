//! Trace-only diagnostics: production sample reader and shared clocks statistics.
use super::*;

#[test]
fn retained_counter_rows_match_raw_work_and_report_cycles_without_scaling_wall() {
    let root = std::path::PathBuf::from(std::env::var("CURRENT_RUST_CONTROL_RECORDS").unwrap()).join("diagnostic");
    println!("METRIC,folder,cell,input_mod64,wall_ns_per_request_speeds,cycles_per_request_speeds,instructions_per_request_speeds,approx_user_rate_mhz_speeds,e_running_share_percent");
    let mut total = 0;
    for block in 1..=8 {
        for position in 1..=4 {
            let folder_name = format!("block-{block:02}-run-{position}");
            let folder = root.join(&folder_name);
            let file = read_samples(folder.join("samples.tsv").to_str().unwrap());
            let trace = fs::read_to_string(folder.join("clocks.csv")).unwrap();
            let inputs = fs::read_to_string(folder.join("inputs.csv")).unwrap();
            for (key, samples) in &file.cells {
                let mut cycles = Vec::new();
                let mut instructions = Vec::new();
                let mut rate = Vec::new();
                let mut all_counts = clocks::Counts::default();
                let mut alignment = None;
                for line in inputs.lines().skip(1) {
                    let f: Vec<_> = line.split(',').collect();
                    assert_eq!(f.len(), 3);
                    if format!("{}|solo|PositiveWorkControl|{} B", f[0], f[1]) == *key {
                        let a: u64 = f[2].parse().unwrap();
                        assert!(a < 64);
                        assert!(alignment.replace(a).is_none());
                    }
                }
                for line in trace.lines().skip(1) {
                    let f: Vec<_> = line.split(',').collect();
                    assert_eq!(f.len(), 14);
                    if format!("{}|solo|PositiveWorkControl|{} B", f[0], f[1]) != *key { continue; }
                    let number = |i: usize| f[i].parse::<u64>().expect("available labelled counter field");
                    let sample = number(2) as usize;
                    let calls = number(4);
                    assert_eq!((samples[sample].ns, samples[sample].units), (number(7), calls));
                    let c = clocks::Counts {
                        p: clocks::Level { cycles: number(8), instructions: number(9), time_ns: number(10) },
                        e: clocks::Level { cycles: number(11), instructions: number(12), time_ns: number(13) },
                    };
                    assert!(c.p.cycles + c.e.cycles > 0 && c.p.instructions + c.e.instructions > 0);
                    assert!(c.p.time_ns + c.e.time_ns > 0);
                    // The same pure integer/Q64 normalization applies to discrete
                    // cycle/instruction counts; output names their units explicitly.
                    cycles.push(clocks::speeds::per_unit(c.p.cycles + c.e.cycles, calls));
                    instructions.push(clocks::speeds::per_unit(c.p.instructions + c.e.instructions, calls));
                    rate.push(u128::from(c.mhz()));
                    all_counts = all_counts.plus(c);
                    if block % 2 == 0 { assert_eq!(c.e, clocks::Level::default(), "CPU0 kept the E PMU inactive"); }
                    total += 1;
                }
                assert_eq!(cycles.len(), samples.len());
                let describe = |mut values: Vec<u128>, fixed: bool| {
                    values.sort_unstable();
                    let n = values.len();
                    clocks::speeds::speeds(&values).iter().map(|s| {
                        let value = if fixed { Fixed(s.median).format_ns() } else { s.median.to_string() };
                        format!("{value}@{}%", (s.count * 100 + n / 2) / n)
                    }).collect::<Vec<_>>().join("|")
                };
                println!("METRIC,{folder_name},{key},{},{},{},{},{},{}", alignment.unwrap(),
                    describe(sorted_raw(&per_units(samples)), true), describe(cycles, true),
                    describe(instructions, true), describe(rate, false), all_counts.e_percent());
            }
        }
    }
    assert_eq!(total, 24576);
}
