#!/bin/sh
# Where a small-file b3sum run spends its time, for BLAKE3-Servil 0.8, 0.9, the 0.10
# candidate and official 1.8.7. A diagnostic profile: counts and structure, no judged timing.
set -u
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/startup-010"
if [ "${BOUNDED_STARTUP:-}" != yes ]; then
  export BOUNDED_STARTUP=yes
  status=0
  timeout --kill-after=30s 1800s sh "$O/run.sh" || status=$?
  printf 'STARTUP_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
BINS="$HOME/b3sum-contenders-evolution"
cd "$O"
head -c 4096 /dev/urandom > input-4k.bin
head -c 65536 /dev/urandom > input-64k.bin
{ uname -srm; nproc; command -v strace perf readelf ldd size || true; cat /proc/sys/kernel/perf_event_paranoid; } > tools.txt 2>&1
loop() { # NAME COMMAND...: 300 runs from one shell, mean wall time per run in microseconds
  name=$1; shift
  s=$(date +%s%N); i=0
  while [ $i -lt 300 ]; do "$@" > /dev/null 2>&1; i=$((i + 1)); done
  e=$(date +%s%N)
  printf '%s\t%s\n' "$name" $(( (e - s) / 300000 )) >> loop-us.tsv
}
stat_of() { # FILE COMMAND...
  out=$1; shift
  command -v perf > /dev/null 2>&1 || return 0
  perf stat -r 300 -o "$out" -e task-clock,page-faults,context-switches,cpu-migrations,instructions:u,cycles:u "$@" > /dev/null 2> "$out.err" || true
}
loop true /bin/true
stat_of true.perf.txt /bin/true
for round in 1 2; do
for pair in 0.8.0:b5b988d 0.9.0:bf2da8b 0.10-candidate:7048303 official:official-1.8.7; do
  v=${pair%%:*}
  bin="$BINS/b3sum-${pair#*:}-L0"
  if [ ! -x "$bin" ]; then echo "missing $bin" >> missing.txt; continue; fi
  mkdir -p "$v"
  loop "$v 4k round$round" "$bin" input-4k.bin
  loop "$v 4k one-thread round$round" "$bin" --num-threads 1 input-4k.bin
  loop "$v 4k no-mmap round$round" "$bin" --no-mmap input-4k.bin
  loop "$v 64k round$round" "$bin" input-64k.bin
  [ "$round" = 1 ] || continue
  "$bin" --version > "$v/version.txt" 2>&1
  { ls -l "$bin" | awk '{print "bytes", $5}'; size "$bin"; printf 'needed '; readelf -d "$bin" | grep -c NEEDED; printf 'relocations '; readelf -r "$bin" | grep -c R_X86_64; } > "$v/elf.txt" 2>&1
  ldd "$bin" > "$v/ldd.txt" 2>&1
  LD_DEBUG=statistics "$bin" input-4k.bin > /dev/null 2> "$v/ld-statistics.txt"
  if command -v strace > /dev/null 2>&1; then
    strace -f -c -o "$v/strace-counts-4k.txt" "$bin" input-4k.bin > /dev/null 2>&1
    strace -f -ttt -T -o "$v/strace-timeline-4k.txt" "$bin" input-4k.bin > /dev/null 2>&1
    strace -f -c -o "$v/strace-counts-64k.txt" "$bin" input-64k.bin > /dev/null 2>&1
  fi
  stat_of "$v/perf-4k.txt" "$bin" input-4k.bin
  stat_of "$v/perf-4k-one-thread.txt" "$bin" --num-threads 1 input-4k.bin
  stat_of "$v/perf-4k-no-mmap.txt" "$bin" --no-mmap input-4k.bin
  stat_of "$v/perf-64k.txt" "$bin" input-64k.bin
done
done
rm -f input-4k.bin input-64k.bin
printf 'DONE %s\n' "$(date -u +%FT%TZ)"
