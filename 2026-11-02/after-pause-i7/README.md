# Sam's after-pause protocol on the i7-12700K (bench-hashes #117)

**Question.** Sam's experiment (#117) on the EPYC 9255 and the Xeon pair:
the pause before a call as a factor (20 us, 200 us, 1 ms, 5 ms), the idle
settings in blocks, four cells, hardware C-state residencies read beside
each call. Does the proposal hold on the i7, with its C6, C8 and C10?

**What ran.** `protocol-i7.sh` is Sam's `protocol.sh` (kept beside it as
`protocol-sam.sh`) with the shipped block alone, twice (rounds 1 and 2),
since the sandbox has no root to disable idle states; `protocol-i7-c7.sh`
adds the core's C7 residency as a ninth column, one round (`out-c7/`).
blake3-servil 0.8 (b5b988d8) and blake3 1.8.7, the caller on CPU 2; 300
visits per cell and pause; each run under 90 s. `analyze.py` reads a run.

**Machine.** i7-12700K, Linux 7.0.0-42, governor powersave, cpuidle
intel_idle/menu, states POLL, C1E (latency 2 us), C6 (220), C8 (280),
C10 (680); `cstate_core` offers c1, c6 and c7 residency.

**Findings** (`analysis.txt`; x = first call's median over the steady
median; det% = the change two runs of 100 a side detect at 5%, 80% power).

1. The pause selects the regime, and on the i7 **1 ms is the
   transition**: 20 and 200 us enter C1E alone; 1 ms enters C6 or C8 in
   about 70% of visits; 5 ms enters C6, C8 or C10. The batch (16 x 64 B):
   x2.0 at 20 us (det 26-31%), x2.6 at 1 ms (det 24-49%), x6.3 at 5 ms
   (det 16%). Servil's 1 KiB call: x1.1, x1.2, x1.5 (det 4-11%).
2. **The deepest cpuidle state a visit entered separates the medians**
   at 1 ms: the batch 277-400 ns after C1E, ~500 after C6, ~1300 after
   C8; servil 1 KiB 821/863/1128 ns; official 1 KiB 935/987/1461 ns. So
   on this machine per-visit state recording explains much of the spread.
3. Within C1E alone (20 us) the batch is still bimodal: p10 223 ns
   (steady 203), p90 1090 ns; the 1 KiB calls are not (p10 737, p90 940
   against steady 730). Unexplained here.
4. **The i7's deep pauses sit in core C7**, which the probe's C1/C6 pair
   misses: at 5 ms the median visit spent 0.03 of the pause in C1, 0.19
   in C6 and 0.57 in C7. An "effective states" line needs c7 on Intel
   client parts.
5. Servil mt's 1 MiB call is x3.6 after 20 us already (p10 33 us, p90
   119 us, steady 28 us): the pool's workers' wake, the library's own
   cost, and the same at every pause length.
6. Rounds 1 and 2 agree within 5% on every median.

**Posted.** bench-hashes #117.
