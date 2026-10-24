# BLAKE3 #141's head d3e3cbe, offset check on the i7-12700K

**Question** (Sam Shackleton on BLAKE3 #141): at the head d3e3cbe (the
plain chunk-root kernel, small inputs set up no large frame), does the
i7 still judge servil's cells stack-offset-sensitive, with the bench's
buffers as the allocator places them and with every buffer 64-byte
aligned (`diag-align64`)?

**Commits:** samshackleton-tech/BLAKE3 `candidate/sam-x86-chunk-root`
d3e3cbe, its `tools/offset_check.py`; the bench johnservil/bench-hashes
main 3187e795 in the fork's `bench-hashes/`.

**Commands**, from the fork's root, each under run-bounded.py (3600 s):
- plain: `offset_check.py --exe E --keep plain-kept`, E from
  `bench-hashes build-against ..`;
- aligned: E built with `cargo build --release --features diag-align64
  --config 'patch."https://github.com/johnservil/BLAKE3".blake3-servil.path=".."'`
  (`cargo tree -i blake3-servil` names the checkout).

**Load:** the plain run began at load average 6.7 (one minute), the tail
of a mutation run stopped a few minutes before; its scan's early samples
may carry it. The confirmations, which decide, ran last, on a quiet
machine; the aligned run began at 0.7.

**Verdicts** (8-pair confirmations, `*-confirm/*/regress.out`):

| run | servil st cells judged offset-sensitive | official's control |
|---|---|---|
| plain | shared LentMessages 64 B +3.4% (+3936 against +48, 8 of 8 pairs slower); shared ContinuousMessages 64 B +4.0% (+1760 against +3856) | LentMessages 64 B +38.2% at +3088 |
| diag-align64 | none: "ok: immune cells stay immune" | LentMessages 64 B and 256 B, still sensitive |

At #141's earlier head ad29ede the plain run had servil's shared lent
64 B at +5.8% (`2026-10-24/lent64-i7`). Aligned buffers close the rest on
this machine, as on Sam's EPYC. Raw samples of every scan and
confirmation: `samples.tar.gz`.
