#!/bin/sh
# Build b3sum contenders for `bench-hashes b3sum` into DIR, each named for what it is:
#   sh tools/b3sum-contenders.sh FORK DIR [COMMIT...]
# FORK is a checkout of github.com/johnservil/BLAKE3.
# DIR/b3sum-official-1.8.2  official BLAKE3's b3sum from crates.io
# DIR/b3sum-COMMIT          the fork's b3sum at each COMMIT (default: FORK's HEAD),
#                           built from a clean worktree of that commit as its
#                           README recommends: statically linked on Linux
# Each b3sum is built as its own project recommends (official's from
# crates.io, as `cargo install b3sum` builds it); on Linux, the fork's static
# link alone makes each of its runs about 240 us shorter (METHODOLOGY, b3sum).
# and, where it is installed, the system's sha256sum (GNU coreutils), for
# the hash programs already use.
# With LAYOUTS=N (default 1), each b3sum is also relinked N times, its functions
# in a random order each time (seed i, lld's --symbol-ordering-file, as the
# fork's perf_regress relinks the library), DIR/...-L0 to -L(N-1): a binary's
# layout alone moves its times by several percent, so a program's cells
# should not rest on one layout's luck. bench-hashes b3sum runs a contender
# named more than once one build a round.
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
layouts=${LAYOUTS:-1}
# The fork's b3sum as its README recommends: statically linked on Linux.
case "$host" in
    *-linux-gnu) static="-C target-feature=+crt-static" ;;
    *) static="" ;;
esac
# relink NAME MANIFEST BUILT_BINARY [RUSTFLAGS]: BUILT-L0... beside it, each
# relinked with its functions in a random order (seed i); prints NAME=PATH lines.
relink() {
    name=$1 manifest=$2 built=$3 flags=${4:-}
    if [ "$layouts" -le 1 ]; then echo "$name=$built"; return; fi
    mkdir -p "$target/lld"
    [ -e "$target/lld/ld.lld" ] || ln -s "$(ls /usr/bin/ld.lld-* | sort -V | tail -1)" "$target/lld/ld.lld"
    symbols="$target/symbols-$(basename "$built")"
    nm "$built" | awk '$2 == "t" || $2 == "T" { print $3 }' | sort -u > "$symbols"
    i=0
    while [ "$i" -lt "$layouts" ]; do
        out="$built-L$i"
        if [ ! -x "$out" ]; then
            order="$target/order-$(basename "$built")-$i"
            awk -v seed="$i" 'BEGIN { srand(seed + 1) } { print rand() "\t" $0 }' "$symbols" | sort -k1,1 | cut -f2 > "$order"
            RUSTFLAGS="$flags" CARGO_TARGET_DIR="$target/relink-$(basename "$built")" cargo rustc --quiet --release --locked --manifest-path "$manifest" --bin b3sum --target "$host" -- \
                -Clink-arg=-fuse-ld=lld "-Clink-arg=-B$target/lld" "-Clink-arg=-Wl,--symbol-ordering-file=$order" -Clink-arg=-Wl,--no-warn-symbol-ordering
            cp "$target/relink-$(basename "$built")/$host/release/b3sum" "$out"
        fi
        echo "$name=$out"
        i=$((i + 1))
    done
}
if [ ! -x "$dir/b3sum-official-1.8.2" ]; then
    CARGO_TARGET_DIR="$target/official" cargo install --quiet --locked b3sum --version 1.8.2 --root "$dir/official"
    cp "$dir/official/bin/b3sum" "$dir/b3sum-official-1.8.2"
fi
official_src=$(ls -d "${CARGO_HOME:-$HOME/.cargo}"/registry/src/*/b3sum-1.8.2 | head -1)
args=$(relink official "$official_src/Cargo.toml" "$dir/b3sum-official-1.8.2" | tr '\n' ' ')
for rev in "$@"; do
    commit=$(git -C "$fork" rev-parse --short=7 "$rev^{commit}")
    if [ ! -x "$dir/b3sum-$commit" ]; then
        worktree="$target/worktree-$commit"
        [ -d "$worktree" ] || git -C "$fork" worktree add --detach --quiet "$worktree" "$commit"
        RUSTFLAGS="$static" CARGO_TARGET_DIR="$target/build" cargo build --quiet --release --manifest-path "$worktree/b3sum/Cargo.toml" --target "$host"
        cp "$target/build/$host/release/b3sum" "$dir/b3sum-$commit"
    fi
    args="$args $(relink "fork-$commit" "$target/worktree-$commit/b3sum/Cargo.toml" "$dir/b3sum-$commit" "$static" | tr '\n' ' ')"
done
if sha256sum=$(command -v sha256sum); then
    args="$args sha256sum=$sha256sum"
fi
echo "$args"
