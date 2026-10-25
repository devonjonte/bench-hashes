// After a pause, as bench-hashes' Idle cells: sleep 1 ms (its GAP_NS),
// then one call, timed; N times. `cell` picks the call. Prints each
// call's nanoseconds, one a line, for the caller to split by state.
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let cell = args[1].as_str();
    let n: usize = args[2].parse().unwrap();
    init();
    let mut times = Vec::with_capacity(n);
    #[repr(align(64))]
    struct Aligned([u8; 8192]);
    let mut buf = Box::new(Aligned([7u8; 8192]));
    for i in 0..n {
        std::thread::sleep(std::time::Duration::from_millis(1));
        buf.0[i % 64] = i as u8;
        let t = std::time::Instant::now();
        let d = match cell {
            "one1536" => one(&buf.0, 1536),
            "one8k" => one(&buf.0, 8192),
            "many2" => many2(&buf.0),
            _ => panic!("cell"),
        };
        times.push(t.elapsed().as_nanos());
        std::hint::black_box(d);
    }
    let mut out = String::new();
    for t in times { out.push_str(&format!("{t}\n")); }
    std::fs::write(&args[3], out).unwrap();
}
