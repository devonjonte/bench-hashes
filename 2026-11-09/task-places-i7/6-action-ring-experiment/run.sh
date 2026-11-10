#!/bin/sh
# The pipeline's action ring (exp/devon-action-ring, on BLAKE3 #331) against the base without
# any ring repair (#329's head c3e1f905): the pipeline's cells, on the i7-12700K.
set -eu
cd /home/agent/bench-0194
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
./target/release/bench-hashes check --fork /home/agent/BLAKE3-302 --new exp/devon-action-ring --against c3e1f905 \
  --points "continuous batch 16,continuous batch 64,continuous batch 256,continuous batch 1024,continuous batch 4096,continuous batch 16384,continuous batch 65536,receive saturated,receive 2 μs,receive 20 μs" \
  --keep /home/agent/bench-hashes-validation/action-ring/kept --when-quiet
