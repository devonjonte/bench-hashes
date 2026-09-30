// Messages one after another, each in a buffer your code owns. The queue
// hashes earlier buffers while you fill the next; each buffer comes back
// with its digest.
use blake3_servil::{Efficiency, Hash, MessageHandler, Mode, Queue};
use std::sync::mpsc;

// Your handler receives each result. Keep it short; it runs on the
// queue's delivery thread, in submission order.
struct Results(mpsc::SyncSender<(Vec<u8>, Hash)>);
impl MessageHandler for Results {
    type Buffer = Vec<u8>;
    fn hashed(&mut self, buffer: Vec<u8>, hash: Hash) {
        // The channel has room for every buffer in flight, so this never waits.
        self.0.try_send((buffer, hash)).unwrap();
    }
}

fn main() {
    let in_flight = 8; // buffers you keep cycling
    let (sender, results) = mpsc::sync_channel(in_flight);
    let queue = Queue::messages(Mode::Hash, Efficiency::Time, Results(sender));
    let mut free: Vec<Vec<u8>> = (0..in_flight).map(|_| Vec::with_capacity(4096)).collect();
    for message_number in 0..1000u32 {
        // Take a free buffer, or wait for one to come back with its digest.
        let mut buffer = free.pop().unwrap_or_else(|| {
            let (buffer, hash) = results.recv().unwrap();
            println!("{}", hash.to_hex());
            buffer
        });
        buffer.clear();
        buffer.extend_from_slice(&message_number.to_le_bytes()); // your read goes here
        queue.submit(buffer); // returns at once
    }
    // Drain: every buffer comes back once.
    for _ in 0..in_flight - free.len() {
        let (_buffer, hash) = results.recv().unwrap();
        println!("{}", hash.to_hex());
    }
}
