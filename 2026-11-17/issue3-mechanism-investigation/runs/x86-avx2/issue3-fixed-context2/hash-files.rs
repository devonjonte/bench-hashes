fn main() {
    assert_eq!(blake3::hash(b"").to_hex().as_str(), "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262");
    for path in std::env::args().skip(1) {
        let bytes = std::fs::read(&path).unwrap();
        println!("{}  {}", blake3::hash(&bytes).to_hex(), path);
    }
}
