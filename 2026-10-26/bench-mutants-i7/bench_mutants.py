#!/usr/bin/env python3
"""Benchmark the mutants a survivor list calls speed-only (a prototype,
Zooko's idea, October 26): each one applied alone to a clean worktree of
BASE, and `bench-hashes check --against BASE` over the cells that run its
changed lines. Its verdict sorts the row:

  slower (exit 1)        the path earns its place: speed, measured
  no cell slower (0)     a candidate to delete: correct and as fast either way
  no verdict (2)         the machine was busy: run again

and a "faster" line beside any verdict means the mutant is an improvement.
One mutant at a time (run it under run-bounded.py; it is one heavy job).

    python3 bench_mutants.py FORK BASE OUT 'NAME' ['NAME'...]

FORK: a checkout of the fork (its cargo-mutants lists the mutants); BASE:
the commit both sides start from; NAME: a list row's "file<TAB>mutant".
Every place of a name is measured, each on its own. OUT gets one folder a
place (the check's output and kept samples) and results.tsv.
"""
import json
import os
import subprocess
import sys

FORK, BASE, OUT = sys.argv[1:4]
NAMES = sys.argv[4:]
PAIRS = os.environ.get("PAIRS", "8")
WT = os.path.join(OUT, "worktree")


def sh(*args, **kw):
    return subprocess.run(args, check=True, capture_output=True, text=True, **kw).stdout


def mutants():
    files = sorted({n.split("\t")[0] for n in NAMES})
    args = ["cargo", "mutants", "--list", "--json", "--diff", "--profile", "mutants", "--features", "serde,zeroize"]
    for f in files:
        args += ["--file", f]
    return json.loads(sh(*args, cwd=FORK))


def main():
    os.makedirs(OUT, exist_ok=True)
    if not os.path.exists(WT):
        sh("git", "-C", FORK, "worktree", "add", "-q", "--detach", WT, BASE)
        bench = os.path.join(FORK, "bench-hashes")
        sh("git", "clone", "-q", "--shared", bench, os.path.join(WT, "bench-hashes"))
        sh("git", "-C", os.path.join(WT, "bench-hashes"), "checkout", "-q", "--detach", sh("git", "-C", bench, "rev-parse", "HEAD").strip())
    every = mutants()
    results = open(os.path.join(OUT, "results.tsv"), "a")
    for name in NAMES:
        file, change = name.split("\t")
        places = [m for m in every if m["file"] == file and m["name"].split(": ", 1)[1] == change]
        assert places, f"no mutant named {name!r} in the source"
        for m in places:
            place = m["name"].split(": ", 1)[0].split(":", 1)[1]
            label = f"{os.path.basename(file)}-{place.replace(':', '.')}-{abs(hash(change)) % 10**6}"
            here = os.path.join(OUT, label)
            os.makedirs(here, exist_ok=True)
            open(os.path.join(here, "mutant.diff"), "w").write(m["diff"])
            subprocess.run(["patch", "-s", os.path.join(WT, file)], input=m["diff"], text=True, check=True)
            try:
                run = subprocess.run(["cargo", "run", "-q", "--release", "--", "check", "--against", BASE, "--pairs", PAIRS,
                                      "--keep", os.path.join(here, "samples")],
                                     cwd=os.path.join(WT, "bench-hashes"), capture_output=True, text=True)
            finally:
                sh("git", "-C", WT, "checkout", "-q", "--", file)
            open(os.path.join(here, "check.stdout.txt"), "w").write(run.stdout)
            open(os.path.join(here, "check.stderr.txt"), "w").write(run.stderr)
            verdict = {0: "no cell slower", 1: "slower", 2: "no verdict"}.get(run.returncode, f"error {run.returncode}")
            if "nothing to measure" in run.stdout:
                verdict = "no cell runs it"
            faster = sum(1 for l in run.stdout.splitlines() if l.lstrip().startswith("faster"))
            slower = [l.strip() for l in run.stdout.splitlines() if l.lstrip().startswith("SLOWER")]
            row = [file, change, place, verdict, str(faster), " | ".join(slower)[:300], label]
            results.write("\t".join(row) + "\n")
            results.flush()
            print("\t".join(row[:5]), flush=True)


if __name__ == "__main__":
    main()
