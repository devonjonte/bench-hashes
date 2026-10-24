# Shared LentMessages 64 B against the duo threads' stack offset, i7-12700K

**Question** (Sam Shackleton, johnservil/bench-hashes #65): does the
shared 64 B cell's 4 KiB-aliasing bistability, 35–45% on the EPYC 9255,
show on Intel P- and E-cores, and how large is it?

**Binary.** The ordinary release build of bench-hashes 0.17.0
(7cd8ba3e) with its pinned contender, servil 082afa3; not relinked by
`check`. SHA-256 1c6b981f... (the binary itself is kept out of the
record).

**Commands.** `sweep.sh`: `GLIBC_TUNABLES=glibc.rtld.optional_static_tls=S
taskset -c CORES bench-hashes --contenders blake3-servil-st --points
'lent 64 B' --for-regression-check --rounds 96`, S from 448 to 4480 in
steps of 64 (one 4 KiB cycle), CORES 0-15 (P) and 16-19 (E). `sweep16.sh`:
the same on P cores in steps of 16. `confirm.sh`: three repeats of
3952–4080 and of 1008–1136, steps of 16. Columns: cores or repeat,
S, solo ns/B, shared ns/B. Machine otherwise idle; one job at a time.

**Verdict.**
- P cores: yes, smaller. Shared 64 B is 0.80 ns/B at S = 3984–4032 in
  every repeat (one 0.89), against 0.733 in the quiet window: about +9%.
  The neighbours 3952–3968 and 4048–4080 sit at 0.75–0.77 (+3–5%). Solo,
  on the main thread, stays at 0.73 throughout.
- E cores: nothing above noise at steps of 64 (shared 1.19–1.24 ns/B,
  isolated high readings that did not recur); steps of 16 not swept.

**Posted.** johnservil/bench-hashes #65.
