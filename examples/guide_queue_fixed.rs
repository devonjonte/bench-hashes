// Batches of equal-length messages, one buffer after another, each buffer
// yours; the queue hashes earlier batches while you fill the next.
use blake3_servil::{FixedHandler, Mode, Queue};
use std::sync::mpsc;

struct Results(mpsc::SyncSender<(Vec<u8>, Vec<[u8; 32]>)>);
impl FixedHandler for Results {
    type Buffer = Vec<u8>;
    type Digests = Vec<[u8; 32]>;
    fn hashed(&mut self, buffer: Vec<u8>, digests: Vec<[u8; 32]>) {
        self.0.try_send((buffer, digests)).unwrap();
    }
}

fn main() {
    let (messages, message_len, in_flight) = (1024, 64, 8);
    let (sender, results) = mpsc::sync_channel(in_flight);
    // Message i of a batch starts at byte i * 64 (see hash_many for other lengths).
    let queue = Queue::fixed(message_len, Mode::Hash, Results(sender));
    let mut free: Vec<(Vec<u8>, Vec<[u8; 32]>)> =
        (0..in_flight).map(|_| (vec![0u8; messages * message_len], vec![[0u8; 32]; messages])).collect();
    for batch_number in 0..50u8 {
        let (mut buffer, digests) = free.pop().unwrap_or_else(|| {
            let (buffer, digests) = results.recv().unwrap();
            println!("{:02x?}", &digests[0][..4]);
            (buffer, digests)
        });
        buffer.fill(batch_number); // your read goes here
        queue.submit(buffer, digests); // returns at once
    }
    for _ in 0..in_flight - free.len() {
        let (_buffer, digests) = results.recv().unwrap();
        println!("{:02x?}", &digests[0][..4]);
    }
}
