//! The arrival trace for one message received over several callbacks.
//!
//! The consumer copies each fragment into its receive storage before hashing
//! it. `between` is the producer's wait for the next arrival, inside the
//! end-to-end measurement. Tests substitute a recorder for that wait.

/// A TCP payload, a page, a TLS record and a coalesced read, in a fixed cycle.
pub(crate) const FRAGMENTS: [usize; 4] = [1448, 4096, 16 * 1024, 64 * 1024];
pub(crate) const MESSAGE_LEN: usize = 16 << 20;
pub(crate) const CASES: [(&str, u64); 3] = [("saturated", 0), ("2 us", 2_000), ("20 us", 20_000)];

/// The producer schedule and timed work, generated from the trace itself.
pub(crate) fn description() -> String {
    format!(
        "{} B per message; fragment cycle {} B; arrival spacing {}; deadlines fixed from the first arrival, independent of consumer work; receiving through finalization timed together",
        MESSAGE_LEN,
        FRAGMENTS.iter().map(usize::to_string).collect::<Vec<_>>().join(", "),
        CASES.iter().map(|(label, ns)| format!("{label}: {ns} ns")).collect::<Vec<_>>().join(", "),
    )
}

/// Scheduled arrivals are offsets from the first arrival.
/// A saturated source needs neither clock reads nor sleeps between fragments.
pub(crate) fn paced(input: &[u8], receive: &mut dyn FnMut(&[u8]), spacing_ns: u64) {
    if spacing_ns == 0 {
        return arrivals(input, receive, || {});
    }
    let start = clocks::now();
    let mut next = 0;
    arrivals(input, receive, || {
        next += spacing_ns;
        clocks::sleep_until(start, next);
    });
}

/// Deliver every byte once, cutting the final fragment at the message's end.
/// There is one wait between arrivals, including across cycles, and none
/// before the first fragment or after the last. Empty messages have no arrivals.
pub(crate) fn arrivals(input: &[u8], mut receive: impl FnMut(&[u8]), mut between: impl FnMut()) {
    let mut at = 0;
    for wanted in FRAGMENTS.into_iter().cycle() {
        if at == input.len() {
            break;
        }
        let end = at + wanted.min(input.len() - at);
        receive(&input[at..end]);
        at = end;
        if at < input.len() {
            between();
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::{hash_stream_from, Algorithm, Point, UseCase, POINTS};
    use std::cell::{Cell, RefCell};

    #[test]
    fn arrival_order_and_waits() {
        let input = crate::make_input_seeded(64 * 1024, 9);
        let events = RefCell::new(Vec::new());
        let mut produced = Vec::new();
        arrivals(
            &input,
            |fragment| {
                events.borrow_mut().push(fragment.len());
                produced.extend_from_slice(fragment);
            },
            || events.borrow_mut().push(0),
        );
        assert_eq!(*events.borrow(), [1448, 0, 4096, 0, 16384, 0, 43608]);
        assert_eq!(
            produced, input,
            "the callback sees every source byte, in order"
        );
    }

    #[test]
    fn short_empty_and_repeated_cycles() {
        for len in [0, 1, 63, 64, 65, 1447, 1448, 1449, 87464, 87465, 1 << 20] {
            let input = crate::make_input_seeded(len, 17);
            let mut produced = Vec::new();
            let mut fragments = 0usize;
            let mut pauses = 0usize;
            arrivals(
                &input,
                |fragment| {
                    assert!(!fragment.is_empty());
                    fragments += 1;
                    produced.extend_from_slice(fragment);
                },
                || pauses += 1,
            );
            assert_eq!(produced, input, "{len} bytes");
            assert_eq!(pauses, fragments.saturating_sub(1), "{len} bytes");
            if len == 1 << 20 {
                assert_eq!(fragments, 48, "eleven full cycles and a partial cycle");
            }
        }
    }

    #[test]
    fn incremental_dispatch_keeps_the_arrival_waits_and_uses_every_result() {
        blake3_servil::initialize_multithreaded(None);
        let input = crate::make_input_seeded(64 * 1024, 5);
        for algorithm in Algorithm::ALL {
            if algorithm.availability().is_err() {
                continue;
            }
            let waits = Cell::new(0);
            let mut digests = 0;
            hash_stream_from::<true>(
                algorithm,
                &input,
                3,
                |digest| {
                    assert_eq!(digest.len(), algorithm.digest_len());
                    digests += 1;
                },
                |input, receive| arrivals(input, receive, || waits.set(waits.get() + 1)),
            );
            assert_eq!(
                waits.get(),
                9,
                "{}: three waits per message",
                algorithm.key()
            );
            assert_eq!(digests, 3, "{}: one result per message", algorithm.key());
        }
    }

    #[test]
    fn receiving_points_are_complete_end_to_end_messages() {
        let points = &POINTS[UseCase::ReceivingMessage.points()];
        assert_eq!(
            points.iter().map(|p| p.bytes).collect::<Vec<_>>(),
            [MESSAGE_LEN; 3]
        );
        assert_eq!(CASES[2].1, crate::BRIEF_PAUSE_NS);
        for &(label, ns) in &CASES[1..] {
            assert_eq!(label, format!("{} us", ns / 1_000));
        }
        assert!(FRAGMENTS.iter().all(|&n| n <= crate::PIECE_LEN));
        for &point in points {
            assert_eq!(point.messages, 1);
            assert_eq!(point.use_case.pattern_key(), "receiving");
            assert_eq!(
                crate::PATTERNS
                    .iter()
                    .filter(|&&key| key == point.use_case.pattern_key())
                    .count(),
                1,
                "the arrival pattern has one measurement phase"
            );
            assert!(
                !point.use_case.after_gap(),
                "arrival waits belong inside the interval"
            );
            assert!(
                !point.use_case.in_blocks(),
                "the existing incremental APIs take raw received bytes"
            );
            assert_eq!(point.use_case.units(point, 3), point.bytes as u64 * 3);
            assert_eq!(crate::continuous_min_inputs(&[], point), 1);
            assert_eq!(
                crate::point_named(&format!("receive {}", point.label)),
                POINTS
                    .iter()
                    .position(|p| p.use_case == point.use_case && p.label == point.label)
                    .unwrap()
            );
        }
        assert_eq!(Point::receiving(0).use_case, UseCase::ReceivingMessage);
    }
}
