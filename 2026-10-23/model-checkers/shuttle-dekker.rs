use shuttle::sync::atomic::{AtomicUsize, Ordering};
use shuttle::sync::Arc;
use shuttle::thread;
fn main() {
    shuttle::check_pct(|| {
        let a = Arc::new(AtomicUsize::new(0)); let b = Arc::new(AtomicUsize::new(0));
        let (a2, b2) = (a.clone(), b.clone());
        let t = thread::spawn(move || { a2.store(1, Ordering::SeqCst); b2.load(Ordering::SeqCst) });
        b.store(1, Ordering::SeqCst);
        let ra = a.load(Ordering::SeqCst);
        let rb = t.join().unwrap();
        assert!(!(ra == 0 && rb == 0), "store buffering under SC");
    }, 5000, 3);
    // park/unpark: a waiter that parks until a flag, with a spurious-free unpark.
    shuttle::check_pct(|| {
        let flag = Arc::new(AtomicUsize::new(0));
        let f = flag.clone();
        let waiter = thread::spawn(move || { while f.load(Ordering::SeqCst) == 0 { thread::park(); } });
        let h = waiter.thread().clone();
        flag.store(1, Ordering::SeqCst); h.unpark();
        waiter.join().unwrap();
    }, 2000, 3);
    println!("shuttle: dekker holds under SC; park/unpark modeled");
}
