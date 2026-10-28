# The x86 items on 0.8's fixes at d34af741 (#204, #205 static), i7-12700K

**Commits:** johnservil/BLAKE3 candidate/fixes-204-205 d34af741; bench 0.18.3
f17a161b nested, old side 0.18.1 2c9633ae.

**Commands** (`all.sh`, run-bounded.py, October 28, 15:31-16:37 UTC):
the suites; `check --against 83d59db2 --old-bench 2c9633ae --cells all`
(`check/`, `compare.txt` each stage read whole); `check.py --write`.

**Verdicts:** suites all pass; the check finds no cell slower in either
stage; the mutation run exits 0, 640 survive and 32 time out. The list
(BLAKE3 PR, 877f5146) gains 193 "same code" rows and one new survivor, `replace
assert_slots with ()`, unreachable through Batch (reasoned; a code
question for #205).

**Posted:** BLAKE3 #125.
