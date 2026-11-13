#!/bin/sh
set -eu
if [ "${ODE_JOB_BOUNDED:-}" != yes ]; then export ODE_JOB_BOUNDED=yes; exec timeout -k 5 1200 sh "$0"; fi
export PATH=$HOME/.cargo/bin:$HOME/bin:$PATH
R=$PWD
W=$HOME/work/ode-adler-fast-8a81ec3a
cleanup() {
 code=$?
 if [ -d "$R/build/native" ]; then
  for name in zlib zlib-ng libdeflate; do
   cp "$R/build/native/$name/CMakeCache.txt" "$R/$name-CMakeCache.txt" || true
   find "$R/build/native/$name" -name flags.make -exec sh -c 'for p do printf "\n%s\n" "$p"; head -c 20000 "$p"; done' sh {} + > "$R/$name-flags.txt" || true
  done
 fi
 rm -rf "$R/build" "$R/runner-0" "$R/runner-256" "$R/runner-1024" "$R/runner-2048" "$R/observations/text.bin" "$W"
 echo "job exit $code"
}
trap cleanup EXIT
mkdir -p observations "$W"
base64 -d <<'PAYLOAD' | tar xzf - -C observations
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
PAYLOAD
if ! command -v b3sum >/dev/null; then timeout -k 5 240 cargo install b3sum --version 1.8.2 --locked > install-b3sum.log 2>&1; fi
# Pin CMake too, so both machines configure the same project defaults.
mkdir -p "$W/tools"
curl -fsSL --max-time 120 -o "$W/tools/cmake.tgz" https://github.com/Kitware/CMake/releases/download/v3.31.8/cmake-3.31.8-linux-x86_64.tar.gz
printf '%s  %s\n' 630615d8e98ac33eba7fbe472626dff5c899c85af3c024585ae109166a6909d0 "$W/tools/cmake.tgz" | sha256sum -c -
printf '%s  %s\n' 6ff85c4a9f065b4e53a7db100d4c5440f37300759f08ed2563d5f2f798689773 "$W/tools/cmake.tgz" | b3sum -c -
tar xzf "$W/tools/cmake.tgz" -C "$W/tools"
export PATH=$W/tools/cmake-3.31.8-linux-x86_64/bin:$PATH
curl -fsSL --max-time 90 -o "$W/tools/nasm.deb" https://us.archive.ubuntu.com/ubuntu/pool/universe/n/nasm/nasm_3.01-1_amd64.deb
printf '%s  %s\n' a611d0d8f35d49e8c9f4b76ff6ef77fba2183ef1b46d0699431a848ba8d2cb46 "$W/tools/nasm.deb" | sha256sum -c -
printf '%s  %s\n' c271bff7d16ce2c1be31fafab57946d8ef1c05eeec16cda251dafb5fc89c36d1 "$W/tools/nasm.deb" | b3sum -c -
dpkg-deb -x "$W/tools/nasm.deb" "$W/tools/nasm"
export PATH=$W/tools/nasm/usr/bin:$PATH
checkout() {
 url=$1; rev=$2; dest=$3
 git init -q "$dest"
 git -C "$dest" fetch -q --depth 1 "$url" "$rev"
 git -C "$dest" checkout -q --detach FETCH_HEAD
 test "$(git -C "$dest" rev-parse HEAD)" = "$rev"
}
C=8a81ec3ad604eb806100500b74df5f3153c50d11
B=5f99f456951ab36f7201decd8aa5e0249ec67bd1
checkout https://github.com/devonjonte/BLAKE3.git "$C" "$W/code"
checkout https://github.com/devonjonte/bench-hashes.git "$B" "$W/clocks"
checkout https://github.com/madler/zlib.git 99623ef7097352da7993ba614161fd6a311e046e "$W/deps/zlib"
checkout https://github.com/zlib-ng/zlib-ng.git 12731092979c6d07f42da27da673a9f6c7b13586 "$W/deps/zlib-ng"
checkout https://github.com/ebiggers/libdeflate.git 92e6a0db9fa848d742f9eb286c92afc60f2c3dda "$W/deps/libdeflate"
checkout https://github.com/intel/isa-l.git 7c3479e0a9dac17f448603ec1ad64c7c625f530c "$W/deps/isa-l"
E=$W/code/tools/verify/machine/experiments/adler32
python3 "$E/prepare_bench.py" "$W/clocks" "$R/observations" "$W/deps" "$R/build" --skip-proof
for p in 0 256 1024; do
 ODE_PADDING=$p timeout -k 5 180 cargo build --release --manifest-path "$R/build/Cargo.toml" > "build-$p.log" 2>&1
 cp "$R/build/target/release/ode-adler-observer" "$R/runner-$p"
 "$R/runner-$p" --validate > "validate-$p.txt"
 sha256sum "$R/runner-$p" >> executable-SHA256SUMS
 b3sum "$R/runner-$p" >> executable-BLAKE3SUMS
 nm -n -C "$R/runner-$p" | grep -E 'adler|functable|probe' > "symbols-$p.txt"
 objdump -d -C "$R/runner-$p" | python3 -c 'import re,sys
