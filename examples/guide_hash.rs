// One message, all in memory, hashed on the calling thread.
fn main() {
    // Once per process, before any other call.
    blake3_servil::initialize();
    let message = b"hello, world";
    // `hash` reads the whole slice and returns a 32-byte digest.
    let digest = blake3_servil::hash(message);
    println!("{}", digest.to_hex());
}
