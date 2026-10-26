// Probe (not committed): every API name CHANGELOG.md's "Before you switch"
// and "New" sections give, used as written.
use blake3_servil::{convenience, performance, Mode};
fn main() {
    blake3_servil::initialize_multithreaded(None);
    let input = b"foobarbaz";
    let _ = convenience::hash(input);
    let key = [7u8; 32];
    let _ = convenience::hash_with(Mode::Keyed(&key), input);
    let _ = convenience::hash_with(Mode::DeriveKey("ctx"), input);
    let mut xof = convenience::hash_xof(Mode::Hash, input);
    let mut out = [0u8; 100];
    xof.fill(&mut out);
    let mut h = performance::Hasher::new_with(Mode::Hash);
    h.update(input);
    h.update_multithreaded(input);
    let _ = h.update_reader(&input[..]);
    let _ = h.finalize();
    let blocks = vec![performance::Block::ZERO; 4];
    let _ = performance::hash_multithreaded(Mode::Hash, &blocks, 200);
    let mut digests = [[0u8; 32]; 4];
    performance::hash_many(Mode::Hash, &blocks, 64, &mut digests);
    performance::hash_many_multithreaded(Mode::Hash, &blocks, 64, &mut digests);
    let items: Vec<&[u8]> = vec![b"a", b"bc"];
    let mut two = [[0u8; 32]; 2];
    performance::hash_each(Mode::Hash, &items, &mut two);
    performance::hash_each_multithreaded(Mode::Hash, &items, &mut two);
    let mut hashers = vec![performance::Hasher::new_with(Mode::Hash), performance::Hasher::new_with(Mode::Hash)];
    performance::update_each(&mut hashers, &[(0, &b"x"[..]), (1, &b"y"[..])]);
    let mut d2 = [[0u8; 32]; 2];
    performance::finalize_each(&hashers, &[0, 1], &mut d2);
    let ctx = performance::hash_derive_key_context("ctx");
    let _ = convenience::hash_with(Mode::DeriveKeyMaterial(&ctx), input);
    let batch = performance::Batch::new(&[&b"abc"[..], &b"def"[..]]);
    let _ = batch;
    println!("every name compiles");
}
