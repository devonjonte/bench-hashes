#!/usr/bin/env python3
"""The mutants of the library's Rust files that no platform's list names, run as a whole
run runs a file's (every mutant, the suite stopping at a mutant's first failure, the
survivors' release builds). Prints each surviving and timed-out name with its count."""
import json, os, sys
root, shards, out = sys.argv[1], int(sys.argv[2]), sys.argv[3]
files = sys.argv[4:]
sys.path.insert(0, os.path.join(root, "tools", "mutants"))
os.chdir(root)
import check
check.remove_leftovers()
found, functions, timed = check.run(files, shards=shards, label="unlisted")
total = sum(len(v) for v in functions.values())
outcomes = {}
for (file, function), rows in functions.items():
    for summary, name in rows:
        outcomes.setdefault(summary, []).append(name)
result = dict(files=files, mutants=total, survivors=dict(found), timeouts=dict(timed),
              by_outcome={k: len(v) for k, v in outcomes.items()},
              same_code={k: check.SAME["unlisted"][k] for k in found if check.SAME["unlisted"][k]},
              same_in_release={k: check.RELEASE_SAME["unlisted"][k] for k in found if check.RELEASE_SAME["unlisted"][k]})
with open(out, "w") as f:
    json.dump(result, f, indent=1)
print(json.dumps(result, indent=1))
