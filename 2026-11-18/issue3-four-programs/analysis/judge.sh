#!/bin/sh
# Judge the delivered comparisons of the four-program experiment. Every statistic comes from the Rust
# reader (issue3-audit --looks, --judge); show.py only arranges its rows.
# Each comparison is two kept directories: kept-NAME (16 pairs, ten cells) and kept-NAME-more (48 more
# pairs, the four cells after other work). combined/HOST/NAME holds both in run order (the second's runs
# renumbered after the first's), which the reader takes as 64 pairs of the cells every run measured.
set -eu
cd $HOME/bench-hashes-validation
B=$HOME/bench-icache/target/release/bench-hashes
ulimit -c 0
: > issue3-arms/looks.tsv
: > issue3-arms/judged.tsv
rm -rf issue3-arms/combined
for h in x86-9700x x86-epyc-9255 x86-avx2; do
  for c in null plant release far bound bound-policy policy-release; do
    for d in "${INBOX:-inbox}"/"$h"/issue3-arms-*/kept-"$c"; do
      [ -d "$d" ] || continue
      first=$(ls "$d" | grep -c '^run-.*\.tsv$') || true
      [ "$first" -ge 16 ] || { echo "$d: only $first runs kept" >&2; continue; }
      "$B" issue3-audit --looks --margin 50 "$d" | grep -v '^#' | grep -v '^dir' >> issue3-arms/looks.tsv
      "$B" issue3-audit --judge "$d" | grep -v '^dir' >> issue3-arms/judged.tsv
      more="$d-more"
      [ -d "$more" ] && [ "$(ls "$more" | grep -c '^run-.*\.tsv$')" -ge 16 ] || continue
      all=issue3-arms/combined/$h/$c
      mkdir -p "$all"
      cp "$d"/run-*.tsv "$all"/
      for f in "$more"/run-*.tsv; do
        n=$(basename "$f" | sed 's/^run-0*\([0-9]*\)-.*/\1/')
        side=$(basename "$f" | sed 's/^run-[0-9]*-//')
        cp "$f" "$all/$(printf 'run-%03d-%s' $((n + first)) "$side")"
      done
      "$B" issue3-audit --looks --margin 50 "$all" | grep -v '^#' | grep -v '^dir' >> issue3-arms/looks.tsv
      "$B" issue3-audit --judge "$all" | grep -v '^dir' >> issue3-arms/judged.tsv
    done
  done
done
wc -l issue3-arms/looks.tsv issue3-arms/judged.tsv
