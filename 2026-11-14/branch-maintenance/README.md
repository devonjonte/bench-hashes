# Conservative branch-maintenance proposal

November 14, 2026. Question: which old candidate names can be removed while
keeping their code and benchmark evidence available?

**Completed at 08:03 UTC.** The 37 proposed references were removed: two
in the maintained repository and 35 in Devon's fork. [The original list](PROPOSAL.md)
and `proposal.json` record every expected tip and retained ancestry.
`receipt.json` records atomic pushes with exact-tip leases and the before/after
remote heads. Retained heads stayed unchanged; local branches and worktrees
were left intact. The remote branch counts became 74 and 157 respectively.

The proposal was published before action in
[the maintenance tracker](https://github.com/servil-software-factory/bench-hashes/issues/215).
A fresh inventory/citation review and a dry run preceded execution.

## Why these references

The inventory found 268 remote branches. It considered only Devon's own
`candidate/devon-*` names whose tips are true Git ancestors of retained heads
in the same repository. It keeps protected/default heads, experiments,
archives, active worktrees, differing unpublished local tips and open PRs.

Active-work review covered 14 local Git families, including independent
clones, with no unreadable Git markers. This removed one candidate that a
single-checkout review would have missed. Open-PR review included the
maintained parent, Devon's fork and the ultimate fork-network source.

Citation review searched data and source documentation/scripts, working
notes, issue/PR bodies and issue comments in those three public repositories.
It excluded this inventory/proposal itself. Eleven otherwise-eligible names
were retained because that review found references. The review is finite;
unknown external references remain a consideration.

This removes stale candidate names from navigation. It changes no program,
benchmark result or commit. Experimental and cited names remain available.

## Execution and recovery

The execution script reloads the immutable published proposal, reruns the
eligibility/citation checks, verifies exact remote tips, and uses atomic
exact-tip-lease pushes. It then checks that the listed names are absent and
retained heads are unchanged. A changed precondition stops the operation.

The first dry run stopped before any deletion: a custom SSH override bypassed
the environment's working Git transport and met a system configuration
permission error. The override was removed. The corrected dry run and actual
operation passed, using the existing transport. Both logs remain in `logs/`.

Each removed name can be recreated from its recorded tip with ordinary Git:

```sh
git push REMOTE SHA:refs/heads/BRANCH
```

No force push of a retained branch, local branch deletion, worktree removal
or garbage collection is part of this proposal.

`code/` holds the read-only inventory and citation scripts. Raw working-note
citations stay private; the public proposal carries the names selected for
review and their proof of retained ancestry. SHA-256 and BLAKE3 manifests
cover all files except the manifests themselves.
