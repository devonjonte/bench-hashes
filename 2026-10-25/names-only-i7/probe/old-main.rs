include!("../../common.rs");
fn init() { blake3_servil::initialize_multithreaded(None); }
fn one(b: &[u8], len: usize) -> [u8; 32] { *blake3_servil::hash_multithreaded(&b[..len]).as_bytes() }
fn many2(b: &[u8]) -> [u8; 32] { let mut out = [[0u8; 32]; 2]; blake3_servil::hash_many(&b[..128], 64, &mut out); out[1] }
