//! Fixed-budget caller-cost gate. The strict sample reader and shared clocks
//! implement all accounting and interval arithmetic; this module runs/reports.
use super::*;
use clocks::comparison::{self, Decision, Work};
use std::collections::BTreeMap;
type Run = BTreeMap<String, Work>;
pub(super) const POINTS: [&str;14] = [
    "continuous 64 B", "continuous 1 KiB", "continuous 16 KiB", "continuous 64 KiB", "continuous 1 MiB",
    "continuous batch 16", "continuous batch 256", "continuous batch 4096",
    "lent 64 B", "lent 64 KiB", "lent 1 MiB", "lent pieces 64 MiB", "lent batch 16", "lent batch 4096",
];
const ROUNDS: &str = "24";
pub(super) fn tolerance(key:&str)->u64 { if key.split('|').nth(1)==Some("solo") {30_000}else {100_000} }
fn read(path:&str)->(String,Run) {
    let file=read_samples(path);
    let cells=file.cells.into_iter().map(|(key,samples)| {
        let mut total=Work::default();for sample in samples {total.add(sample.ns,sample.units);}(key,total)
    }).collect();
    (file.load,cells)
}
fn percent(ppm:u64)->String {
    let change=i128::from(ppm)-1_000_000;
    let hundredths=(change.abs()+50)/100;
    format!("{}{}.{:02}%",if change<0 {"-"}else {"+"},hundredths/100,hundredths%100)
}
fn assess(paths:&[String],folder:&std::path::Path)->i32 {
    assert_eq!(paths.len(),comparison::BLOCKS*4,"16 ABBA blocks require64 paths in execution order");
    let mut values:BTreeMap<String,Vec<u64>>=BTreeMap::new();
    let mut loads=Vec::new();
    let mut keys=None;
    let mut evidence=String::from("block\tcell\told_ns\told_units\tnew_ns\tnew_units\tratio_ppm\n");
    for (block,group) in paths.chunks_exact(4).enumerate() {
        let runs:Vec<_>=group.iter().map(|path| {
            let (load,run)=read(path);
            if !load_supplies_speed_evidence(&load) {loads.push(format!("{path}: {load}"));}
            let current:Vec<_>=run.keys().cloned().collect();
            assert!(current.len()<=comparison::MAX_CELLS,"coverage supports at most84 cells");
            assert!(!current.is_empty(),"each run supplies measured cells");
            if let Some(expected)=&keys {assert_eq!(&current,expected,"every run measures the same cells");}else {keys=Some(current);}
            run
        }).collect();
        for key in runs[0].keys() {
            let old=runs[0][key].plus(runs[3][key]);
            let new=runs[1][key].plus(runs[2][key]);
            let ratio=comparison::ratio(old,new);
            values.entry(key.clone()).or_default().push(ratio);
            writeln!(evidence,"{}\t{key}\t{}\t{}\t{}\t{}\t{ratio}",block+1,old.ns,old.units,new.ns,new.units).unwrap();
        }
    }
    fs::write(folder.join("blocks.tsv"),evidence).unwrap();
    if !loads.is_empty() {
        println!("regress: inconclusive: {} processes have busy or unobserved load; records in {}",loads.len(),folder.display());
        for load in loads {println!("  {load}");}return 2;
    }
    let mut held=0;let mut uncertain=0;let mut controls=0;let mut control_failed=0;
    let mut rows=String::from("cell\tmean_ratio_ppm\tlow_ppm\thigh_ppm\tdecision\n");
    let mut lines=Vec::new();
    for (key,ratios) in values {
        let i=comparison::interval(&ratios);let d=i.decision(tolerance(&key));
        let control=key.starts_with("sha256|");
        let subject=key.starts_with("blake3-servil-st|")||key.starts_with("blake3-servil-mt|");
        assert!(control||subject,"declared control/subject roster: {key}");
        if control {controls+=1;control_failed+=usize::from(d!=Decision::Within);}
        else if key.split('|').nth(1)==Some("solo") {held+=usize::from(d==Decision::Slower);uncertain+=usize::from(d==Decision::Inconclusive);}
        writeln!(rows,"{key}\t{}\t{}\t{}\t{d:?}",i.estimate,i.low,i.high).unwrap();
        lines.push(format!("  {}{key}: {:?}, estimate {}, interval [{} , {}]",if control {"control "}else {""},d,percent(i.estimate),percent(i.low),percent(i.high)));
    }
    assert!(controls>0,"each campaign measures SHA-256 controls");
    fs::write(folder.join("decisions.tsv"),rows).unwrap();
    println!("regress: caller cost = total timed ns/completed units; mean of16 ABBA block ratios");
    println!("regress: model-based simultaneous intervals, df15 t critical4.5, at most84 cells; records {}",folder.display());
    if control_failed>0 {
        println!("regress: inconclusive: {control_failed} control intervals extend beyond their tolerance bands; subject estimates are descriptive");
        for line in lines {println!("{line}");}return 2;
    }
    for line in lines {println!("{line}");}
    if held>0 {println!("regress: REGRESSION: {held} solo intervals exceed the3% tolerance; {uncertain} other solo cells inconclusive");1}
    else if uncertain>0 {println!("regress: inconclusive: {uncertain} solo intervals overlap a tolerance boundary");2}
    else {println!("regress: all measured solo subjects are within3% tolerance or faster; shared cells reported at10%");0}
}

