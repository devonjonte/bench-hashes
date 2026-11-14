#!/bin/sh
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O="$HOME/runs/samecode-noop-efe3dac3"
export O
if [ "${BOUNDED_SAMECODE_NOOP:-}" != yes ]; then
    export BOUNDED_SAMECODE_NOOP=yes
    status=0
    timeout --kill-after=15s 1800s sh "$O/run.sh" || status=$?
    printf 'BUILD_CONTROL_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
    exit "$status"
fi
export CARGO_BUILD_JOBS=2 CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR
C=efe3dac3d74426053371be0c9bcf9c4dc1950ad9
BASE=60e0f7206902a8be45b27754643d447ddc2a0553
OLD=f62bc6ac0bc1c86861659d61ffbf4e9546bc8aec
NEW=9c0ebbbce7cf0102c648b021b2395e7784b9a189
B="$HOME/work/bench-devon-samecode-noop-efe3"
M="$HOME/work/lib-devon-samecode-noop-efe3"
export C BASE OLD NEW B M
command -v b3sum >/dev/null
git -C "$HOME/work/bench-hashes" fetch --all --tags
git -C "$HOME/work/BLAKE3" fetch --all --tags
git -C "$HOME/work/bench-hashes" worktree add --detach "$B" "$C"
git -C "$HOME/work/BLAKE3" worktree add --detach "$M" "$OLD"
git -C "$M" diff --name-only "$OLD" "$NEW" > "$O/library-files.txt"
python3 - <<'PY'
import os,pathlib
p=pathlib.Path(os.environ['O'])/'library-files.txt'
assert set(p.read_text().splitlines())=={'AGENTS.md','b3sum/src/linux_pipe.rs','b3sum/src/main.rs'}
PY
cd "$B"
{
    printf 'bench %s\nold %s\nnew %s\n' "$C" "$OLD" "$NEW"
    rustc -Vv
    cc --version
    printf 'RUSTFLAGS=%s\n' "${RUSTFLAGS-}"
} > "$O/toolchain.txt"
CARGO_TARGET_DIR="$B/target" cargo build --release --locked > "$O/builder.stdout.txt" 2> "$O/builder.stderr.txt"
for side in old new; do
    case "$side" in old) revision=$OLD;; new) revision=$NEW;; esac
    git -C "$M" checkout --detach "$revision"
    test -z "$(git -C "$M" status --porcelain)"
    ./target/release/bench-hashes build-against "$M" > "$O/$side-path.txt" 2> "$O/$side-build.txt"
    exe=$(tail -n 1 "$O/$side-path.txt")
    cp "$exe" "$M/target/samecode-$side"
    "$M/target/samecode-$side" provenance > "$O/$side-provenance.txt"
done
python3 - <<'PY'
import os,pathlib
out=pathlib.Path(os.environ['O'])
for side,revision in [('old',os.environ['OLD']),('new',os.environ['NEW'])]:
 p=(out/f'{side}-provenance.txt').read_text().strip()
 assert p==f"bench {os.environ['C'][:12]} clean; servil {revision[:12]} clean",p
PY
sha256sum "$M/target/samecode-old" "$M/target/samecode-new" > "$O/executable-SHA256SUMS"
b3sum "$M/target/samecode-old" "$M/target/samecode-new" > "$O/executable-BLAKE3SUMS"
sha256sum --check --quiet "$O/executable-SHA256SUMS"
b3sum --check --quiet "$O/executable-BLAKE3SUMS" >/dev/null
for reader in old new; do
    mkdir "$O/$reader-reader"
    case "$reader" in old) rev=$BASE; extra=', true';; new) rev=$C; extra='';; esac
    git show "$rev:src/samecode.rs" > "$O/$reader-reader/samecode.rs"
    printf '%s\n' 'mod samecode;' 'fn main() {' '    let a: Vec<_> = std::env::args().collect();' '    let masks = [a[3].as_str(), a[4].as_str(), &a[3][..12], &a[4][..12]];' "    println!(\"{:?}\", samecode::compare(std::path::Path::new(&a[1]), std::path::Path::new(&a[2]), &masks$extra));" '}' > "$O/$reader-reader/main.rs"
    rustc --edition=2024 "$O/$reader-reader/main.rs" -o "$M/target/reader-$reader"
    "$M/target/reader-$reader" "$M/target/samecode-old" "$M/target/samecode-new" "$OLD" "$NEW" > "$O/$reader-verdict.txt"
done
printf 'DONE %s: build-only control; no performance collection\n' "$(date -u +%FT%TZ)"
