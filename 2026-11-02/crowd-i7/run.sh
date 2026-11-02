#!/bin/sh
set -u
export PATH=/home/agent/.cargo/bin:$PATH TMPDIR=/home/agent/tmp
cd /home/agent/tmp/plrun && /home/agent/bench-mtshared/target/release/bench-hashes crowd --rounds 3
