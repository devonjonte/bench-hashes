# Devon's line: the gate on 9963ce09 (Sam Shackleton's wip-clocks landed)

devonjonte/BLAKE3 `servil` `9963ce09` = `87b4fd5` + Sam's `acdae53`
(a time-out is its own outcome, with its own list) and `a090cf2`
(`ones`, `subtree_len`, `left_len` in closed form; `le_bytes` and
`CvStack::merge` as counted loops), from samshackleton-tech/BLAKE3
`wip-clocks`, on the i7-12700K (20 CPUs, 14 GiB, Linux 7.0).

- `gate2-suites.*`: 100 and 99 nextest, 22 doc, 3 vectors, 4 C API,
  every build, the proof helpers: all pass.
- `gate2-check.*`, `check-runs/`: `bench-hashes check --against 87b4fd5`
  (bench-hashes at `faa54c1a`): 308 cells execute a changed line (servil
  st and mt at 154 points), 4 pairs of fresh layouts: **no cell slower**.
  Sam's EPYC gate judged the same 308 cells, none slower; two machines.
- `gate2-mutants.*`: `python3 tools/mutants/check.py`, six shards: exit 0,
  649 survive each known and explained, 34 time out each on
  `timeouts-x86_64.txt`, 5 names confirmed alone; about 55 minutes.
