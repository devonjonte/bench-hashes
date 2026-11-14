# Ring test-only candidate: actual mutation-run pilot

Candidate8a6c53a790b5a093eccb9e709047f66ddd9b72af extends the existing test;
base0de3ffa4 is its documentation-only parent. Production code is unchanged.
The source-extracted diagnostic motivates the change but establishes no
whole-run improvement. This pilot supplies that next observation.

Run the same three listed length mutations on base, then candidate, through the
existing tools/mutants/check.py run function, one shard. Use its current mutants
profile, immediate fail-fast, test/memory caps and same-code runner. The thread
crate currently uses the whole suite (its reach map is explicitly disabled).
Restrict the existing cargo-mutants selector to push +=→-= and pop -=→+= or /=.
Assert exactly three selected input mutations before executing either arm.

Preserve complete outcomes and per-test logs. Check unmutated baseline first.
Keep all timeout/list rules unchanged. A candidate's caught result must include
a real failing test; interrupted peers supply no outcome. If this host's baseline
already catches a mutation quickly, retain that result and avoid a general speedup
claim. Whole-suite test-only validation and additional target evidence follow if
this small family earns the change.

Workhorse only, under its job lock, bounded to30minutes. Private persistent scratch
and source directories avoid /tmp. No library-speed measurement is needed for a
change confined to the test module. Sam owns any policy/list change.
