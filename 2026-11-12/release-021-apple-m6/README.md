# bench-hashes 0.21 at its tag on the Apple M6, November 12, 2026

**Question.** The release's full run, b3sum and crowd on an Apple machine
(Sam's M6, through the shared Mac exchange; tag v0.21.0+84236bf0, pin
BLAKE3-Servil 2037118c).

| job | run | load |
|---|---|---|
| 3076 | full | other programs busy in 1 of 362 seconds; 0.33 CPUs on average |
| 3077 | b3sum | busy in 15 of 490 seconds |
| 3078 | crowd | the programs themselves |

The machine is also a workstation and no run of it today read quiet (the
earlier attempts: 3037 busy in 1 of 360; 3068 in 58 of 405; 3069 in 119
of 543). The full run and crowd are published with the load said on the
map; the b3sum run is not.

No check ran here at the tag: 0.21's `check` divides by the zero
instruction counts this machine gives after a pause (repaired on `next`,
bench-hashes #174).

**Published.** bench-hashes `next` (`benchmark-results/AppleM6.darwin27/`),
bench-hashes #163.
