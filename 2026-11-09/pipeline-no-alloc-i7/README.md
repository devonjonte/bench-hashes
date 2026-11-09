# The pipeline's allocation-free cycles: the speed gate on the i7-12700K (BLAKE3 #325 item 1)

**Question.** Does keeping the pipeline's batch job in its message slot and its completions in fixed entries (devonjonte `candidate/devon-pipeline-no-alloc` b246a135) slow any of the pipeline's cells against `next` dc814dc6?

**Command.** `run.sh`: `bench-hashes check` (bench 9c6804ed, the 0.21 candidate) on ContinuousBatches 16-65,536 and the receive cells, every BLAKE3-Servil contender, on a quiet machine.

**Verdict.** No cell slower; no level cell's instructions moved beyond +0.5% (`check.stdout.txt`). The pipeline's ContinuousBatches 4096 was a suspect, level on its second look. `compare.md`: the first round's cells as a table (four pairs: a lean, not a verdict): small batches lean faster (16: x0.934, 64: x0.871, every pair faster).
