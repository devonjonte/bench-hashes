
#[unsafe(no_mangle)]
pub extern "C" fn derive_and_wipe(ptr: *const u8, len: usize, out: *mut [u8; 32]) {
    use zeroize::Zeroize;
    let ikm = unsafe { core::slice::from_raw_parts(ptr, len) };
    let mut h = blake3_servil_core::convenience::Hasher::new(
        blake3_servil_core::Mode::DeriveKey("audit 2026-11-16"), None);
    h.update(ikm);
    let d = h.finalize();
    h.zeroize();
    unsafe { *out = *d.as_bytes() };
}
