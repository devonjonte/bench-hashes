// Probe (not committed): the pool after fork(). The parent initializes
// the pool and hashes; the child, which has no worker threads, hashes a
// one-shot, a Hasher update and a stream.
fn main() {
    blake3_servil::initialize_multithreaded(None);
    let blocks_vec = vec![blake3_servil::performance::Block([7u8; 64]); (16 << 20) / 64];
    let blocks = &blocks_vec[..];
    let input: Vec<u8> = blocks_vec.iter().flat_map(|b| b.0).collect();
    let want = blake3_servil::convenience::hash(&input);
    assert_eq!(blake3_servil::performance::hash_multithreaded(blake3_servil::Mode::Hash, blocks, input.len()), want);
    let pid = unsafe { libc::fork() };
    if pid == 0 && std::env::args().nth(1).is_none() {
        let got = blake3_servil::performance::hash_multithreaded(blake3_servil::Mode::Hash, blocks, input.len());
        eprintln!("child one-shot: {}", if got == want { "ok" } else { "WRONG" });
        let mut h = blake3_servil::performance::Hasher::new_with(blake3_servil::Mode::Hash);
        h.update_multithreaded(&input);
        eprintln!("child Hasher: {}", if h.finalize() == want { "ok" } else { "WRONG" });
        // A stream: many 64 KiB messages, more than its ring holds, then finish.
        let msg = &input[..64 << 10];
        let one = blake3_servil::convenience::hash(msg);
        let mut places = vec![blake3_servil::Hash::from([0u8; 32]); 256];
        let mut good = 0usize;
        {
            let mut free: Vec<&mut blake3_servil::Hash> = places.iter_mut().collect();

            blake3_servil::performance::stream(blake3_servil::Mode::Hash, |hs: &mut [blake3_servil::Hash]| { good += hs.iter().filter(|h| **h == one).count() }, |s| {
                while let Some(place) = free.pop() {
                    s.submit_with(msg.len(), |at, room| room.copy_from_slice(&msg[at..][..room.len()]), place);
                }
                s.finish();
            });
        }
        eprintln!("child stream: {good} of 256 digests right");
        eprintln!("child collect loop: back after {:?} (None: not within 5 s)", collect_loop(msg));
        unsafe { libc::_exit(0) };
    }
    let mut status = 0;
    unsafe { libc::waitpid(pid, &mut status, 0) };
    eprintln!("child exit status {status}");
    eprintln!("parent collect loop: back after {:?}", collect_loop(&input[..64 << 10]));
}

/// A body that waits for two digests by looping on collect: when both came back.
fn collect_loop(msg: &[u8]) -> Option<std::time::Duration> {
    let mut two = vec![blake3_servil::Hash::from([0u8; 32]); 2];
    let back = std::cell::Cell::new(0usize);
    let mut when = None;
    blake3_servil::performance::stream(blake3_servil::Mode::Hash, |hs: &mut [blake3_servil::Hash]| back.set(back.get() + hs.len()), |s| {
        for place in two.iter_mut() {
            s.submit_with(msg.len(), |at, room| room.copy_from_slice(&msg[at..][..room.len()]), place);
        }
        let t = std::time::Instant::now();
        while t.elapsed() < std::time::Duration::from_secs(5) {
            s.collect();
            if back.get() == 2 { when = Some(t.elapsed()); break; }
        }
        s.finish();
    });
    when
}
