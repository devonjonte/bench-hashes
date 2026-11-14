# Mac Pipeline pilot — declared November 14 before submission

Queue jobs3117/3118 on the existing team runner (mac-m6, mixed-use Mini).
Same library f62bc6ac, candidate55436819 and synchronous baseline d1c20fdf,
the same19 named points as the EPYC pilot. Four fresh layouts per side,
no adaptive second stage. Job3117 is candidate/candidate;3118 is baseline/candidate.

The current Mac runner's check adapter has no contender selector, so BOTH
Servil st and mt run. Shared OS-placed mt copies run as well as solo cells.
This differs from EPYC's roster and placement scope. Compare within each
machine's matched context, and qualify cross-platform interpretation.

Each job has a30-minute deadline. Busy/no-verdict results remain failures to
establish speed. Do not keep rerunning to obtain a quiet flag. The dedicated
Mac timing runner is still pending team-queue integration; this is explicitly
a workstation pilot. GitHub CI already passed macOS build/tests/quick run;
this pilot adds controlled source comparisons, subject to its load evidence.
