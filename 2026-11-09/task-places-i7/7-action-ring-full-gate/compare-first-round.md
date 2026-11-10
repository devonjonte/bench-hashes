compare: old side: bench f43ff077761b clean; servil c3e1f90551ba clean
compare: new side: bench f43ff077761b clean; servil 203d92a228c8 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.687 | 0.694 | x1.010 | level | 1 of 4 | x1.010 | x0.969 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.690 | 0.687 | x0.995 | level | 3 of 4 | x0.995 | x0.984 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.689 | 0.691 | x1.003 | level | 2 of 4 | x1.002 | x1.036 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.691 | 0.692 | x1.002 | level | 1 of 4 | x1.002 | x1.008 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.262 | 0.261 | x0.996 | level | 3 of 4 | x0.996 | x0.979 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.188 | 0.187 | x0.998 | level | 2 of 4 | x0.998 | x1.003 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.194 | 0.194 | x1.000 | level | 1 of 4 | x1.000 | x1.014 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.201 | 0.198 | x0.987 | level | 3 of 4 | x0.988 | x1.057 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.204 | 0.206 | x1.010 | level | 1 of 4 | x1.010 | x1.061 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 13.386 | 12.955 | x0.968 | level | 2 of 4 | x0.968 | x0.886 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 12.287 | 12.263 | x0.998 | level | 2 of 4 | x0.998 | x0.998 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 12.494 | 12.562 | x1.005 | level | 2 of 4 | x1.006 | x1.073 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 12.846 | 12.803 | x0.997 | level | 4 of 4 | x0.997 | x0.923 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 12.943 | 12.925 | x0.999 | level | 2 of 4 | x0.998 | x1.034 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 13.993 | 13.983 | x0.999 | level | 2 of 4 | x1.000 | x0.956 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.174 | 14.035 | x0.990 | level | 4 of 4 | x0.991 | x0.988 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.687 | 0.694 | x1.010 | level | 1 of 4 | x1.010 | x0.969 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.691 | 0.692 | x1.002 | level | 1 of 4 | x1.002 | x1.008 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.188 | 0.187 | x0.998 | level | 2 of 4 | x0.998 | x1.003 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.207 | 0.208 | x1.005 | level | 1 of 4 | x1.006 | x1.045 |
| blake3-servil-st / solo / LentBatches / 16 | 13.386 | 12.955 | x0.968 | level | 2 of 4 | x0.968 | x0.886 |
| blake3-servil-st / solo / LentBatches / 1024 | 12.846 | 12.803 | x0.997 | level | 4 of 4 | x0.997 | x0.923 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.234 | 0.235 | x1.004 | level | 2 of 4 | x1.004 | x0.997 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.241 | 0.234 | x0.969 | level | 4 of 4 | x0.969 | x0.910 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.238 | 0.236 | x0.991 | level | 3 of 4 | x0.991 | x1.040 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.916 | 0.915 | x1.000 | level | 3 of 4 | x0.995 | x0.940 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.276 | 0.272 | x0.985 | level | 4 of 4 | x0.998 | x0.945 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.152 | 0.150 | x0.987 | level | 2 of 4 | x1.015 | x0.945 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0926 | 0.0886 | x0.957 | level | 3 of 4 | x0.967 | x1.010 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0643 | 0.0651 | x1.012 | level | 1 of 4 | x1.041 | x1.048 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0517 | 0.0515 | x0.994 | level | 3 of 4 | x1.022 | x0.937 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0464 | 0.0457 | x0.984 | level | 3 of 4 | x1.022 | x0.955 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0386 | 0.0390 | x1.009 | level | 2 of 4 | x1.021 | x1.077 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0426 | 0.0417 | x0.978 | level | 3 of 4 | x1.007 | x1.018 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0516 | 0.0516 | x1.001 | level | 2 of 4 | x0.978 | x1.008 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.121 | 4.160 | x1.009 | level | 2 of 4 | x1.000 | x1.016 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.846 | 3.899 | x1.014 | level | 1 of 4 | x1.022 | x1.074 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.565 | 3.515 | x0.986 | level | 3 of 4 | x1.029 | x0.991 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.734 | 3.697 | x0.990 | level | 2 of 4 | x1.050 | x0.996 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.665 | 3.708 | x1.012 | level | 2 of 4 | x1.015 | x1.034 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 3.837 | 3.885 | x1.012 | level | 1 of 4 | x1.016 | x0.988 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.997 | 3.931 | x0.983 | level | 3 of 4 | x0.975 | x1.020 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.697 | 0.702 | x1.008 | level | 2 of 4 | x1.008 | x0.938 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.691 | 0.694 | x1.004 | level | 1 of 4 | x1.004 | x1.003 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.189 | 0.188 | x0.995 | level | 2 of 4 | x0.995 | x0.946 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0657 | 0.0661 | x1.007 | level | 0 of 4 | x1.002 | x0.961 |
| blake3-servil-mt / solo / LentBatches / 16 | 12.956 | 12.949 | x0.999 | level | 3 of 4 | x0.999 | x0.933 |
| blake3-servil-mt / solo / LentBatches / 1024 | 12.838 | 12.948 | x1.009 | level | 0 of 4 | x1.009 | x1.039 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0703 | 0.0648 | x0.923 | level | 3 of 4 | x0.996 | x0.941 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.242 | 0.234 | x0.968 | level | 3 of 4 | x0.969 | x0.996 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.238 | 0.235 | x0.987 | level | 3 of 4 | x0.987 | x0.969 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.915 | x1.000 | level | 4 of 4 | x0.993 | x0.986 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.282 | 0.293 | x1.040 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.169 | 0.172 | x1.017 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.108 | 0.106 | x0.975 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0691 | 0.0680 | x0.984 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0624 | 0.0628 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0517 | 0.0511 | x0.989 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0445 | 0.0456 | x1.024 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0479 | 0.0483 | x1.010 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0830 | 0.0817 | x0.984 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.934 | 4.832 | x0.979 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 4.270 | 4.280 | x1.002 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.989 | 3.927 | x0.984 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 4.019 | 4.024 | x1.001 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 4.045 | 3.997 | x0.988 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.259 | 4.247 | x0.997 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 4.539 | 4.537 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.736 | 0.708 | x0.962 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.701 | 0.704 | x1.004 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.189 | 0.190 | x1.006 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0722 | 0.0721 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 13.116 | 13.180 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.048 | 13.078 | x1.002 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0789 | 0.0770 | x0.976 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.247 | 0.247 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.251 | 0.250 | x0.995 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 58.579 | 51.400 | x0.877 | level | 4 of 4 | x0.908 | x0.907 |
| blake3-servil-pipeline / solo / ContinuousBatches / 64 | 22.086 | 21.423 | x0.970 | level | 4 of 4 | x0.967 | x0.932 |
| blake3-servil-pipeline / solo / ContinuousBatches / 256 | 16.735 | 14.794 | x0.884 | level | 4 of 4 | x0.873 | x0.878 |
| blake3-servil-pipeline / solo / ContinuousBatches / 1024 | 10.612 | 10.162 | x0.958 | level | 4 of 4 | x0.971 | x0.808 |
| blake3-servil-pipeline / solo / ContinuousBatches / 4096 | 9.679 | 9.690 | x1.001 | level | 2 of 4 | x1.002 | x1.055 |
| blake3-servil-pipeline / solo / ContinuousBatches / 16384 | 10.192 | 10.043 | x0.985 | level | 3 of 4 | x0.990 | x0.951 |
| blake3-servil-pipeline / solo / ContinuousBatches / 65536 | 9.830 | 9.714 | x0.988 | level | 3 of 4 | x0.991 | x0.992 |
| blake3-servil-pipeline / solo / ReceivingMessage / saturated | 0.0798 | 0.0761 | x0.954 | level | 4 of 4 | x1.064 | x0.933 |
| blake3-servil-pipeline / solo / ReceivingMessage / 2 μs | 0.0933 | 0.0926 | x0.993 | level | 3 of 4 | x0.934 | x0.977 |
| blake3-servil-pipeline / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | x0.965 | x0.957 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 52.999 | 49.060 | x0.926 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 64 | 22.512 | 21.523 | x0.956 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 256 | 15.148 | 15.058 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 1024 | 12.197 | 12.752 | x1.046 | level | 0 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 4096 | 10.626 | 10.611 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16384 | 11.216 | 11.222 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 65536 | 12.016 | 12.465 | x1.037 | level | 0 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / saturated | 0.104 | 0.0971 | x0.932 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 2 μs | 0.106 | 0.0983 | x0.927 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | - | - |
