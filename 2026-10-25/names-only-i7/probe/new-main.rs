include!("../../common.rs");
use blake3_servil::{performance::{self, Block}, Mode};
fn init() { blake3_servil::initialize_multithreaded(None); }
fn one(b: &[u8], len: usize) -> [u8; 32] { *performance::hash_multithreaded(Mode::Hash, Block::from_bytes(&b[..len.next_multiple_of(64)]).unwrap(), len).as_bytes() }
fn many2(b: &[u8]) -> [u8; 32] { let mut out = [[0u8; 32]; 2]; performance::hash_many(Mode::Hash, Block::from_bytes(&b[..128]).unwrap(), 64, &mut out); out[1] }
