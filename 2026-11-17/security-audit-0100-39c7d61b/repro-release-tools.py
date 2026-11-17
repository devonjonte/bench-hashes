#!/usr/bin/env python3
"""Minimal local reproductions for BLAKE3 #438 and #439 against release_artifacts.py."""
import io, json, os, subprocess, sys, tarfile, tempfile

TOOLS = sys.argv[1] if len(sys.argv) > 1 else "<BLAKE3>/tools"
sys.path.insert(0, TOOLS)
import release_artifacts as ra


def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write(text)


def git(cwd, *args):
    return subprocess.run(["git", "-C", cwd, *args], check=True, capture_output=True, text=True).stdout.strip()


with tempfile.TemporaryDirectory() as d:
    repo = os.path.join(d, "repo")
    clone = os.path.join(d, "clone")
    os.makedirs(repo)
    git(repo, "init", "-q", "-b", "main")
    git(repo, "config", "user.name", "t")
    git(repo, "config", "user.email", "t@t")
    for p, txt in [
        ("Cargo.toml", '[package]\nname = "top"\nversion = "0.9.0+dev"\n'),
        ("version/Cargo.toml", '[package]\nname = "blake3-servil-version"\nversion = "0.9.0+dev"\n'),
        ("threads/Cargo.toml", '[package]\nname = "blake3-servil"\nversion = "0.9.0+dev"\n'),
        ("b3sum/Cargo.toml", '[package]\nname = "b3sums"\nversion = "0.9.0+dev"\n'),
        ("b3sum/src/lib.rs", "pub fn f() {}\n"),
    ]:
        write(os.path.join(repo, p), txt)
    git(repo, "add", ".")
    git(repo, "commit", "-qm", "code")
    code = git(repo, "rev-parse", "HEAD")
    ver = f"0.10.0+{code}"
    for p in ("Cargo.toml", "version/Cargo.toml", "threads/Cargo.toml", "b3sum/Cargo.toml"):
        fp = os.path.join(repo, p)
        write(fp, open(fp).read().replace("0.9.0+dev", ver))
    git(repo, "add", ".")
    git(repo, "commit", "-qm", f"Version {ver}")
    tag = f"v{ver}"
    git(repo, "tag", tag)

    os.makedirs(clone)
    git(clone, "init", "-q")
    git(clone, "remote", "add", "origin", repo)
    git(clone, "fetch", "-q", "origin", f"+refs/tags/{tag}:refs/tags/{tag}")
    git(clone, "checkout", "-q", tag)
    rel = ra.Release(tag, clone)
    print("438_on_main_after_tag_checkout:", repr(rel.on_main()))

    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        def add(name, data):
            ti = tarfile.TarInfo(name)
            ti.size = len(data)
            tf.addfile(ti, io.BytesIO(data))

        add("evil_root_file", b"arbitrary payload\n")
        add(f"b3sums-{ver}/src/lib.rs", b"pub fn backdoor() {}\n")
        add(f"b3sums-{ver}/src/lib.rs", b"pub fn f() {}\n")
        add(f"b3sums-{ver}/Cargo.toml.orig", open(os.path.join(repo, "b3sum/Cargo.toml"), "rb").read())
        add(f"b3sums-{ver}/.cargo_vcs_info.json", json.dumps({"git": {"sha1": rel.commit}, "path_in_vcs": "b3sum"}).encode())
    print("439_crate_problems_evil_and_dup:", ra.crate_problems(buf.getvalue(), rel))

    git(repo, "checkout", "-q", code)
    write(os.path.join(repo, "README.md"), "version 0.9.0+dev here\n")
    git(repo, "add", "README.md")
    git(repo, "commit", "-qm", "code2")
    code2 = git(repo, "rev-parse", "HEAD")
    ver2 = f"0.10.0+{code2}"
    for p in ("Cargo.toml", "version/Cargo.toml", "threads/Cargo.toml", "b3sum/Cargo.toml"):
        fp = os.path.join(repo, p)
        write(fp, open(fp).read().replace("0.9.0+dev", ver2))
    write(os.path.join(repo, "README.md"), f"version {ver2}{ver2} here\n")
    git(repo, "add", ".")
    git(repo, "commit", "-qm", f"Version {ver2}")
    v2 = git(repo, "rev-parse", "HEAD")
    git(repo, "tag", f"v{ver2}")
    rel2 = ra.Release(f"v{ver2}", repo, commit=v2)
    print("439_stamp_problems_duplicated:", rel2.stamp_problems(code2))
