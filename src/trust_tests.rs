//! Fixed independent anchors for the harness's output-observing adapters.
//! Runs only in tests; benchmark samples keep their frozen calls and scope.
use super::*;

fn family(algorithm: Algorithm) -> &'static str {
    match algorithm {
        Algorithm::Blake3 | Algorithm::Blake3Rayon | Algorithm::Blake3ServilSt | Algorithm::Blake3ServilMt => "blake3",
        Algorithm::Sha256 | Algorithm::Sha256Ring | Algorithm::Sha256CommonCrypto => "sha256",
        Algorithm::Sha3_256 => "sha3-256",
        Algorithm::Sha1Dc => "sha1dc",
    }
}

fn anchor(length: usize, algorithm: Algorithm) -> Vec<u8> {
    let line = include_str!("../tools/fixtures/harness-digests.tsv")
        .lines().filter(|l| !l.starts_with('#')).find(|l| {
            let mut fields = l.split('\t');
            fields.next().unwrap().parse::<usize>().unwrap() == length
                && fields.next().unwrap() == family(algorithm)
        }).expect("a fixed independent anchor for this length and family");
    let hex = line.split('\t').nth(2).unwrap();
    assert_eq!(hex.len() % 2, 0);
    (0..hex.len()).step_by(2).map(|i| u8::from_str_radix(&hex[i..i + 2], 16).unwrap()).collect()
}

#[test]
fn harness_adapters_match_fixed_independent_digests_and_counts() {
    for length in [64, 2048, 102400] {
        let input: Vec<u8> = (0..length).map(|i| (i % 251) as u8).collect();
        let cases = [Point::one("anchor", length), Point::lent("anchor", length),
            Point::lent_pieces("anchor", length), Point::continuous("anchor", length)];
        for algorithm in Algorithm::ALL.into_iter().filter(|a| a.availability().is_ok()) {
            let expected = anchor(length, algorithm);
            for point in cases {
                if !algorithm.takes_part(point.use_case) { continue; }
                // One, and enough to wrap the complete kept in-flight set.
                let count = in_flight(length.min(PIECE_LEN));
                for iterations in [1, count + 1] {
                    let mut seen = 0;
                    hash_batch(algorithm, &input, point, iterations, |digest| {
                        assert_eq!(digest, expected.as_slice(), "{} {:?} {length}", algorithm.key(), point.use_case);
                        seen += 1;
                    });
                    assert_eq!(seen, iterations, "every completed input is observed exactly once");
                    assert_eq!(point.use_case.units(point, iterations), (length * seen) as u64);
                }
            }
        }
    }
}

#[test]
fn batch_adapters_observe_fixed_digest_per_message_and_iteration() {
    let message: Vec<u8> = (0..64).collect();
    for count in [1, 4, 17] {
        let input = message.repeat(count);
        let cases = [Point::many("anchor", count), Point::lent_batch("anchor", count), Point::continuous_batch("anchor", count)];
        for algorithm in Algorithm::ALL.into_iter().filter(|a| a.availability().is_ok()) {
            let expected = anchor(64, algorithm).repeat(count);
            for point in cases {
                if !algorithm.takes_part(point.use_case) { continue; }
                for iterations in [1, in_flight(input.len()) + 1] {
                    let mut seen = Vec::new();
                    hash_batch(algorithm, &input, point, iterations, |digest| seen.extend_from_slice(digest));
                    assert_eq!(seen, expected.repeat(iterations), "{} {:?} {count}", algorithm.key(), point.use_case);
                    assert_eq!(point.use_case.units(point, iterations), (count * iterations) as u64);
                }
            }
        }
    }
}
