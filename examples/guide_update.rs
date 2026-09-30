// One message arriving in pieces (a file read, a network stream).
use std::io::Read;

fn main() -> std::io::Result<()> {
    let mut file = std::fs::File::open("Cargo.toml")?;
    let mut buffer = vec![0u8; 64 * 1024];
    let mut hasher = blake3_servil::Hasher::new();
    loop {
        let n = file.read(&mut buffer)?;
        if n == 0 { break; }
        // Each piece extends the same message; the order matters.
        hasher.update(&buffer[..n]);
    }
    // The digest of the whole message, whatever the piece sizes were.
    println!("{}", hasher.finalize().to_hex());
    Ok(())
}
