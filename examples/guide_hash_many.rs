// Many messages of one length, hashed in one call on the calling thread.
fn main() {
    // Messages sit back to back in one buffer: message i starts at i * 64.
    // A length that is no multiple of 64 gets zero padding up to the next
    // multiple; the padding belongs to the caller.
    let nodes: Vec<u8> = (0..1000 * 64).map(|i| i as u8).collect();
    let mut digests = vec![[0u8; 32]; 1000];
    blake3_servil::hash_many(&nodes, 64, &mut digests);
    // digests[i] is the hash of message i.
    assert_eq!(digests[3], *blake3_servil::hash(&nodes[3 * 64..4 * 64]).as_bytes());
}
