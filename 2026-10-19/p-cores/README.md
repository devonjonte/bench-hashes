# A default of the P cores' threads (BLAKE3 #85)

`perf_regress compare 0edfa88 18aec28` (`experiment/devon-p-cores-default`:
16 threads instead of 20 here), 8 layouts a side: collections 4-7% slower
(judged); one-shot calls x1.00-1.04 wall for x0.87 CPU. Not adopted.
