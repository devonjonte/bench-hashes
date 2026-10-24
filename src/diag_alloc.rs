//! Diagnostic global allocators that place the bench's buffers within a
//! cache line, for measuring how a hash's speed depends on where its
//! caller's message sits (#65). Never a measurement configuration: a run
//! built with one says so in its samples header and its report.
//!
//! - `diag-align64`: the system allocator, every allocation of 64 bytes or
//!   more aligned to 64 (no buffer crosses a line it need not).
//! - `diag-line-offset`: the system allocator, every allocation of 64 bytes
//!   or more (alignment 16 or less) placed `BENCH_DIAG_LINE_OFFSET` bytes
//!   into a cache line, read at build time: 16, 32 or 48.
//!
//! On the AMD EPYC 9255, servil's hash() of 64 bytes had 4 KiB-aliasing
//! windows at 16, 32 and 48 and none at 0, and 256 B ran about 8% slower at
//! 16 and 48 at every stack position (#65, October 24).

#[cfg(all(feature = "diag-align64", feature = "diag-line-offset"))]
compile_error!("diag-align64 and diag-line-offset each place every buffer: choose one");

#[cfg(any(feature = "diag-align64", feature = "diag-line-offset"))]
use std::alloc::{GlobalAlloc, Layout, System};

/// What the samples header and report say about the allocator, if not the
/// system's own.
pub const DESCRIPTION: Option<&str> = if cfg!(feature = "diag-align64") {
    Some("diagnostic: allocations of 64 bytes or more aligned to 64")
} else if cfg!(feature = "diag-line-offset") {
    Some(LINE_OFFSET_DESCRIPTION)
} else {
    None
};

#[cfg(feature = "diag-line-offset")]
const LINE_OFFSET_DESCRIPTION: &str = concat!(
    "diagnostic: allocations of 64 bytes or more placed ",
    env!("BENCH_DIAG_LINE_OFFSET"),
    " bytes into a cache line"
);
#[cfg(not(feature = "diag-line-offset"))]
const LINE_OFFSET_DESCRIPTION: &str = "";

#[cfg(feature = "diag-align64")]
struct Align64;

#[cfg(feature = "diag-align64")]
impl Align64 {
    fn up(layout: Layout) -> Layout {
        if layout.size() >= 64 {
            layout.align_to(64).unwrap()
        } else {
            layout
        }
    }
}

#[cfg(feature = "diag-align64")]
unsafe impl GlobalAlloc for Align64 {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        unsafe { System.alloc(Self::up(layout)) }
    }
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        unsafe { System.alloc_zeroed(Self::up(layout)) }
    }
    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        unsafe { System.dealloc(ptr, Self::up(layout)) }
    }
}

#[cfg(feature = "diag-align64")]
#[global_allocator]
static ALLOCATOR: Align64 = Align64;

#[cfg(feature = "diag-line-offset")]
const LINE_OFFSET: usize = {
    let digits = env!("BENCH_DIAG_LINE_OFFSET").as_bytes();
    let mut value = 0;
    let mut i = 0;
    while i < digits.len() {
        assert!(
            digits[i].is_ascii_digit(),
            "BENCH_DIAG_LINE_OFFSET: 16, 32 or 48"
        );
        value = value * 10 + (digits[i] - b'0') as usize;
        i += 1;
    }
    assert!(
        value == 16 || value == 32 || value == 48,
        "BENCH_DIAG_LINE_OFFSET: 16, 32 or 48"
    );
    value
};

#[cfg(feature = "diag-line-offset")]
struct LineOffset;

#[cfg(feature = "diag-line-offset")]
impl LineOffset {
    /// The layout actually allocated, for a layout this allocator moves:
    /// 64 bytes more, aligned to 64, the caller's block LINE_OFFSET in.
    fn moved(layout: Layout) -> Option<Layout> {
        (layout.size() >= 64 && layout.align() <= 16)
            .then(|| Layout::from_size_align(layout.size() + 64, 64).unwrap())
    }
}

#[cfg(feature = "diag-line-offset")]
unsafe impl GlobalAlloc for LineOffset {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        match Self::moved(layout) {
            Some(moved) => unsafe {
                let p = System.alloc(moved);
                if p.is_null() {
                    p
                } else {
                    p.add(LINE_OFFSET)
                }
            },
            None => unsafe { System.alloc(layout) },
        }
    }
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        match Self::moved(layout) {
            Some(moved) => unsafe {
                let p = System.alloc_zeroed(moved);
                if p.is_null() {
                    p
                } else {
                    p.add(LINE_OFFSET)
                }
            },
            None => unsafe { System.alloc_zeroed(layout) },
        }
    }
    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        match Self::moved(layout) {
            Some(moved) => unsafe { System.dealloc(ptr.sub(LINE_OFFSET), moved) },
            None => unsafe { System.dealloc(ptr, layout) },
        }
    }
}

#[cfg(feature = "diag-line-offset")]
#[global_allocator]
static ALLOCATOR: LineOffset = LineOffset;

#[cfg(test)]
mod tests {
    /// Under a diagnostic allocator, a Vec of 64 bytes or more sits where
    /// the feature says; without one, nothing is claimed.
    #[test]
    fn buffers_sit_where_the_feature_says() {
        // A heap allocation of 64 bytes, as the bench's buffers are.
        let v: Vec<u8> = Vec::with_capacity(64);
        let in_line = v.as_ptr() as usize % 64;
        if cfg!(feature = "diag-align64") {
            assert_eq!(in_line, 0);
        }
        #[cfg(feature = "diag-line-offset")]
        assert_eq!(in_line, super::LINE_OFFSET);
        let _ = in_line;
    }
}
