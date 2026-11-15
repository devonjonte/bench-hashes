#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/events-check-fbe67449"
export O
if [ "${BOUNDED_EVENTS_CHECK:-}" != yes ]; then
  export BOUNDED_EVENTS_CHECK=yes
  status=0
  timeout --kill-after=15s 1200s sh "$O/run.sh" || status=$?
  printf 'EVENTS_CHECK_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS=4 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
C=fbe67449ac809cc436b0e1ce47b98800c6e82974
B="$HOME/work/bench-devon-events-check-5c0efb96"
export B C
test -d "$B"
git -C "$B" checkout --detach "$C"
test -z "$(git -C "$B" status --porcelain)"
cd "$B/clocks"
{ hostname; uname -srm; rustc -Vv; cat /proc/sys/kernel/perf_event_paranoid; } > "$O/host.txt"
cargo build --release --locked --example events_check > "$O/build.txt" 2>&1
# The clocks crate is a workspace member: its build lands in the root target.
"$B/target/release/examples/events_check" > "$O/events-check.txt" 2>&1 || { status=$?; cp "$O/events-check.txt" "$O/events-check-failed.txt"; exit "$status"; }
cargo nextest run --release --locked -P machine > "$O/machine-profile.txt" 2>&1
printf 'DONE: counters read on this host; machine profile beside it\n'
