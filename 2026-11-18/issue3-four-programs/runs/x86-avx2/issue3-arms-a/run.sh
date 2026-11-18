#!/bin/sh
# devonjonte/bench-hashes #3: the four-program experiment (Zooko's word, November 18, 2026, 00:40 UTC).
# Declared before running.
#
# One bench-hashes version (0.22, 97c0fbcb) measures every side. check's own builds make four programs:
#   A   library 0.9.0 (bf2da8b9)             B   the 0.10.0 candidate (27eacce3)
#   B2  the candidate, in a scratch clone     P   that clone's working tree with a planted slowdown
#       (25 dependent multiply-adds on every one-shot call of 256 bytes or less)
# A cc placed first on PATH keeps each side's last link (its arguments, and the inputs rustc deletes), and
# every pair of runs then gets a fresh function order for each side by linking again from what was kept.
# Comparisons, regress's own rule, calibration and pinning, a new layout a side a pair. Each takes 16
# pairs over the ten disputed cells, then 48 more pairs over the four cells after other work alone (the
# cells after a pause settle in the 16; the others need about 64 to show 5%):
#   null     B against B, other layouts          every mark is a false alarm
#   plant    P against B2                        every planted cell left level is a miss
#                                                (single-node machines; the two-node one spends that time on far)
#   release  B against A                         the 0.10.0 question in the disputed small cells
#   far      (machines with two memory nodes, 16 pairs) each program with its file on the far node,
#            against the same bytes on the near node: what memory placement alone does
# On a machine with two memory nodes each pair's two programs are written from the node of that pair's CPU.
# Run names: ...-a runs build, null, plant; ...-b runs release, far, clean.
set -eu
export PATH="$HOME/.cargo/bin:$PATH"
O=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
RUN=${O##*/}
if [ "${BOUNDED_ARMS:-}" != yes ]; then
  export BOUNDED_ARMS=yes
  status=0
  timeout --kill-after=30s "${ARMS_BOUND:-5400}s" sh "$0" || status=$?
  printf 'ARMS_EXIT=%s UTC=%s\n' "$status" "$(date -u +%FT%TZ)"
  exit "$status"
fi
export CARGO_BUILD_JOBS="${CARGO_BUILD_JOBS:-8}" CARGO_INCREMENTAL=0
unset CARGO_TARGET_DIR RUSTFLAGS CARGO_ENCODED_RUSTFLAGS
B="${ARMS_BENCH:-$HOME/work/bench-022}"
M="${ARMS_LIB:-$HOME/work/lib-release-023}"
W="${ARMS_WORK:-$HOME/work/issue3-arms}"
POINTS="${ARMS_POINTS:-idle 64 B,idle 128 B,idle 256 B,64 B,128 B}"
PAIRS="${ARMS_PAIRS:-16}"
MORE_PAIRS="${ARMS_MORE_PAIRS:-48}"
MORE_POINTS="${ARMS_MORE_POINTS:-64 B,128 B}"
TWO_NODES=no
[ "$(ls -d /sys/devices/system/node/node[0-9]* 2> /dev/null | wc -l)" = 2 ] && TWO_NODES=yes
PHASES="${ARMS_PHASES:-}"
BENCH_REV=97c0fbcbedb8fe8f8395115647684dfde75d67a3
OLD_LIB=bf2da8b957f5e0c80babb57952de3e53f95c921a
NEW_LIB=27eacce3a5c2e03043f4fcd347c178a80f9d911c
case "$RUN" in
  *-a) : "${PHASES:=build null plant}" ;;
  *-b) : "${PHASES:=release far clean}" ;;
esac
test -n "$PHASES"
stamp() { printf '%s %s\n' "$(date -u +%T)" "$*" | tee -a "$O/progress.txt"; }

