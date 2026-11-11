#!/bin/sh
# BLAKE3 #368: across the API rename (86b11263, the first commit after 27717b3f). The pin against 86b11263,
# the old side by the first bench that calls the renamed API. Beside first-cut b (the pin against 27717b3f by
# bench 3363bee8: +34.7% / +20.0%), it says how much lies in that one commit or in the bench at that step.
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/work/bench-021tag
for b in 8a153ce2 415e7df3; do
  echo "== the pin against 86b11263, old bench $b"
  ./target/release/bench-hashes check --fork $HOME/work/BLAKE3 --new 2037118ca1da85710aef55d7f13b3abd9095b485 --against 86b11263 --old-bench $b --points "continuous 1 MiB" --layouts 16 --when-quiet --keep $HOME/runs/bisect-368/kept-wall-$b
  e=$?; echo "check exit $e"; [ $e -le 1 ] && break
done
echo "== done"
