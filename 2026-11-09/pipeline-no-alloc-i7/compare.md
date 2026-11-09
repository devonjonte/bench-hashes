compare: old side: bench 9c6804edd219 clean; servil dc814dc679f3 clean
compare: new side: bench 9c6804edd219 clean; servil b246a135fd19 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousBatches / 16 | 13.003 | 12.985 | x0.999 | level | 2 of 4 | x0.999 | x0.997 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 12.437 | 12.203 | x0.981 | level | 3 of 4 | x0.982 | x1.074 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 12.598 | 12.636 | x1.003 | level | 3 of 4 | x1.003 | x1.008 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 13.363 | 13.016 | x0.974 | level | 4 of 4 | x0.974 | x0.892 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 13.130 | 12.960 | x0.987 | level | 1 of 4 | x0.987 | x1.005 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 13.874 | 14.198 | x1.023 | level | 0 of 4 | x1.023 | x1.065 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.173 | 14.148 | x0.998 | level | 2 of 4 | x0.998 | x1.014 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.240 | 0.233 | x0.973 | level | 4 of 4 | x0.973 | x0.942 |
| blake3-servil-st / solo / ReceivingMessage / 2 us | 0.243 | 0.248 | x1.021 | level | 1 of 4 | x1.021 | x1.037 |
| blake3-servil-st / solo / ReceivingMessage / 20 us | 0.915 | 0.916 | x1.000 | level | 1 of 4 | x1.006 | x1.017 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.197 | 4.165 | x0.992 | level | 2 of 4 | x1.002 | x0.993 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.915 | 3.985 | x1.018 | level | 1 of 4 | x1.018 | x0.902 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.636 | 3.703 | x1.019 | level | 2 of 4 | x1.003 | x1.032 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.726 | 3.762 | x1.010 | level | 2 of 4 | x1.022 | x0.988 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.687 | 3.712 | x1.007 | level | 2 of 4 | x0.976 | x0.939 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 4.010 | 4.052 | x1.011 | level | 1 of 4 | x0.989 | x0.998 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 4.014 | 4.076 | x1.015 | level | 1 of 4 | x1.002 | x1.001 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.239 | 0.243 | x1.016 | level | 1 of 4 | x1.016 | x1.173 |
| blake3-servil-mt / solo / ReceivingMessage / 2 us | 0.250 | 0.240 | x0.961 | level | 2 of 4 | x0.961 | x0.925 |
| blake3-servil-mt / solo / ReceivingMessage / 20 us | 0.915 | 0.916 | x1.000 | level | 1 of 4 | x1.036 | x1.073 |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.848 | 4.963 | x1.024 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 4.247 | 4.255 | x1.002 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.974 | 3.937 | x0.991 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.005 | 4.015 | x1.003 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.992 | 4.064 | x1.018 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.239 | 4.201 | x0.991 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 4.563 | 4.588 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.252 | 0.251 | x0.995 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 us | 0.250 | 0.249 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 us | 0.916 | 0.916 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 60.159 | 56.205 | x0.934 | level | 4 of 4 | x0.954 | x0.922 |
| blake3-servil-pipeline / solo / ContinuousBatches / 64 | 25.682 | 22.368 | x0.871 | level | 4 of 4 | x0.778 | x0.907 |
| blake3-servil-pipeline / solo / ContinuousBatches / 256 | 15.091 | 15.007 | x0.994 | level | 3 of 4 | x0.975 | x0.851 |
| blake3-servil-pipeline / solo / ContinuousBatches / 1024 | 10.525 | 10.291 | x0.978 | level | 3 of 4 | x0.981 | x0.942 |
| blake3-servil-pipeline / solo / ContinuousBatches / 4096 | 9.516 | 9.915 | x1.042 | level | 1 of 4 | x1.026 | x1.014 |
| blake3-servil-pipeline / solo / ContinuousBatches / 16384 | 10.013 | 10.059 | x1.005 | level | 1 of 4 | x1.002 | x0.997 |
| blake3-servil-pipeline / solo / ContinuousBatches / 65536 | 9.905 | 9.761 | x0.986 | level | 3 of 4 | x0.987 | x0.934 |
| blake3-servil-pipeline / solo / ReceivingMessage / saturated | 0.0794 | 0.0801 | x1.009 | level | 1 of 4 | x1.024 | x0.979 |
| blake3-servil-pipeline / solo / ReceivingMessage / 2 us | 0.0929 | 0.0929 | x0.999 | level | 1 of 4 | x0.985 | x1.037 |
| blake3-servil-pipeline / solo / ReceivingMessage / 20 us | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x0.999 | x1.042 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 58.335 | 56.274 | x0.965 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 64 | 23.065 | 22.855 | x0.991 | level | 3 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 256 | 15.091 | 15.228 | x1.009 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 1024 | 13.249 | 13.294 | x1.003 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 4096 | 10.643 | 10.651 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16384 | 11.254 | 11.391 | x1.012 | level | 0 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 65536 | 12.758 | 12.817 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / saturated | 0.100 | 0.1000 | x0.998 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 2 us | 0.103 | 0.0996 | x0.965 | level | 3 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 20 us | 0.917 | 0.916 | x0.998 | level | 2 of 4 | - | - |
