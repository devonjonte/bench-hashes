#!/bin/sh
# Build b3sum contenders for `bench-hashes b3sum` into DIR, each named for what it is:
#   sh tools/b3sum-contenders.sh FORK DIR [COMMIT...]
# FORK is a checkout of github.com/johnservil/BLAKE3.
# DIR/b3sum-official-1.8.2  official BLAKE3's b3sum from crates.io
# DIR/b3sum-COMMIT          the fork's b3sum at each COMMIT (default: FORK's HEAD),
#                           built from a clean worktree of that commit as its
#                           README recommends: statically linked on Linux
# sha256sum                 GNU coreutils' sha256sum, where installed, for the
#                           hash programs already use: found by its --version,
#                           as sha256sum or gnusha256sum (some systems name
#                           another implementation sha256sum, uutils on Ubuntu)
# Each b3sum is built as its own project recommends (official's from
# crates.io, as `cargo install b3sum` builds it); on Linux, the fork's static
# link alone makes each of its runs about 240 us shorter (METHODOLOGY, b3sum).
# Prints a line of NAME=PATH arguments for bench-hashes b3sum, official first.
set -eu
fork=$(cd "$1" && git rev-parse --show-toplevel)
dir=$2
shift 2
[ $# -gt 0 ] || set -- HEAD
mkdir -p "$dir"
dir=$(cd "$dir" && pwd)
target=${CARGO_TARGET_DIR:-$fork/target}/b3sum-contenders
host=$(rustc -vV | sed -n 's/^host: //p')
if [ ! -x "$dir/b3sum-official-1.8.2" ]; then
    CARGO_TARGET_DIR="$target/official" cargo install --quiet --locked b3sum --version 1.8.2 --root "$dir/official"
    cp "$dir/official/bin/b3sum" "$dir/b3sum-official-1.8.2"
fi
args="official=$dir/b3sum-official-1.8.2"
for rev in "$@"; do
    commit=$(git -C "$fork" rev-parse --short=7 "$rev^{commit}")
    if [ ! -x "$dir/b3sum-$commit" ]; then
        worktree="$target/worktree-$commit"
        [ -d "$worktree" ] || git -C "$fork" worktree add --detach --quiet "$worktree" "$commit"
        case "$host" in
            *-linux-gnu) static="-C target-feature=+crt-static" ;;
            *) static="" ;;
        esac
        RUSTFLAGS="$static" CARGO_TARGET_DIR="$target/build" cargo build --quiet --release --manifest-path "$worktree/b3sum/Cargo.toml" --target "$host"
        cp "$target/build/$host/release/b3sum" "$dir/b3sum-$commit"
    fi
    args="$args fork-$commit=$dir/b3sum-$commit"
done
for name in sha256sum gnusha256sum; do
    if path=$(command -v "$name") && "$path" --version 2>/dev/null | head -n 1 | grep -q 'GNU coreutils'; then
        args="$args sha256sum=$path"
        break
    fi
done
echo "$args"
