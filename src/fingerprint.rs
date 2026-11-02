/// A dirty tree's fingerprint, as its provenance records it: `dirty-` and
/// the BLAKE3 hash of its changes written as a sigil (johnservil/sigil: 26
/// characters for 32 bytes). build.rs writes it, and tests check it, through
/// this one function (`include!`d by both).
pub fn fingerprint(hash: &[u8; 32]) -> String {
    format!("dirty-{}", sigilcode::encode(hash))
}
