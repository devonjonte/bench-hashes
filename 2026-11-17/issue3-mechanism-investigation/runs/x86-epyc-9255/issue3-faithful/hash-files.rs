// File-identity plumbing, outside every measurement. The second digest
// is SHA-256, supplied by sha256sum. Anchor this library's empty digest.
fn main() {
    blake3_servil_core::initialize();
    assert_eq!(blake3_servil_core::convenience::hash(b"").to_hex().as_str(),
        "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262");
    for path in std::env::args().skip(1) {
        let bytes = std::fs::read(&path).unwrap();
        println!("{}  {}", blake3_servil_core::convenience::hash(&bytes).to_hex(), path);
    }
}
