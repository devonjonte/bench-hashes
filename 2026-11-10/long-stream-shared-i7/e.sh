#!/bin/sh
# The November 7 whole-map check, exactly as it ran: tip 8d6525c3 against 0.8, old bench 3363bee8, --cells all,
# from bench ac1668a5. Then it read "no cell slower"; replayed on three points today it reads two cells slower.
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/bench-ac16
./target/release/bench-hashes check --fork /home/agent/BLAKE3-m3 --new 8d6525c3 --against b5b988d8 --old-bench 3363bee8 --cells all --keep /home/agent/bench-hashes-validation/long-shared/kept-e --when-quiet
echo "check exit $?"
