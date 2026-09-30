// One message, all in memory, spread over the program's spare cores.
fn main() {
    // Starting the helper threads once, early, keeps that cost off the
    // first hash. Later calls find them ready.
    blake3_servil::initialize_multithreaded();
    let message = vec![7u8; 8 * 1024 * 1024]; // 8 MiB
    // Same digest as `hash`; large inputs finish sooner.
    let digest = blake3_servil::hash_multithreaded(&message);
    println!("{}", digest.to_hex());
}
