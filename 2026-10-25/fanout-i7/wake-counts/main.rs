// How the owed wakes divide among woken workers: N one-shot calls of LEN
// bytes on every core, each after a pause of GAP_US (as bench-hashes'
// after-a-pause cells), then the histograms the scratch build keeps.
use blake3_servil::{performance::{self, Block}, Mode};
fn main() {
    let a: Vec<String> = std::env::args().collect();
    let (len, n, gap): (usize, usize, u64) = (a[1].parse().unwrap(), a[2].parse().unwrap(), a[3].parse().unwrap());
    blake3_servil::initialize_multithreaded(None);
    let blocks = vec![Block::ZERO; len / 64];
    for _ in 0..n {
        std::thread::sleep(std::time::Duration::from_micros(gap));
        std::hint::black_box(performance::hash_multithreaded(Mode::Hash, &blocks, len));
    }
    let [direct, owed, paid] = blake3_servil::__wake_stats();
    let show = |name: &str, h: &[usize; 64]| {
        let calls: usize = h.iter().sum();
        let total: usize = h.iter().enumerate().map(|(k, c)| k * c).sum();
        let hist: Vec<String> = h.iter().enumerate().filter(|(_, c)| **c > 0).map(|(k, c)| format!("{k}:{c}")).collect();
        println!("{name}: {calls} calls, {total} wakes in all; wakes:calls {}", hist.join(" "));
    };
    show("publisher's direct wakes per job", &direct);
    show("wakes owed per job", &owed);
    show("wakes each woken worker paid", &paid);
}