pub(super) fn command(arguments:&[String])->i32 {
    let usage="usage: bench-hashes regress OLD_EXE NEW_EXE [--points NAME,...] | regress --records MANIFEST.tsv";
    let folder=std::path::PathBuf::from(format!("regression-results/{}-{}",std::process::id(),clocks::load::now_ns()));
    fs::create_dir_all(&folder).unwrap();
    if let [flag,path]=arguments {if flag=="--records" {
        let text=fs::read_to_string(path).unwrap();let mut lines=text.lines();
        assert_eq!(lines.next(),Some("side\tsamples"),"manifest columns are side and samples");
        let parent=std::path::Path::new(path).parent().unwrap();
        let paths:Vec<_>=lines.enumerate().map(|(i,line)| {
            let (side,path)=line.split_once('\t').unwrap();
            assert_eq!(side,["old","new","new","old"][i%4],"records follow declared ABBA order");
            parent.join(path).to_str().unwrap().to_owned()
        }).collect();
        fs::copy(path,folder.join("replay-manifest.tsv")).unwrap();return assess(&paths,&folder);
    }}
    let (old,new,points)=match arguments {
        [a,b]=>(a,b,POINTS.join(",")),
        [a,b,flag,points] if flag=="--points"=>(a,b,points.clone()),
        _=>panic!("{usage}"),
    };
    for name in points.split(',') {point_named(name);}
    let mut manifest=String::from("side\tsamples\n");let mut paths=Vec::new();
    for block in 0..comparison::BLOCKS {
        for (slot,(side,exe)) in [("old",old),("new",new),("new",new),("old",old)].into_iter().enumerate() {
            let run=folder.join(format!("block-{:02}-{}-{side}",block+1,slot+1));fs::create_dir(&run).unwrap();
            let args=["--contenders","sha256,blake3-servil-st,blake3-servil-mt","--points",&points,"--rounds",ROUNDS];
            fs::write(run.join("request.txt"),format!("{exe}\n{}\n",args.join("\n"))).unwrap();
            let trace=fs::canonicalize(&run).unwrap().join("clocks.csv");
            let status=std::process::Command::new(exe).args(args).args(["--trace-clocks",trace.to_str().unwrap()]).current_dir(&run)
                .stdout(fs::File::create(run.join("stdout.txt")).unwrap())
                .stderr(fs::File::create(run.join("stderr.txt")).unwrap()).status().unwrap();
            fs::write(run.join("exit.txt"),format!("{status}\n")).unwrap();
            if !status.success() {println!("regress: execution stopped at {}; retained {status}",run.display());return 2;}
            let found:Vec<_>=fs::read_dir(run.join("benchmark-results")).unwrap().map(|e|e.unwrap().path().join("bench-hashes.samples.tsv")).collect();
            assert_eq!(found.len(),1,"one machine results folder");
            writeln!(manifest,"{side}\t{}",found[0].strip_prefix(&folder).unwrap().display()).unwrap();
            paths.push(found[0].to_str().unwrap().to_owned());
            fs::write(folder.join("manifest.tsv"),&manifest).unwrap();
        }
        eprintln!("regress: block {}/{} complete",block+1,comparison::BLOCKS);
    }
    assess(&paths,&folder)
}
