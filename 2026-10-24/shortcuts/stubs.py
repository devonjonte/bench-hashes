import sys, subprocess
name = sys.argv[1]
stubs = {
 "spare-lane": ("src/lib.rs", '''    match (platform, whole) {
        (Platform::SSE41 | Platform::AVX2, 3) => Some(4),
        (Platform::AVX2, 6..=7) => Some(8),
        (Platform::AVX2, 5) if partial > 5 * BLOCK_LEN => Some(8),
        _ => None,
    }''', '''    // A/B (Zooko, October 24): the shortcut off.
    let _ = (platform, whole, partial);
    None'''),
 "across-from": ("src/many.rs", '''    let chunks = len.div_ceil(CHUNK_LEN);
    if !(2..ACROSS_CHUNKS).contains(&chunks) || !crate::pair::takes_platform(platform) {
        return None;
    }''', '''    // A/B (Zooko, October 24): the shortcut off.
    let chunks = len.div_ceil(CHUNK_LEN);
    if chunks < usize::MAX || !(2..ACROSS_CHUNKS).contains(&chunks) || !crate::pair::takes_platform(platform) {
        return None;
    }'''),
 "pair-takes": ("src/pair.rs", '''    takes_platform(platform) && (CHUNK_LEN + BLOCK_LEN + 1..2 * CHUNK_LEN).contains(&len)''', '''    // A/B (Zooko, October 24): the shortcut off.
    let _ = (platform, len);
    false'''),
 "many-early": ("src/many.rs", '''    if len == BLOCK_LEN && outputs.len() >= 2 {
        assert_slots(input, len, outputs.len());''', '''    // A/B (Zooko, October 24): the shortcut off.
    if len == BLOCK_LEN && outputs.len() >= 2 && outputs.len() == usize::MAX {
        assert_slots(input, len, outputs.len());'''),
}
path, a, b = stubs[name]
s = open(path).read(); assert a in s, name; open(path, "w").write(s.replace(a, b, 1))
