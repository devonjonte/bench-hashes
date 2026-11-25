#!/usr/bin/env python3
"""Nightly cumulative-drift check (last stable release -> next) for Linux hosts.

Extends bench-hashes #241 from Mac to bare-metal Linux measurement hosts:
resolves the exact base (default `refs/heads/main`) and target (default
`refs/heads/next`) commits in BLAKE3-Servil, deduplicates by commit hashes
rather than timestamps, and either prints or submits (`bench-submit`) a
self-contained `bench-hashes check --cells all --when-quiet` job that also
emits a Markdown summary with hardware-counter ratios (`compare --markdown`).
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
import subprocess
import sys
import tempfile
from pathlib import Path

DEFAULT_FORK_URL = "https://github.com/servil-software-factory/BLAKE3.git"
DEFAULT_BENCH_URL = "https://github.com/servil-software-factory/bench-hashes.git"
DEFAULT_HOSTS = ("x86-9700x", "x86-epyc-9255", "x86-icelake", "x86-avx2")
HEX40 = re.compile(r"^[0-9a-f]{40}$")


def validate_sha(value: str, label: str) -> str:
    value = value.strip()
    if not HEX40.match(value):
        raise ValueError(f"{label} must be a 40-char lowercase hex commit SHA, got {value!r}")
    return value


def parse_ls_remote(output: str, ref: str) -> str:
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 2 and parts[1] == ref:
            return validate_sha(parts[0], ref)
    raise RuntimeError(f"ref {ref!r} not found in git ls-remote output")


def resolve_commits(
    repo: str,
    base_ref: str = "refs/heads/main",
    target_ref: str = "refs/heads/next",
) -> tuple[str, str]:
    out = subprocess.check_output(
        ["git", "ls-remote", repo, base_ref, target_ref],
        text=True,
    )
    return parse_ls_remote(out, base_ref), parse_ls_remote(out, target_ref)


def run_name(base_sha: str, target_sha: str, prefix: str = "drift") -> str:
    base = validate_sha(base_sha, "base_sha")
    target = validate_sha(target_sha, "target_sha")
    return f"{prefix}-{base[:8]}-{target[:8]}"


def already_ran(inbox_dir: Path, host: str, base_sha: str, target_sha: str) -> bool:
    """True when inbox/<host>/<run_name>/summary.md already exists."""
    name = run_name(base_sha, target_sha)
    host_dir = inbox_dir / host
    if not host_dir.is_dir():
        return False
    return (host_dir / name / "summary.md").is_file()


def render_host_script(
    *,
    bench_url: str,
    bench_ref: str,
    fork_url: str,
    base_sha: str,
    target_sha: str,
    cells: str = "all",
    layouts: int | None = None,
) -> str:
    base = validate_sha(base_sha, "base_sha")
    target = validate_sha(target_sha, "target_sha")
    if layouts is not None and layouts < 3:
        raise ValueError(f"layouts must be >= 3, got {layouts}")
    extra_layouts = f" --layouts {layouts}" if layouts is not None else ""
    q_bench_url = shlex.quote(bench_url)
    q_bench_ref = shlex.quote(bench_ref)
    q_fork_url = shlex.quote(fork_url)
    q_cells = shlex.quote(cells)
    return f"""#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/.cargo/bin:$PATH"

WORK="$HOME/work"
BENCH="$WORK/bench-drift"
FORK="$WORK/lib-drift"
mkdir -p "$WORK"

if [ ! -d "$BENCH/.git" ]; then
  git clone {q_bench_url} "$BENCH"
fi
git -C "$BENCH" fetch --quiet origin {q_bench_ref}
git -C "$BENCH" checkout --quiet --force --detach FETCH_HEAD
git -C "$BENCH" clean -fdq

if [ ! -d "$FORK/.git" ]; then
  git clone {q_fork_url} "$FORK"
fi
git -C "$FORK" fetch --quiet origin main next
git -C "$FORK" checkout --quiet --force --detach {target}
git -C "$FORK" clean -fdq

BENCH_SHA="$(git -C "$BENCH" rev-parse HEAD)"
echo "nightly-drift: host=$(hostname) bench=$BENCH_SHA base={base} target={target}"

(cd "$BENCH" && cargo build --release --locked --quiet)
EXE="$BENCH/target/release/bench-hashes"
KEEP="$PWD/kept-drift"
rm -rf "$KEEP"

set +e
(cd "$BENCH" && "$EXE" check --fork "$FORK" --against {base} --new {target} --cells {q_cells}{extra_layouts} --when-quiet --keep "$KEEP")
RC=$?
set -e