helpers() {
  mkdir -p "$W/bin"
  cat > "$W/bin/cc" <<'PY'
#!/usr/bin/env python3
"""cc, standing in front of the real one. A link that carries a symbol ordering file (check's relink of a
side) is kept, under RELINK_KEEP/<side>: its arguments, and copies of the inputs rustc deletes afterwards.
Then the real cc runs with the arguments as given. Every other call passes straight through."""
import json, os, re, shutil, sys
args = sys.argv[1:]
real = os.environ["RELINK_REAL_CC"]
keep = os.environ.get("RELINK_KEEP")
order = next((a.split("=", 1)[1] for a in args if a.startswith("-Wl,--symbol-ordering-file=")), None)
if keep and order and "-o" in args:
    try:
        side = os.path.basename(os.path.dirname(order))  # .../check/old/order-7.txt: old
        dest, part = os.path.join(keep, side), os.path.join(keep, side + ".part")
        shutil.rmtree(part, ignore_errors=True)
        os.makedirs(part)
        logged, n = [], 0
        for a in args:
            for path in sorted(set(re.findall(r"/[^,=]+", a)), key=len, reverse=True):
                if os.path.isfile(path) and (path.endswith(".o") or re.search(r"/rustc\w{6}/", path)):
                    name = f"{n:03d}-{os.path.basename(path)}"
                    shutil.copyfile(path, os.path.join(part, name))
                    a, n = a.replace(path, "@KEEP@/" + name), n + 1
            logged.append(a)
        link = {"args": logged, "order": order, "out": args[args.index("-o") + 1], "cwd": os.getcwd()}
        json.dump(link, open(os.path.join(part, "link.json"), "w"), indent=0)
        shutil.rmtree(dest, ignore_errors=True)
        os.rename(part, dest)
    except Exception as error:  # the build goes on; the missing capture stops the job at its check
        sys.stderr.write(f"cc in front: nothing kept: {error}\n")
os.execv(real, [real] + args)
PY
  chmod +x "$W/bin/cc"
  cat > "$W/arms.py" <<'PY'
#!/usr/bin/env python3
"""The experiment's programs, made from the kept links.
  verify CAPTURE...                       each kept link, linked again as it was, equals check's executable
  make NAME CAPTURE FIRST COUNT DIR MODE  COUNT programs, layouts FIRST.., for pairs 0..; MODE near or far
  pins KEPT_DIR MANIFEST                  each pair's CPU against the node its programs were written on"""
import glob, hashlib, json, mmap, os, random, re, subprocess, sys

REAL_CC = os.environ["RELINK_REAL_CC"]
ALL_CPUS = os.sched_getaffinity(0)


def cpu_nodes():
    nodes = {}
    for d in sorted(glob.glob("/sys/devices/system/node/node[0-9]*")):
        node = int(d.rsplit("node", 1)[1])
        for part in open(d + "/cpulist").read().strip().split(","):
            if part:
                a, _, b = part.partition("-")
                for cpu in range(int(a), int(b or a) + 1):
                    nodes[cpu] = node
    return nodes


NODES = cpu_nodes()
NODE_COUNT = len(set(NODES.values())) or 1


def relink(capture, order, out):
    link = json.load(open(os.path.join(capture, "link.json")))
    args = [a.replace("@KEEP@", capture) for a in link["args"]]
    args[args.index("-o") + 1] = out
    hits = [k for k, a in enumerate(args) if a.startswith("-Wl,--symbol-ordering-file=")]
    assert len(hits) == 1, hits
    if order is not None:
        args[hits[0]] = "-Wl,--symbol-ordering-file=" + order
    cwd = link["cwd"] if os.path.isdir(link["cwd"]) else None
    subprocess.run([REAL_CC] + args, check=True, cwd=cwd)


def checks_executable(capture):
    """The executable check kept for the kept link's own order file: .../old/order-7.txt, bench-hashes-7."""
    order = json.load(open(os.path.join(capture, "link.json")))["order"]
    seed = re.fullmatch(r"order-(\d+)\.txt", os.path.basename(order)).group(1)
    return os.path.join(os.path.dirname(order), f"bench-hashes-{seed}")


def page_nodes(path):
    """Pages of the file by memory node, as this process maps them; {} where the kernel does not say."""
    try:
        with open(path, "rb") as f, mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as pages:
            sum(pages[i] for i in range(0, len(pages), 4096))
            lines = [l for l in open("/proc/self/numa_maps") if os.path.realpath(path) in l]
            if len(lines) != 1:
                return {}
            return {int(n): int(p) for n, p in re.findall(r"\bN(\d+)=(\d+)", lines[0])}
    except OSError:
        return {}


def show(nodes):
    return ",".join(f"N{n}={p}" for n, p in sorted(nodes.items())) or "-"


def functions(exe):
    """As check's functions_named: nm's t and T lines of three fields, each name once, sorted."""
    out = subprocess.run(["nm", exe], check=True, capture_output=True, text=True).stdout
    return sorted({f[2] for f in (l.split() for l in out.splitlines()) if len(f) == 3 and f[1] in "tT"})


def verify(captures):
    ok = True
    for capture in captures:
        target = checks_executable(capture)
        again = os.path.join(capture, "linked-again")
        relink(capture, None, again)
        same = open(again, "rb").read() == open(target, "rb").read()
        ok &= same
        digest = hashlib.sha256(open(target, "rb").read()).hexdigest()
        print(f"{capture}\tlinked again equals {target}: {same}\tsha256 {digest}")
        os.remove(again)
        names = functions(target)
        open(os.path.join(capture, "symbols.txt"), "w").write("\n".join(names) + "\n")
        print(f"{capture}\t{len(names)} functions to order")
        for exe in sorted(glob.glob(os.path.join(os.path.dirname(target), "bench-hashes-[0-9]*"))):
            print(f"check's own\t{exe}\tpages {show(page_nodes(exe))}")
    sys.exit(0 if ok else 1)


def pair_node(pair):
    """The memory node of pair's CPU on the two-node machine measured so far (EPYC 7443: regress takes
    eight pairs on one socket, then eight on the other); `pins` checks it against the kept runs."""
    return (pair // 8) % 2


def make(name, capture, first, count, directory, mode):
    names = open(os.path.join(capture, "symbols.txt")).read().split()
    paths = []
    for pair in range(count):
        layout = first + pair
        order = os.path.join(directory, f"{name}-{pair}.order")
        shuffled = names[:]
        random.Random(f"{os.path.basename(capture)}:{layout}").shuffle(shuffled)
        open(order, "w").write("\n".join(shuffled) + "\n")
        final = os.path.join(directory, f"{name}-{pair}")
        cpu, nodes = "-", {}
        if NODE_COUNT == 2:
            node = pair_node(pair) if mode == "near" else 1 - pair_node(pair)
            cpu = min(c for c, n in NODES.items() if n == node and c in ALL_CPUS)
            os.sched_setaffinity(0, {cpu})
            relink(capture, order, final + ".linked")
            data = open(final + ".linked", "rb").read()
            os.remove(final + ".linked")
            with open(final, "xb") as f:  # written whole by this pinned process: its pages are this node's
                f.write(data)
                f.flush()
                os.fsync(f.fileno())
            os.chmod(final, 0o755)
            nodes = page_nodes(final)
            os.sched_setaffinity(0, ALL_CPUS)
            assert nodes and set(nodes) == {node}, (final, node, nodes)
        else:
            relink(capture, order, final)
        os.remove(order)
        digest = hashlib.sha256(open(final, "rb").read()).hexdigest()
        print(f"{name}\t{pair}\t{layout}\t{mode}\t{cpu}\t{show(nodes)}\t{os.path.getsize(final)}\t{digest}\t{final}")
        paths.append(final)
    open(os.path.join(directory, name + ".list"), "w").write("\n".join(paths) + "\n")


def pins(kept, manifest):
    def pin(path):
        for line in open(path):
            m = re.search(r"pinned to CPU (\d+)", line)
            if m:
                return int(m.group(1))
            if not line.startswith("#"):
                return None
    files = sorted(glob.glob(os.path.join(kept, "run-*.tsv")))
    cpus = [pin(f) for f in files]
    pairs = [cpus[i:i + 2] for i in range(0, len(cpus), 2)]
    print(f"pairs {len(pairs)}; CPUs by pair: {' '.join(str(p[0]) for p in pairs)}")
    print(f"both runs of every pair on one CPU: {all(len(set(p)) == 1 for p in pairs)}")
    if NODE_COUNT != 2:
        print(f"memory nodes: {NODE_COUNT}; nothing to place")
        return
    rows = [l.rstrip("\n").split("\t") for l in open(manifest)]
    for name in sorted({r[0] for r in rows}):
        mine = {int(r[1]): r for r in rows if r[0] == name}
        near = sum(1 for k, p in enumerate(pairs) if p[0] is not None and show({NODES[p[0]]: 0}).split("=")[0] == mine[k][5].split("=")[0])
        print(f"{name}: programs on their pair's node in {near} of {len(pairs)} pairs")


if __name__ == "__main__":
    command, rest = sys.argv[1], sys.argv[2:]
    if command == "verify":
        verify(rest)
    elif command == "make":
        make(rest[0], rest[1], int(rest[2]), int(rest[3]), rest[4], rest[5])
    elif command == "pins":
        pins(rest[0], rest[1])
    else:
        sys.exit(__doc__)
PY
}

probe() {  # name, then check's arguments
  name=$1
  shift
  stamp "$name: check builds both sides"
  status=0
  (cd "$B" && PATH="$W/bin:$PATH" RELINK_KEEP="$W/cap-$name" \
    ./target/release/bench-hashes check "$@" --probe '64 B' --when-quiet --keep "$O/kept-probe-$name" \
    > "$O/probe-$name.stdout.txt" 2> "$O/probe-$name.stderr.txt") || status=$?
  echo "probe $name: check exit $status" >> "$O/exit.txt"
  python3 "$W/arms.py" verify "$W/cap-$name/old" "$W/cap-$name/new" > "$O/verify-$name.txt"
  stamp "$name: both kept links reproduce check's executables"
}

compare() {  # name, pairs, points, old list, new list
  name=$1
  driver=$(head -1 "$5")
  stamp "$name: $2 pairs over $3: start"
  status=0
  # shellcheck disable=SC2046
  (cd "$B" && "$driver" regress --pairs "$2" --contenders blake3-servil-st,blake3-servil-mt \
    --points "$3" --keep "$O/kept-$name" $(cat "$4") -- $(cat "$5")) \
    > "$O/$name.stdout.txt" 2> "$O/$name.stderr.txt" || status=$?
  echo "$name: regress exit $status" >> "$O/exit.txt"
  python3 "$W/arms.py" pins "$O/kept-$name" "$O/$name.programs.tsv" > "$O/$name.placement.txt" 2>&1 || true
  stamp "$name: regress exit $status"
}

programs() {  # manifest, name, capture, first layout, count, mode
  python3 "$W/arms.py" make "$2" "$W/cap-$3" "$4" "$5" "$X" "$6" >> "$O/$1.programs.tsv"
}

two_stages() {  # comparison, old capture, new capture, old side's first layout, new side's first layout
  c=$1
  rm -rf "$X" && mkdir -p "$X" && : > "$O/$c.programs.tsv"
  programs "$c" "$c-old" "$2" "$4" "$PAIRS" near
  programs "$c" "$c-new" "$3" "$5" "$PAIRS" near
  compare "$c" "$PAIRS" "$POINTS" "$X/$c-old.list" "$X/$c-new.list"
  rm -rf "$X"
  if [ "$MORE_PAIRS" -gt 0 ]; then
    mkdir -p "$X" && : > "$O/$c-more.programs.tsv"
    programs "$c-more" "$c-more-old" "$2" "$(($4 + PAIRS))" "$MORE_PAIRS" near
    programs "$c-more" "$c-more-new" "$3" "$(($5 + PAIRS))" "$MORE_PAIRS" near
    compare "$c-more" "$MORE_PAIRS" "$MORE_POINTS" "$X/$c-more-old.list" "$X/$c-more-new.list"
    rm -rf "$X"
  fi
}

X="$W/programs"
if [ -f "$W/real-cc" ]; then
  RELINK_REAL_CC=$(cat "$W/real-cc")
  export RELINK_REAL_CC
fi
for phase in $PHASES; do
  case "$phase" in
    build)
      git -C "$B" checkout -q --detach "$BENCH_REV" 2> /dev/null || true
      test "$(git -C "$B" rev-parse HEAD)" = "$BENCH_REV"
      stamp "bench-hashes 0.22: build"
      (cd "$B" && cargo build --release --quiet) > "$O/bench-build.txt" 2>&1
      rm -rf "$W"
      mkdir -p "$W"
      helpers
      command -v cc > "$W/real-cc"
      RELINK_REAL_CC=$(cat "$W/real-cc")
      export RELINK_REAL_CC
      {
        uname -srm
        lscpu | grep -E 'Model name|Socket|NUMA|Thread|Core' || true
        for n in /sys/devices/system/node/node[0-9]*; do echo "$n cpus $(cat "$n/cpulist")"; done
        echo "numa_balancing $(cat /proc/sys/kernel/numa_balancing 2> /dev/null || echo unreadable)"
        echo "governor $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2> /dev/null || echo unreadable)"
        echo "cc $RELINK_REAL_CC; $(cc --version | head -1)"
      } > "$O/machine.txt" 2>&1
      printf 'bench-hashes %s every side\nA library %s\nB library %s\nP its working tree with the plant\n' \
        "$BENCH_REV" "$OLD_LIB" "$NEW_LIB" > "$O/versions.txt"
      probe release --fork "$M" --new "$NEW_LIB" --against "$OLD_LIB"
      if [ "${ARMS_NO_PLANT:-}" != yes ] && [ "$TWO_NODES" = no ]; then
        P="$W/plant-lib"
        if ! { git clone -q "$M" "$P" && git -C "$P" -c advice.detachedHead=false checkout -q --detach "$NEW_LIB"; } 2> /dev/null; then
          rm -rf "$P"
          git -C "$M" worktree add -q --detach "$P" "$NEW_LIB"
        fi
        ITER=25 python3 - "$P/src/lib.rs" <<'PY'
