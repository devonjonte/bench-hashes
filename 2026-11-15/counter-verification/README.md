# Counter verification after the paranoid change (ops #10)

November 15, 2026. Sam set `kernel.perf_event_paranoid` to 2 on the six timing
hosts; these jobs ran `clocks`' `events_check` on each, under the hosts' locks,
at bench `5c0efb96b05f`.

| Host | events_check | machine profile |
|---|---|---|
| x86-icelake | counts (five events; stalls need a raw PMU event there) | 13 tests pass |
| x86-icelake-2 | counts | 13 tests pass |
| x86-epyc-9275f | read nothing (exit 134) | with it |
| x86-epyc-9255 | read nothing | with it |
| x86-9700x | read nothing | with it |
| x86-avx2 | read nothing | with it |

The first submission failed on a path of mine (the workspace target directory;
exit 127, retained). The AMD failure is the instrument's: `perf-group-probe`
on the 9700X shows each event opening alone and the pinned group reading up to
six members, while the seventh put the leader in error, so every read gave
nothing. `backend_stalls` has no generic event on AMD (ENOENT), as on the
Intel hosts' generic set.

The first repair ([PR #229](https://github.com/servil-software-factory/bench-hashes/pull/229))
popped members of the failed group, and the rerun at `c4e4cbaf` still read
nothing on all four AMD hosts (kept here): a pinned leader the PMU once failed
to schedule stays in error. The second repair makes each narrower try a fresh
group (`fbe67449ac809cc436b0e1ce47b98800c6e82974`).

At that commit **all six hosts count** (`events-check-fbe67449/`): cycles,
instructions and the L1D/L1I/dTLB misses everywhere, with plausible per-step
figures on the known work; branch misses count on the Intel hosts and are the
dropped seventh member on AMD; backend stalls have no generic AMD event. The
thirteen machine-profile tests pass on every host. This closes the verification;
the package-energy counter and the cpuidle switch stay separate root questions.
