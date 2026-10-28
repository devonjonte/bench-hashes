// Reproduction (not committed), BLAKE3 #204 on 0.8's version commit: a fill
// that writes fewer bytes than its room, as a plain Read::read may, gives a
// wrong digest and no error.
use blake3_servil::{Hash, Mode, performance};
fn main() {
    blake3_servil::initialize_multithreaded(None);
    let message: Vec<u8> = (0..100_000).map(|i| (i % 251) as u8).collect();
    let mut digest = Hash::from_bytes([0; 32]);
    let mut warm = Hash::from_bytes([0; 32]);
    performance::stream(Mode::Plain, |_: &mut [Hash]| {}, |s| {
        // First a full message, so the ring holds other bytes, then the
        // message whose fill stops 1000 bytes short of each room's end.
        s.submit_with(message.len(), |_, room| room.fill(0x5A), &mut warm);
        s.collect();
        s.submit_with(message.len(), |at, room| { let n = room.len().saturating_sub(1000); room[..n].copy_from_slice(&message[at..][..n]); }, &mut digest);
        s.finish();
    });
    let want = blake3_servil::convenience::hash(&message);
    println!("short fill: digest {} the message's hash ({})", if digest == want { "EQUALS" } else { "DIFFERS FROM" }, if digest == want { "no harm" } else { "a wrong digest, no error" });
}
