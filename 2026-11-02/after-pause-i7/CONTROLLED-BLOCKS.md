# The controlled idle-state blocks on the i7-12700K (bench-hashes #117)

What is asked: Sam's `protocol.sh` from
[`after-pause-protocol`](https://github.com/samshackleton-tech/bench-hashes/tree/data/2026-11-02/after-pause-protocol/after-pause-protocol),
unchanged, run as root on the i7-12700K. The shipped block already ran
here twice without root (`out/`, `analysis.txt`); the two blocks that
switch idle states off (`noC6`, `C1only`) need root to write
`/sys/devices/system/cpu/cpu*/cpuidle/state*/disable`, and have no i7
result yet.

## The run

```
mkdir -p /root/ap && cd /root/ap
git clone https://github.com/johnservil/BLAKE3 fork && git -C fork checkout b5b988d8
curl -sfLO https://raw.githubusercontent.com/samshackleton-tech/bench-hashes/data/2026-11-02/after-pause-protocol/after-pause-protocol/protocol.sh
bash protocol.sh /root/ap          # about 5 minutes; results in /root/ap/out
cat /root/ap/out/status.txt        # ends "states restored" and "protocol done"
```

The script saves every `disable` file first (`out/disable-before.txt`),
switches states off by name on every CPU for each block, and restores
them on exit (`trap restore EXIT`). A run killed with SIGKILL skips the
restore: then write the saved values back (`while read f v; do echo $v >
$f; done < out/disable-before.txt`). While states are off the machine
idles hotter. The caller runs on CPU 2; `blake3 = "=1.8.7"` comes from
crates.io. Nothing else should run on the machine during it.

## Two additions worth making first (one line each)

1. **Read the core's C7 residency too.** On the i7 the deep pauses sit in
   core C7 (0.57 of a 5 ms pause), which the script's C1 and C6 counters
   miss. `protocol-i7-c7.sh` beside this note is the script with a ninth
   column, `c7`, and nothing else changed (its `diff` against
   `protocol.sh` shows the four lines).
2. **Expect 1 ms to be the transition here, not a plateau.** On the i7,
   20 and 200 us enter C1E alone and 5 ms enters C6, C8 or C10; 1 ms is
   mixed (about 70% deep). The script's pause set already includes
   5 ms, so nothing to change; read the 5 ms rows as the deep plateau.

A note for reading the `C1only` block on this machine: the i7 has no
plain C1 state (POLL, C1E, C6, C8, C10), so with C1E and C6 off the
pause idles in POLL, a spinning idle, which is a different control from
the Xeon's C1.

## What the result decides

Sam's point 2 in #117: with the states off, do the after-pause cells
become about 3x more precise (Xeon: detectable change 13% to 4.3%), with
what remains the library's own wake cost? On the i7 the shipped block
reads: the 16 x 64 B batch x2.0-x6.3 over steady with 16-49% detectable;
servil's 1 KiB call x1.1-x1.5 with 4-11%; servil mt's 1 MiB call x3.6-x4.2
with 9-13%. `analyze.py out/noC6-1.tsv out/C1only-1.tsv ...` gives the
same table for the new blocks (it reads 8 or 9 columns). If the cells
read level and tight with the states off, the after-pause cost on the
i7 is the machine's; a cost that stays (servil mt's pool wake is the
candidate) is the library's.

This should also show whether the batch's bimodality within C1E alone
(p10 223 ns, p90 1090 ns after a 20 us pause; steady 203) is C1E's.