import os, sys
p = sys.argv[1]
s = open(p).read()
anchor = "    let turn = platform::Sme2Turn::take(platform, input.len() >= SME2_SIZED_LEN);\n"
assert s.count(anchor) == 1
plant = anchor + f"""    if input.len() <= 256 {{
        let m = core::hint::black_box(0x9E37_79B9_7F4A_7C15u64);
        let mut x = input.len() as u64 | 1;
        for _ in 0..{int(os.environ['ITER'])} {{
            x = x.wrapping_mul(m).wrapping_add(x >> 7);
        }}
        core::hint::black_box(x);
    }}
"""
open(p, "w").write(s.replace(anchor, plant))
PY
        git -C "$P" diff > "$O/plant.diff"
        test -s "$O/plant.diff"
        probe plant --fork "$P"
      fi
      ;;
    null)
      test -f "$W/cap-release/new/link.json" || { stamp "no kept link here: the build phase (run ...-a) comes first"; exit 3; }
      two_stages null release/new release/new 0 1000
      ;;
    plant)
      if [ "$TWO_NODES" = yes ] && [ "${ARMS_NO_PLANT:-}" != no ]; then
        stamp "plant: left to the single-node machines"
        continue
      fi
      test -f "$W/cap-plant/new/link.json" || { stamp "no kept link here: the build phase (run ...-a) comes first"; exit 3; }
      two_stages plant plant/old plant/new 0 1000
      ;;
    release)
      test -f "$W/cap-release/old/link.json" || { stamp "no kept link here: the build phase (run ...-a) comes first"; exit 3; }
      two_stages release release/old release/new 0 1000
      ;;
    far)
      test -f "$W/cap-release/new/link.json" || { stamp "no kept link here: the build phase (run ...-a) comes first"; exit 3; }
      if [ "$TWO_NODES" = yes ]; then
        rm -rf "$X" && mkdir -p "$X" && : > "$O/far.programs.tsv"
        programs far far-old release/new 0 "$PAIRS" near
        programs far far-new release/new 0 "$PAIRS" far
        compare far "$PAIRS" "$POINTS" "$X/far-old.list" "$X/far-new.list"
        rm -rf "$X"
      else
        stamp "far: one memory node here; nothing to compare"
      fi
      ;;
    clean)
      if [ -d "$W/plant-lib" ] && [ -f "$W/plant-lib/.git" ]; then
        git -C "$M" worktree remove --force "$W/plant-lib" 2> /dev/null || true
      fi
      rm -rf "$W"
      stamp "work directory removed"
      ;;
    *)
      echo "unknown phase $phase"
      exit 2
      ;;
  esac
done
stamp "phases done: $PHASES"
