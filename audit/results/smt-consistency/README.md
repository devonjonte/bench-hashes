# Core-only consistency relation needs resource-sharing premises

Predeclared in [the protocol](../../consistency-smt-plan.md). Four runs reuse
null artifact6d032dc2ffe48c3027a8fc9cc9ed41ad1e2cbbdc5b098d8dbbee9ab3677860ae,
sha256/sha256-ring, lent1 KiB/lent64 KiB and120 rounds. Saved sysfs topology
shows CPUs0/1 are siblings of one physical P core and0/2 separate P cores.
All four finish, report quiet and pass exact trace/accounting and balance.

| Shared/solo time, fast / slow | Siblings run1 | Siblings run2 | Separate-core runs |
| --- | ---: | ---: | ---: |
| sha2,1 KiB | 1.022 / 1.537 | 1.539 / 1.539 | 0.998-1.000 / same |
| sha2,64 KiB | 1.028 / 1.525 | 1.522 / 1.522 | 0.999 / same |
| ring,1 KiB | 1.014 / 1.501 | 1.500 / 1.500 | 0.998-1.001 / same |
| ring,64 KiB | 1.003 / 1.502 | 1.503 / 1.503 | 1.000 / same |

Both correct, unchanged core-only implementations can slow beside a second
copy on SMT siblings. Core-only does not imply exclusive execution resources,
caches or bandwidth. On siblings run2, the consistency file flags all four
relations by about50%; this observation warrants explanation, rather than
implying a hashing or measurement defect. Separate-core runs stay about level.

Siblings run1 instead says `all hold`: its fast subset stays near solo while
a slow subset pays about50%. The diagnostic checks fast speeds only, so its
success message does not cover slow states/shares or general validity.
Shared bootstrap bands remain excluded from inferential conclusions.

This is one topology-controlled counterexample to the relation's universal
wording. Affinity is not a complete per-sample CPU execution trace. A proposed
wording/classification repair should preserve observed costs and make the
expectation's premises and fast-only scope explicit. Maintainer review is
pending through issue#4; thresholds and frozen calls remain intact here.
