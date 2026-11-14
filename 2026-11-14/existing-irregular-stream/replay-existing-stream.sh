#!/bin/sh
set -eu
B=<development-home>/bench-provenance-door
O=<development-home>/bench-hashes-validation/inbox/x86-epyc-9275f/existing-stream-ab256b0d
V=<development-home>/bench-hashes-validation/next-priorities
R=<development-home>/bench-hashes-validation/inbox/x86-workhorse/provenance-door-adc20bdd/renderer
# This reader is the producer's source: only UI modules/docs changed between
# these commits. No historical sample or comparison compatibility path is used.
git -C "$B" diff --exit-code da6fe3c478e3e25c23ab05514a1723e1e20f5e2f adc20bdd76f7346e263b4d533afc596c0de383d5 -- src/main.rs src/check.rs clocks Cargo.toml Cargo.lock > "$V/reader-source-match.txt"
for arm in unchanged changed; do
  "$R" compare "$O/kept-$arm"/run-*-old.tsv -- "$O/kept-$arm"/run-*-new.tsv > "$V/$arm-replayed.txt" 2> "$V/$arm-replayed.stderr.txt"
done
python3 - <<'PY'
from pathlib import Path
import json
base=Path('<development-home>/bench-hashes-validation/inbox/x86-epyc-9275f/existing-stream-ab256b0d')
out=Path('<development-home>/bench-hashes-validation/next-priorities')
old='8041bd858586abafa0857fb4ec5ed1f0767f67a4';new='ab256b0d9ebb44eececd71ce0ae37113e75634a5'
metadata=[]
for arm in ['unchanged','changed']:
 text=(base/(arm+'.stdout.txt')).read_text();start=text.index('compare: old side:')
 assert text[start:]==(out/(arm+'-replayed.txt')).read_text(),arm
 for p in sorted((base/('kept-'+arm)).glob('run-*.tsv')):
  # Header inspection and source checks only; the Rust reader handles samples.
  head={}
  with p.open() as f:
   for line in f:
    if not line.startswith('#'):break
    if line.startswith('# ') and ': ' in line:
     k,v=line[2:].rstrip('\n').split(': ',1);head[k]=v
  assert head['git commit']=='da6fe3c478e3e25c23ab05514a1723e1e20f5e2f'
  expected=old if arm=='changed' and p.stem.endswith('-old') else new
  assert f'; commit {expected}; clean' in head['source blake3-servil-st']
  assert head['load'].startswith('quiet:'),head['load']
  assert head['contenders']=='--contenders blake3-servil-st'
  metadata.append(dict(arm=arm,file=p.name,load=head['load'],points=head['points'],counts=head['counts read overhead'],source=head['source blake3-servil-st']))
assert len(metadata)==12
(out/'existing-stream-metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
print('Two exact Rust report replays; 12 quiet records with declared source and scope')
PY
