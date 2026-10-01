# Paired-copy coverage control: predeclared synthetic model

John has already acknowledged that concurrent copies should be resampled
with their visit. This experiment characterizes that issue by calling the
existing shared bootstrap directly; it proposes no new statistical rule.

- Test population: integer values1..99, true median50. Deterministic SplitMix64
  seed0xd3a0c1a020261001 and multiply-shift range selection specify inputs.
-4000 trials at6/12/24/48 visits, in that order, continuing the same RNG stream.
- Exactly correlated copies: each visit value occurs twice in the flattened
  representation. A grouped control uses one value per independent visit.
- Call clocks::speeds::bootstrap_median_interval on each representation.
  Count intervals containing50 and sum widths as Q64 integers. Keep counts,
  rather than presenting rounded percentages as independent measurements.
- Hypothesis: flattened copies yield narrower intervals and fewer containing
  the known median than the grouped control. Record any disagreement.

This is a fixed one-speed median model, using exactly correlated copies as a
boundary case. It does not validate realistic serial dependence, speed-split
selection uncertainty, mixtures, or coverage for actual hardware workloads.
The grouped control is suitable for this identical-copy model only. A general
paired/mixed-speed contract still needs review and changes to the shared rule.
