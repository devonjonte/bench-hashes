// One long message arriving in pieces you own, faster than one thread
// hashes; the queue hashes earlier pieces while you fill the next.
use blake3_servil::{Efficiency, Hash, Mode, PieceHandler, Queue};
use std::sync::mpsc;

enum Back { Piece(Vec<u8>), Done(Hash) }

struct Results(mpsc::SyncSender<Back>);
impl PieceHandler for Results {
    type Buffer = Vec<u8>;
    fn piece_done(&mut self, buffer: Vec<u8>) { self.0.try_send(Back::Piece(buffer)).unwrap(); }
    fn finished(&mut self, hash: Hash) { self.0.try_send(Back::Done(hash)).unwrap(); }
}

fn main() {
    let in_flight = 4;
    let (sender, results) = mpsc::sync_channel(in_flight + 1);
    let queue = Queue::pieces(Mode::Hash, Efficiency::Time, Results(sender));
    let mut free: Vec<Vec<u8>> = (0..in_flight).map(|_| vec![0u8; 64 * 1024]).collect();
    for piece_number in 0..100u8 {
        let mut piece = free.pop().unwrap_or_else(|| match results.recv().unwrap() {
            Back::Piece(buffer) => buffer,
            Back::Done(_) => unreachable!("the message is still open"),
        });
        piece.fill(piece_number); // your read goes here
        queue.submit(piece); // pieces in order; returns at once
    }
    queue.finish(); // the message ends here
    loop {
        match results.recv().unwrap() {
            Back::Piece(_) => {}
            Back::Done(hash) => { println!("{}", hash.to_hex()); break; }
        }
    }
}
