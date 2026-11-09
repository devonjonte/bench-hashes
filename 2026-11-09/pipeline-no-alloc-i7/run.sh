#!/bin/sh
# The pipeline no-allocation change's speed gate: dc814dc6 against
# candidate/devon-pipeline-no-alloc, the pipeline's cells (and the other
# contenders' at those points), on the i7-12700K.
set -eu
cd /home/agent/bench-0194
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
./target/release/bench-hashes check --fork /home/agent/BLAKE3-dc81 --new candidate/devon-pipeline-no-alloc --against dc814dc6 \
  --points "continuous batch 16,continuous batch 64,continuous batch 256,continuous batch 1024,continuous batch 4096,continuous batch 16384,continuous batch 65536,receive 2 us,receive 20 us,receive saturated" --keep /home/agent/bench-hashes-validation/plna-check/kept --when-quiet
