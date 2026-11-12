#!/bin/sh
# First use of this machine by devon: checkouts, then bench-hashes 0.21 at its tag (run.sh), under the machine's lock.
export PATH=$HOME/.cargo/bin:$PATH
mkdir -p ~/work ~/runs/release-021 && cd ~/work
[ -d bench-hashes ] || git clone -q https://github.com/servil-software-factory/bench-hashes.git
[ -d BLAKE3 ] || git clone -q https://github.com/servil-software-factory/BLAKE3.git
git -C bench-hashes fetch -q origin --tags; git -C BLAKE3 fetch -q origin
echo "== setup done $(date -u +%H:%M)"
cd ~/runs/release-021 && bench-turn sh run.sh
