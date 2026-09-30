// Many messages of one length, one call, spread over the program's cores.
fn main() {
    blake3_servil::initialize_multithreaded();
    // Message i starts at byte i * 64 (see hash_many for other lengths).
    let leaves: Vec<u8> = (0..100_000 * 64).map(|i| (i / 64) as u8).collect();
    let mut digests = vec![[0u8; 32]; 100_000];
    blake3_servil::hash_many_multithreaded(&leaves, 64, &mut digests);
    println!("{} digests", digests.len());
}
