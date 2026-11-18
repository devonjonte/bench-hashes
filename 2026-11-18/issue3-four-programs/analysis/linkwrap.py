#!/usr/bin/env python3
"""A linker driver that keeps what a relink needs: the argument list, and
copies of the inputs rustc deletes after the link (its objects, its
temporary directory's files). Then it runs cc with the arguments as given."""
import json, os, re, shutil, sys
keep = os.environ["RELINK_KEEP"]
os.makedirs(keep, exist_ok=True)
args, logged, n = sys.argv[1:], [], 0
for a in args:
    for path in sorted(set(re.findall(r"/[^,=]+", a)), key=len, reverse=True):
        if os.path.isfile(path) and (path.endswith(".o") or re.search(r"/rustc\w{6}/", path)):
            dest = os.path.join(keep, f"{n:03d}-{os.path.basename(path)}")
            shutil.copyfile(path, dest)
            a, n = a.replace(path, dest), n + 1
    logged.append(a)
json.dump(logged, open(os.path.join(keep, "link-args.json"), "w"), indent=0)
os.execvp("cc", ["cc"] + args)