keep=False
for l in sys.stdin:
 m=re.match(r"^[0-9a-f]+ <(.*)>:",l)
 if m: keep="adler" in m[1] or "functable" in m[1] or "probe" in m[1]
 if keep: print(l,end="")' > "code-$p.txt"
done
cpu=$(python3 -c 'import os; print(min(os.sched_getaffinity(0)))')
{
 printf 'code %s\nclocks %s\ncpu %s\n' "$C" "$B" "$cpu"
 uname -srm
 cc --version
 rustc --version
 cmake --version
 nasm -v
 lscpu | grep -E 'Architecture|Model name|CPU\(s\)|Thread|Core|Socket|Hypervisor vendor|Virtualization type'
 grep '^flags' /proc/cpuinfo | head -1
} > provenance.txt
# Inspect dispatch after validation, outside every timed run.
if command -v gdb >/dev/null; then
 taskset -c "$cpu" timeout -k 5 30 gdb -q -batch -ex 'set debuginfod enabled off' -ex 'break adler_validation_done' -ex 'run --validate' -ex 'p/a *(void**)&adler32_impl' -ex 'p/a *((void**)&functable + 1)' "$R/runner-0" > dispatch.txt 2>&1 || echo 'dispatch inspection failed; see log' >> dispatch.txt
else
 echo 'gdb unavailable; dispatcher selection unobserved' > dispatch.txt
fi
# Check the guard can fail before any measurement.
if (ulimit -c 0; "$R/runner-0" --overread-control) > guard-control.txt 2>&1; then
 echo 'planted overread survived' >&2; exit 1
else
 code=$?; test "$code" -eq 139; echo 'planted overread: SIGSEGV as required' >> guard-control.txt
fi
# No compilation, disassembly, hashing or inspection below this point.
collect_pair() {
 q=$1; round=$2; pad=$3
 for attempt in 1 2 3; do
  ok=1
  if [ $((round % 2)) = 1 ]; then order='old new'; else order='new old'; fi
  for side in $order; do
   e=libdeflate
   if [ "$side" = new ] && [ "$q" != control ]; then e=$q; fi
   file=$q-pair-$round-attempt-$attempt-$side
   if taskset -c "$cpu" timeout -k 5 60 "$R/runner-$pad" --probe "$e" > "$file.tsv" 2> "$file.log"; then :; else ok=0; fi
  done
  if [ "$ok" = 1 ]; then
   printf '%s\n%s\n' "$q-pair-$round-attempt-$attempt-old.tsv" "$q-pair-$round-attempt-$attempt-new.tsv" >> "$q.pairs"
   return 0
  fi
 done
 echo "three unsuccessful attempts: $q pair $round" >&2
 return 1
}
i=0
for p in 0 256 1024; do
 i=$((i+1))
 case "$i" in 1) order='zlib-ng isa-l probe512 probe512-one probe256 probe256-one';; 2) order='probe512 probe512-one probe256 probe256-one zlib-ng isa-l';; 3) order='probe256 probe256-one zlib-ng isa-l probe512 probe512-one';; esac
 for q in $order; do collect_pair "$q" "$i" "$p"; done
 collect_pair control "$i" "$p"
done
# Collection is over; analyze all 16 cells together per declared question.
compare_one() {
 q=$1
 test "$(wc -l < "$q.pairs")" -eq 6
 set --
 while IFS= read -r p; do set -- "$@" "$p"; done < "$q.pairs"
 "$R/runner-0" --compare "$@" > "comparison-$q.tsv"
}
for q in zlib-ng isa-l probe512 probe512-one probe256 probe256-one control; do compare_one "$q"; done
echo 'comparison complete'
