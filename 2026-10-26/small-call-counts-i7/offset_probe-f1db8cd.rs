// Measurement probe (not committed): hash_many over MSGS 64-byte messages, the input at OFFSET bytes past a 4 KiB boundary.
fn main() {
    let a: Vec<usize> = std::env::args().skip(1).map(|s| s.parse().unwrap()).collect();
    let (msgs, calls, offset, out_at) = (a[0], a[1], a[2], a[3]);
    blake3_servil::initialize();
    let layout = std::alloc::Layout::from_size_align(16384, 4096).unwrap();
    let base = unsafe { std::alloc::alloc_zeroed(layout) };
    let input = unsafe { std::slice::from_raw_parts(base.add(offset), 64 * msgs) };
    let blocks: &[blake3_servil::performance::Block] = unsafe { std::slice::from_raw_parts(input.as_ptr().cast(), msgs) };
    // The output at OUT_AT bytes past the next 4 KiB boundary after the input's page.
    let out: &mut [[u8; 32]] = unsafe { std::slice::from_raw_parts_mut(base.add(4096 + out_at).cast(), msgs) };
    eprintln!("out mod 4096 {:#x}", out.as_ptr() as usize % 4096);
    for _ in 0..calls {
        blake3_servil::performance::hash_many(blake3_servil::Mode::Hash, std::hint::black_box(blocks), 64, out);
        std::hint::black_box(&mut *out);
    }
}
