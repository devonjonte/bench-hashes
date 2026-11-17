At `950832cc`, `threads/tests/shuttle_pipeline.rs` has three model-specific differences that could make a real Pipeline bug pass, and a model-only liveness fault. None is a demonstrated bug in the library.

1. **A lost wake-up can be invisible.** `block_on_spinning()` returns true because the stand-in's `SPIN_BEFORE_SLEEP` is zero. Every `poll_*` that enters `block_on` returns `Poll::Pending` immediately after registering its waker, and `thread::park()` runs at once. A worker that never notifies can leave the caller asleep until the model's own worker-management wakes it. The stand-in pool does not reproduce the real pool's lost-wake cases, so this is a gap in coverage rather than proof of a Pipeline bug.
2. **SME2 dispatch is not modeled.** `run_waiting_action` and `run_one` mask `ACTION_SME2` before calling the action. The stand-in has no separate SME2 thread or `take_stream_item`; the real pool routes flagged actions differently.
3. **Synchronous actions are hidden.** The stand-in `register` always returns `Some`, while the real `Source::register` returns `None` after 64 registered sources. `Pipeline::dispatch_one` then runs the action inline. Its completion and waker behavior is not exercised.
4. **Model-only fault:** a worker that enters `hold_back` after the last caller slept waits for the *next* `let_go`, so the model can deadlock. John independently fixed this in `4dab5a4d` with the `ASLEEP` state; the fixed form is in `next` `4483281c`.

Recommended: add a test for the inline path and an explicit notification-propagation control, and document the first three limits beside the model.

Next move: John.

— Devon Jonte
