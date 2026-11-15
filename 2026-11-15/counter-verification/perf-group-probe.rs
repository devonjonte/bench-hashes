//! Which diagnostic events open and schedule together on this host: each
//! event alone, then the group grown one member at a time, reading counts
//! around a little work. Mirrors clocks::events' open/read (pinned leader,
//! exclude kernel/hv, FORMAT_GROUP).
use std::os::fd::{AsRawFd, FromRawFd, OwnedFd};

#[repr(C)]
struct Attr {
    kind: u32,
    size: u32,
    config: u64,
    sample_period: u64,
    sample_type: u64,
    read_format: u64,
    flags: u64,
    reserved: [u64; 2],
}

unsafe extern "C" {
    fn syscall(num: i64, ...) -> i64;
    fn read(fd: i32, buffer: *mut u8, size: usize) -> isize;
}

fn open(kind: u32, config: u64, group: i32, pinned: bool) -> Option<OwnedFd> {
    let attr = Attr {
        kind,
        size: std::mem::size_of::<Attr>() as u32,
        config,
        sample_period: 0,
        sample_type: 0,
        read_format: 1 | 2 | 8,
        flags: (u64::from(pinned) << 2) | (1 << 5) | (1 << 6),
        reserved: [0; 2],
    };
    let fd = unsafe { syscall(298, &attr as *const Attr, 0i64, -1i64, i64::from(group), 8i64) };
    (fd >= 0).then(|| unsafe { OwnedFd::from_raw_fd(fd as i32) })
}

fn work() -> u64 {
    let mut x = 1u64;
    for i in 0..1_000_000u64 {
        x = x.wrapping_mul(6364136223846793005).wrapping_add(i);
    }
    x
}

fn group_counts(leader: &OwnedFd, members: usize) -> Option<Vec<u64>> {
    let mut words = vec![0u64; 3 + 1 + members];
    let n = unsafe { read(leader.as_raw_fd(), words.as_mut_ptr().cast(), words.len() * 8) };
    (n as usize == words.len() * 8).then_some(words)
}

fn main() {
    let cache = |id: u64| id | (1 << 16);
    let events: [(&str, u32, u64); 7] = [
        ("cycles", 0, 0),
        ("instructions", 0, 1),
        ("l1d_load_misses", 3, cache(0)),
        ("l1i_misses", 3, cache(1)),
        ("dtlb_load_misses", 3, cache(3)),
        ("backend_stalls", 0, 8),
        ("branch_misses", 0, 5),
    ];
    println!("each event alone (unpinned, own leader):");
    for (name, kind, config) in events {
        match open(kind, config, -1, false) {
            Some(fd) => {
                std::hint::black_box(work());
                let words = group_counts(&fd, 0);
                println!("  {name}: opened, read {:?}", words.map(|w| (w[1], w[2], w[3])));
            }
            None => println!("  {name}: open failed ({})", std::io::Error::last_os_error()),
        }
    }
    println!("the group, grown one member at a time (pinned leader, as clocks opens it):");
    let leader = open(0, 0, -1, true).expect("cycles leader");
    let mut held = Vec::new();
    for (name, kind, config) in &events[1..] {
        match open(*kind, *config, leader.as_raw_fd(), false) {
            Some(fd) => {
                held.push((name, fd));
                std::hint::black_box(work());
                match group_counts(&leader, held.len()) {
                    Some(words) => println!("  +{name}: group of {} reads; enabled {} running {}", held.len() + 1, words[1], words[2]),
                    None => println!("  +{name}: group of {} READS NOTHING (pinned leader in error)", held.len() + 1),
                }
            }
            None => println!("  +{name}: member open failed ({})", std::io::Error::last_os_error()),
        }
    }
}
