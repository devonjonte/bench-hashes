// One message, all in memory, hashed on the calling thread.
fn main() {
    let message = b"hello, world";
    // `hash` reads the whole slice and returns a 32-byte digest.
    let digest = blake3_servil::hash(message);
    println!("{}", digest.to_hex());
}
