# Test the observed queue calibration startup defect

At17:05UTC, the topology diagnostic has completed128processes. Its isolated
queue samples often cover only~0.1ms, despite TARGET_SAMPLE_NS=1ms, so most
2048-sample queue runs remain below the load observer's half-second window.
Those original attempts stay preserved and descriptive. Other isolated1MiB
runs have substantially tighter repeats than the retained mixed null.

Source mechanism: calibration starts with continuous_min_inputs (2048calls
at64B) and times run_batch. Its first queue batch initializes pool/delivery/
producer state. Once that batch reaches the probe threshold, calibration
remeasures only when iterations==1. A queue's floor exceeds1, so the cold
first elapsed time can set too few calls for a steady1ms sample. This is a
specific, controllable budget defect. Its contribution to the original wide
intervals remains a separate causal question.

Use one v2 diagnostic artifact with explicit cold/warm modes. Warm mode calls
the existing run_batch once at its minimum before the unchanged calibration;
all subsequent APIs/timing/counters/means remain identical. Record calibrated
iterations and actual sample duration. Runtime source and CLI format are newly
versioned and source-matched; the v1artifact and all128records stay intact.

Fresh queue64comparison at default20CPUs and separateP0/2/4/6,8ABBAblocks per
context (64processes). Each measures16384calibrated samples in both modes,
chosen before collection to give the short-budget baseline real work over a
load-observation window. This is a new declared duration experiment, with
all earlier unobserved evidence retained. Stop first execution failure;
retain busy/unobserved/statistical outcomes; zero favorable retries.
Wholecampaign1800s,eachprocess120s,and outer18:35UTC deadline.

A supported fix must show the predicted increased call budget and actual
sample duration, with workload/accounting/reference checks. Compare mean and
within-mode repeat range from the same shared Rust reader; metadata on/off
controls from the first study qualify snapshot effects. Changing the sample
budget may reveal scheduling/context costs; those remain findings. Model
inference from the16-block production gate requires a fresh matched campaign.

Within the remaining time, confirm a supported calibration change in the
original14-point mixed context with fresh alternating artifacts, preserving
all axes/rounds/means and reports. Publish whether this experiment establishes
only a calibration-budget cause, or also a reproducible cause of the target
run variation. Conclude the bounded study by18:35UTC even if the latter stays
unresolved. No threshold or confidence-budget retuning.