case "$RC" in
  0) VERDICT="no regression" ;;
  1) VERDICT="REGRESSION" ;;
  2) VERDICT="abstained (busy or unobserved load)" ;;
  *) VERDICT="stopped (exit $RC)" ;;
esac

{{
  echo "# Nightly drift check: {base[:12]} -> {target[:12]}"
  echo ""
  echo "- Host: $(hostname)"
  echo "- bench-hashes: \\`$BENCH_SHA\\`"
  echo "- BLAKE3-Servil base: \\`{base}\\`"
  echo "- BLAKE3-Servil target: \\`{target}\\`"
  echo "- Scope: \\`--cells {cells}\\`"
  echo "- Verdict: **$VERDICT** (exit \\`$RC\\`)"
  echo ""
  if ls "$KEEP"/run-*-old.tsv >/dev/null 2>&1 && ls "$KEEP"/run-*-new.tsv >/dev/null 2>&1; then
    "$EXE" compare --markdown "$KEEP"/run-*-old.tsv -- "$KEEP"/run-*-new.tsv
  fi
}} > summary.md

echo "nightly-drift: verdict=$VERDICT (exit $RC)"
exit "$RC"
"""


def parse_args(argv: list[str]) -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--fork-url", default=DEFAULT_FORK_URL)
    p.add_argument("--bench-url", default=DEFAULT_BENCH_URL)
    p.add_argument("--bench-ref", default="next")
    p.add_argument("--base-ref", default="refs/heads/main")
    p.add_argument("--target-ref", default="refs/heads/next")
    p.add_argument("--base-sha", help="explicit 40-char base commit SHA")
    p.add_argument("--target-sha", help="explicit 40-char target commit SHA")
    p.add_argument("--cells", default="all", help="scope passed to check --cells (default: all)")
    p.add_argument("--layouts", type=int, default=None, help="optional --layouts override (>= 3)")
    p.add_argument("--print-script", action="store_true", help="print generated run.sh to stdout")
    p.add_argument(
        "--submit",
        help="comma-separated measurement hosts to submit via bench-submit (or 'default')",
    )
    p.add_argument(
        "--bench-submit",
        default=os.path.expanduser("~/bin/bench-submit"),
        help="path to bench-submit helper",
    )
    p.add_argument(
        "--inbox",
        default=os.path.expanduser("~/bench-hashes-validation/inbox"),
        help="inbox directory used to skip already-completed (base, target) runs",
    )
    p.add_argument("--force", action="store_true", help="submit even if (base, target) already ran")
    return p.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(sys.argv[1:] if argv is None else argv)
    if args.base_sha and args.target_sha:
        base_sha = validate_sha(args.base_sha, "--base-sha")
        target_sha = validate_sha(args.target_sha, "--target-sha")
    else:
        resolved_base, resolved_target = resolve_commits(
            args.fork_url, args.base_ref, args.target_ref
        )
        base_sha = validate_sha(args.base_sha, "--base-sha") if args.base_sha else resolved_base
        target_sha = (
            validate_sha(args.target_sha, "--target-sha") if args.target_sha else resolved_target
        )

    if base_sha == target_sha and not args.force:
        print(f"nightly-drift: base and target match ({base_sha[:12]}); nothing to measure")
        return 0

    script = render_host_script(
        bench_url=args.bench_url,
        bench_ref=args.bench_ref,
        fork_url=args.fork_url,
        base_sha=base_sha,
        target_sha=target_sha,
        cells=args.cells,
        layouts=args.layouts,
    )
    if args.print_script or not args.submit:
        sys.stdout.write(script)
        return 0

    hosts = (
        list(DEFAULT_HOSTS)
        if args.submit == "default"
        else [h.strip() for h in args.submit.split(",") if h.strip()]
    )
    if not hosts:
        raise ValueError("--submit requires at least one host")
    name = run_name(base_sha, target_sha)
    inbox = Path(args.inbox)
    with tempfile.NamedTemporaryFile("w", prefix="nightly-drift-", suffix=".sh", delete=False) as f:
        f.write(script)
        script_path = f.name
    try:
        for host in hosts:
            if not args.force and already_ran(inbox, host, base_sha, target_sha):
                print(f"nightly-drift: skip {host}:{name} (already completed in {inbox / host / name})")
                continue
            subprocess.run([args.bench_submit, host, name, script_path], check=True)
    finally:
        os.unlink(script_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
