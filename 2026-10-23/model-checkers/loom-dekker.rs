use loom::sync::atomic::{AtomicUsize, Ordering};
use loom::sync::Arc;
use loom::thread;
fn main() {
    loom::model(|| {
        let a = Arc::new(AtomicUsize::new(0)); let b = Arc::new(AtomicUsize::new(0));
        let (a2, b2) = (a.clone(), b.clone());
        let t = thread::spawn(move || { a2.store(1, Ordering::SeqCst); b2.load(Ordering::SeqCst) });
        b.store(1, Ordering::SeqCst);
        let ra = a.load(Ordering::SeqCst);
        let rb = t.join().unwrap();
        assert!(!(ra == 0 && rb == 0), "store buffering: both read 0 under SeqCst");
    });
    println!("dekker holds under loom's SeqCst");
}
