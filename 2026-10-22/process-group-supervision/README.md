# Terminate the owned job group on every supervisor exit

## Question and verdict

Does the supervisor preserve the leader's status and terminate its group
when the leader succeeds, fails or dies, and when a deadline or signal
interrupts the supervisor?

**Six ownership checks pass with the repaired supervisor.** The original
fails three: success, exit7 and a signaled leader all leave a descendant
running. Its timeout/interrupt/termination checks pass. The fixtures clean
up every remaining descendant after a failure.

The repair uses CPython's Unix `waitid(WNOWAIT)` to observe exit while
retaining the zombie leader. Its PID/group ID stays reserved until the
supervisor sends SIGKILL to the whole group, then reaps the leader. This
also removes the former TERM/grace/KILL sequence. Original return codes
survive; deadline expiry remains124. PyPy lacks `waitid`; an explicit
precondition requires the supported interpreter/API before launching work.
Tested on Linux x86-64 with CPython3.14. This is liveness evidence, with no
benchmark speed measurement.

The current `/home/agent/bench-hashes-validation/run-bounded.py` is this
folder's repaired `run-bounded.py`, SHA256
`61b65d32e7440a6b516431b3c390a66f4094b640ce3150fcff0344ef7f7511fa`.
Earlier evidence keeps its original supervisor snapshots.

## Separate proof-worker finding

`workers-failfast-repro.py`, run from BLAKE3 source
`af5b8684f648c3b1e524b4185b226345cbfb8313`, makes one worker fail and another
sleep. The harness names the failed item, then Python's interpreter exit
waits for the sibling. The external four-second deadline terminates the
group (124). `workers.py` is unchanged at upstream0f55d26. This remains an
open worker-harness issue; the supervisor repair establishes group cleanup
when the leader exits and preserves the independent deadline guard.

## Reproduce

From this folder, run these tests in CPython on Linux:

```sh
python3 test-run-bounded.py ./run-bounded.py ./repro-fixed
python3 test-run-bounded.py ./run-bounded-before-unreaped.py ./repro-original
```

The first exits0 and the second exits1. Each fixture checks both leader and
descendant; supervisor signals are tested independently of leader signals.
The timeout test allows the existing separately bounded gdb stack capture.
