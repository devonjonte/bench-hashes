#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/pool-topology-3ec37f0e"
export O
if [ "${BOUNDED_POOL_TOPOLOGY:-}" != yes ]; then
  export BOUNDED_POOL_TOPOLOGY=yes
  status=0
  timeout --kill-after=15s 7000s sh "$O/run.sh" || status=$?
  printf 'POOL_TOPOLOGY_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=8 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
C=5c0efb96b05fbc294769b967899a4c680d0ee7b2
OLD=6e498a963c5a8a2a7ddb01a86727317e277c32ec
NEW=3ec37f0e9d72ace57a3e094abbb5759c3f91395f
B="$HOME/work/bench-devon-pool-topology-5c0efb96"
M="$HOME/work/lib-devon-pool-topology-3ec37f0e"
export B M C OLD NEW
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/bench-hashes "$B"
git -C "$B" checkout --detach "$C"
git clone --filter=blob:none --no-checkout https://github.com/servil-software-factory/BLAKE3 "$M"
git -C "$M" checkout --detach "$NEW"
test -z "$(git -C "$B" status --porcelain)"
test -z "$(git -C "$M" status --porcelain)"
cd "$B"
{ hostname; rustc -Vv; cc --version; printf 'bench %s\nold %s\nnew %s\n' "$C" "$OLD" "$NEW"; cat /proc/sys/kernel/perf_event_paranoid; cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list; } > "$O/toolchain.txt"
git -C "$M" diff --stat "$OLD" "$NEW" > "$O/library-change.txt"
cargo build --release --locked > "$O/build.txt" 2>&1
P='continuous 64 B,continuous 4 KiB,continuous 64 KiB,continuous 1 MiB,lent 64 B,lent 4 KiB,lent 64 KiB,lent 1 MiB,continuous batch 16,continuous batch 256,continuous batch 4096,lent batch 16,lent batch 256,lent batch 4096,continuous collection git objects,continuous collection Nix files,receive saturated,receive 2 μs,receive 20 μs'
./target/release/bench-hashes check --fork "$M" --against "$OLD" --new "$NEW" \
    --contenders blake3-servil-mt --points "$P" --when-quiet --keep "$O/kept-topology" \
    > "$O/check.stdout.txt" 2> "$O/check.stderr.txt"
printf 'DONE: one gate check on the named Pipeline/pool cells; raw runs kept\n'
