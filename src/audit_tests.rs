//! Regression checks for the benchmark's own work, independent of speed.
use super::*;
use std::alloc::{GlobalAlloc, Layout, System};
use std::cell::Cell;

struct CountingAllocator;
thread_local! {
    static TRACK: Cell<bool> = const { Cell::new(false) };
    static ALLOCATIONS: Cell<usize> = const { Cell::new(0) };
}
fn allocated() {
    if TRACK.try_with(Cell::get).unwrap_or(false) {
        let _ = ALLOCATIONS.try_with(|n| n.set(n.get() + 1));
    }
}
unsafe impl GlobalAlloc for CountingAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        allocated();
        unsafe { System.alloc(layout) }
    }
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        allocated();
        unsafe { System.alloc_zeroed(layout) }
    }
    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, size: usize) -> *mut u8 {
        allocated();
        unsafe { System.realloc(ptr, layout, size) }
    }
    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        unsafe { System.dealloc(ptr, layout) }
    }
}
#[global_allocator]
static ALLOCATOR: CountingAllocator = CountingAllocator;
fn allocations(f: impl FnOnce()) -> usize {
    ALLOCATIONS.with(|n| n.set(0));
    TRACK.with(|enabled| enabled.set(true));
    f();
    TRACK.with(|enabled| enabled.set(false));
    ALLOCATIONS.with(Cell::get)
}

#[test]
fn batch_digest_storage_survives_a_smaller_cell_without_zeroing() {
    let mut large = take_batch_digests(8192);
    large.fill([0xa5; 32]);
    let address = large.as_ptr();
    keep_batch_digests(large);
    let small = take_batch_digests(16);
    keep_batch_digests(small);
    let large = take_batch_digests(8192);
    assert_eq!(large.as_ptr(), address, "the allocation stays mapped");
    assert!(large.iter().all(|digest| *digest == [0xa5; 32]),
        "switching sizes must preserve the output space, rather than zeroing the larger cell's outputs inside its interval");
    keep_batch_digests(large);
}

#[test]
fn warmed_queue_batch_producer_has_no_descriptor_allocations() {
    let input = make_input(16 * MESSAGE_LEN);
    // Exercise enough inputs to fill and drain the complete in-flight set.
    for _ in 0..5 {
        queue_batches(&input, 16, 4096, |digest| { black_box(digest); });
    }
    let count = allocations(|| queue_batches(&input, 16, 4096, |digest| { black_box(digest); }));
    assert_eq!(count, 0, "the producer's descriptor vectors must stay outside subsequent sample intervals");
}

#[test]
fn official_batch_wrapper_hashes_each_message_with_plain_api_flags() {
    for messages in [1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 128, 1024] {
        let input = make_input_seeded(messages * MESSAGE_LEN, 17);
        let expected: Vec<u8> = input.chunks_exact(MESSAGE_LEN)
            .flat_map(|message| *blake3::hash(message).as_bytes()).collect();
        let mut actual = Vec::new();
        blake3_batch(&input, MESSAGE_LEN, 2, |digests| actual.extend_from_slice(digests));
        assert_eq!(actual, expected.repeat(2), "{messages} separate hashes, in input order");
    }
}

#[test]
fn sparse_runs_remove_previous_visualizations() {
    let directory = std::env::temp_dir().join(format!("bench-hashes-audit-output-{}", std::process::id()));
    fs::create_dir_all(&directory).unwrap();
    for name in ["bench-hashes.graph.svg", "bench-hashes.guide.html", "bench-hashes.result.txt"] {
        fs::write(directory.join(name), "previous run").unwrap();
    }
    remove_visualizations(&directory);
    assert!(!directory.join("bench-hashes.graph.svg").exists());
    assert!(!directory.join("bench-hashes.guide.html").exists());
    assert!(directory.join("bench-hashes.result.txt").exists());
    remove_visualizations(&directory); // First sparse run has neither file.
    fs::remove_dir_all(directory).unwrap();
}

#[test]
fn guide_medians_match_the_exact_report_rounding() {
    let point = UseCase::LentPieces.points().start;
    let roster = Roster::new(vec![Algorithm::Blake3ServilSt, Algorithm::Sha256Ring], false, Some(vec![point]), Some(2));
    let statistics = summarize_measured(&[Measured::new(2135, 400), Measured::new(2135, 400)]);
    let mut results = vec![vec![None; POINT_COUNT]; roster.len()];
    for cells in &mut results {
        cells[point] = Some(super::Cell { solo: statistics, shared: Some(statistics) });
    }
    let guide = generate_guide(&roster, &results, &machine_metadata());
    assert!(guide.contains("\"med\":[5.338]"), "the report rounds 2135/400 to 5.338; the guide must too");
}

#[test]
fn sampled_visits_complete_the_participating_williams_design() {
    // Enumerate roster sizes, use cases, quick/full counts, and every
    // point offset. Include contenders absent from some use cases.
    for n in 2..=Algorithm::ALL.len() {
        for use_case in UseCase::ALL {
            let orders = participating_orders(&Algorithm::ALL[..n], use_case);
            if orders.is_empty() { continue; }
            let participants = &orders[0];
            for rounds in [QUICK_ROUNDS, FULL_ROUNDS] {
                for offset in 0..POINT_COUNT {
                    let mut realized = Vec::new();
                    for round in 0..rounds {
                        if cell_wants_sample(round + offset, rounds, orders.len()) {
                            realized.push(orders[realized.len() % orders.len()].clone());
                        }
                    }
                    assert_eq!(realized.len(), STEADY_SAMPLES.next_multiple_of(orders.len()));
                    let normalized: Vec<Vec<usize>> = realized.iter().map(|row| row.iter()
                        .map(|a| participants.iter().position(|p| p == a).unwrap()).collect()).collect();
                    if participants.len() > 1 {
                        assert_orders_balanced(&normalized, participants.len());
                    }
                    for row in realized {
                        assert!(row.iter().all(|&a| Algorithm::ALL[a].takes_part(use_case)));
                    }
                }
            }
        }
    }
}

#[test]
fn sample_schedule_handles_short_explicit_round_counts() {
    for rounds in 1..=96 {
        for orders in 1..=18 {
            for offset in [0, 1, 7, 95] {
                let count = (0..rounds).filter(|r| cell_wants_sample(r + offset, rounds, orders)).count();
                assert_eq!(count, STEADY_SAMPLES.next_multiple_of(orders).min(rounds));
            }
        }
    }
}

#[test]
fn shared_copy_bootstrap_is_not_independent_evidence() {
    // A diagnostic anchor: duplicating simultaneous observations creates a
    // narrower interval under the current independent-observation bootstrap.
    // This test records the issue, without changing the shared speed rule.
    let values = [100, 110, 120, 130, 140, 150].map(|ns| clocks::speeds::per_unit(ns, 1));
    let duplicated: Vec<u128> = values.iter().flat_map(|&ns| [ns, ns]).collect();
    let (low, high) = clocks::speeds::bootstrap_median_interval(&values);
    let (low2, high2) = clocks::speeds::bootstrap_median_interval(&duplicated);
    assert!(high2 - low2 < high - low,
        "the independent bootstrap treats correlated copies as extra evidence");
}
