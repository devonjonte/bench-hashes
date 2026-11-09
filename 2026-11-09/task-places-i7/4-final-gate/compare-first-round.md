compare: old side: bench 0bb31ed5186e clean; servil c7936a5f4a8f clean
compare: new side: bench 0bb31ed5186e clean; servil 6d3f3880edf6 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-st / solo / ContinuousMessages / 64 B | 0.688 | 0.687 | x0.999 | level | 2 of 4 | x1.001 | x1.005 |
| blake3-servil-st / solo / ContinuousMessages / 128 B | 0.687 | 0.687 | x1.001 | level | 1 of 4 | x1.001 | x1.008 |
| blake3-servil-st / solo / ContinuousMessages / 256 B | 0.688 | 0.687 | x0.999 | level | 2 of 4 | x0.999 | x1.049 |
| blake3-servil-st / solo / ContinuousMessages / 1 KiB | 0.694 | 0.697 | x1.004 | level | 2 of 4 | x1.004 | x1.016 |
| blake3-servil-st / solo / ContinuousMessages / 4 KiB | 0.261 | 0.263 | x1.008 | level | 1 of 4 | x1.008 | x1.123 |
| blake3-servil-st / solo / ContinuousMessages / 16 KiB | 0.188 | 0.190 | x1.010 | level | 1 of 4 | x1.012 | x1.053 |
| blake3-servil-st / solo / ContinuousMessages / 64 KiB | 0.200 | 0.192 | x0.963 | level | 4 of 4 | x0.963 | x0.963 |
| blake3-servil-st / solo / ContinuousMessages / 1 MiB | 0.199 | 0.198 | x0.997 | level | 2 of 4 | x0.997 | x1.012 |
| blake3-servil-st / solo / ContinuousMessages / 16 MiB | 0.206 | 0.207 | x1.009 | level | 0 of 4 | x1.009 | x0.997 |
| blake3-servil-st / solo / ContinuousBatches / 16 | 12.937 | 12.982 | x1.003 | level | 1 of 4 | x1.003 | x0.958 |
| blake3-servil-st / solo / ContinuousBatches / 64 | 12.265 | 12.479 | x1.017 | level | 1 of 4 | x1.018 | x1.020 |
| blake3-servil-st / solo / ContinuousBatches / 256 | 12.491 | 12.488 | x1.000 | level | 2 of 4 | x1.000 | x0.922 |
| blake3-servil-st / solo / ContinuousBatches / 1024 | 12.915 | 13.083 | x1.013 | level | 0 of 4 | x1.013 | x1.014 |
| blake3-servil-st / solo / ContinuousBatches / 4096 | 12.929 | 13.179 | x1.019 | level | 0 of 4 | x1.020 | x0.979 |
| blake3-servil-st / solo / ContinuousBatches / 16384 | 14.031 | 14.096 | x1.005 | level | 2 of 4 | x1.005 | x0.965 |
| blake3-servil-st / solo / ContinuousBatches / 65536 | 14.148 | 14.224 | x1.005 | level | 2 of 4 | x1.005 | x1.002 |
| blake3-servil-st / solo / LentMessages / 64 B | 0.688 | 0.687 | x0.999 | level | 2 of 4 | x1.001 | x1.005 |
| blake3-servil-st / solo / LentMessages / 1 KiB | 0.694 | 0.697 | x1.004 | level | 2 of 4 | x1.004 | x1.016 |
| blake3-servil-st / solo / LentMessages / 16 KiB | 0.188 | 0.190 | x1.010 | level | 1 of 4 | x1.012 | x1.053 |
| blake3-servil-st / solo / LentMessages / 1 MiB | 0.208 | 0.209 | x1.009 | level | 2 of 4 | x1.009 | x1.057 |
| blake3-servil-st / solo / LentBatches / 16 | 12.937 | 12.982 | x1.003 | level | 1 of 4 | x1.003 | x0.958 |
| blake3-servil-st / solo / LentBatches / 1024 | 12.915 | 13.083 | x1.013 | level | 0 of 4 | x1.013 | x1.014 |
| blake3-servil-st / solo / ContinuousCollection / git objects | 0.234 | 0.234 | x1.003 | level | 2 of 4 | x1.003 | x1.004 |
| blake3-servil-st / solo / ReceivingMessage / saturated | 0.239 | 0.236 | x0.989 | level | 2 of 4 | x0.989 | x1.002 |
| blake3-servil-st / solo / ReceivingMessage / 2 μs | 0.242 | 0.238 | x0.986 | level | 4 of 4 | x0.986 | x0.998 |
| blake3-servil-st / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 2 of 4 | x1.001 | x1.058 |
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.273 | 0.275 | x1.007 | level | 1 of 4 | x1.032 | x1.016 |
| blake3-servil-mt / solo / ContinuousMessages / 128 B | 0.150 | 0.149 | x0.994 | level | 3 of 4 | x1.023 | x0.993 |
| blake3-servil-mt / solo / ContinuousMessages / 256 B | 0.0893 | 0.0934 | x1.046 | level | 0 of 4 | x1.014 | x0.948 |
| blake3-servil-mt / solo / ContinuousMessages / 1 KiB | 0.0667 | 0.0657 | x0.984 | level | 3 of 4 | x0.983 | x0.949 |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.0516 | 0.0529 | x1.024 | level | 2 of 4 | x0.992 | x1.087 |
| blake3-servil-mt / solo / ContinuousMessages / 16 KiB | 0.0459 | 0.0458 | x0.998 | level | 2 of 4 | x0.990 | x1.025 |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0392 | 0.0388 | x0.990 | level | 3 of 4 | x0.995 | x1.021 |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0424 | 0.0428 | x1.010 | level | 2 of 4 | x1.033 | x1.022 |
| blake3-servil-mt / solo / ContinuousMessages / 16 MiB | 0.0507 | 0.0523 | x1.032 | level | 1 of 4 | x1.044 | x0.983 |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 4.088 | 4.080 | x0.998 | level | 3 of 4 | x0.999 | x1.040 |
| blake3-servil-mt / solo / ContinuousBatches / 64 | 3.944 | 3.862 | x0.979 | level | 3 of 4 | x1.003 | x0.966 |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 3.574 | 3.576 | x1.000 | level | 2 of 4 | x0.966 | x1.088 |
| blake3-servil-mt / solo / ContinuousBatches / 1024 | 3.606 | 3.624 | x1.005 | level | 2 of 4 | x0.973 | x1.023 |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 3.661 | 3.624 | x0.990 | level | 3 of 4 | x0.980 | x1.016 |
| blake3-servil-mt / solo / ContinuousBatches / 16384 | 3.918 | 3.836 | x0.979 | level | 3 of 4 | x0.982 | x0.957 |
| blake3-servil-mt / solo / ContinuousBatches / 65536 | 3.924 | 3.887 | x0.991 | level | 3 of 4 | x0.956 | x1.001 |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.704 | 0.698 | x0.991 | level | 4 of 4 | x0.991 | x0.975 |
| blake3-servil-mt / solo / LentMessages / 1 KiB | 0.689 | 0.692 | x1.003 | level | 1 of 4 | x1.003 | x1.037 |
| blake3-servil-mt / solo / LentMessages / 16 KiB | 0.187 | 0.191 | x1.020 | level | 1 of 4 | x1.021 | x1.087 |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.0660 | 0.0660 | x1.000 | level | 1 of 4 | x0.998 | x1.028 |
| blake3-servil-mt / solo / LentBatches / 16 | 12.958 | 12.970 | x1.001 | level | 2 of 4 | x1.001 | x0.990 |
| blake3-servil-mt / solo / LentBatches / 1024 | 12.904 | 13.168 | x1.020 | level | 1 of 4 | x1.020 | x1.016 |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.0684 | 0.0631 | x0.922 | level | 4 of 4 | x0.986 | x0.927 |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.240 | 0.238 | x0.991 | level | 2 of 4 | x0.991 | x1.036 |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.239 | 0.235 | x0.985 | level | 3 of 4 | x0.985 | x0.908 |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 1 of 4 | x1.012 | x1.001 |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.291 | 0.287 | x0.989 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 128 B | 0.164 | 0.166 | x1.007 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 256 B | 0.107 | 0.103 | x0.961 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 KiB | 0.0706 | 0.0705 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.0608 | 0.0618 | x1.018 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 KiB | 0.0513 | 0.0519 | x1.011 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0447 | 0.0439 | x0.981 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0494 | 0.0484 | x0.979 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 16 MiB | 0.0821 | 0.0816 | x0.994 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 4.854 | 4.847 | x0.999 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 64 | 4.281 | 4.272 | x0.998 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 3.929 | 3.954 | x1.006 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 1024 | 3.976 | 3.970 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 3.959 | 3.978 | x1.005 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16384 | 4.266 | 4.300 | x1.008 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 65536 | 4.544 | 4.567 | x1.005 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.715 | 0.720 | x1.008 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 KiB | 0.703 | 0.701 | x0.998 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 16 KiB | 0.190 | 0.189 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.0718 | 0.0717 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 13.140 | 13.142 | x1.000 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 1024 | 13.073 | 13.058 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.0786 | 0.0784 | x0.997 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.247 | 0.246 | x0.996 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.249 | 0.249 | x0.997 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-pipeline / solo / ContinuousBatches / 16 | 57.522 | 54.432 | x0.946 | level | 3 of 4 | x0.964 | x0.861 |
| blake3-servil-pipeline / solo / ContinuousBatches / 64 | 23.519 | 22.347 | x0.950 | level | 2 of 4 | x0.965 | x0.992 |
| blake3-servil-pipeline / solo / ContinuousBatches / 256 | 16.596 | 14.848 | x0.895 | level | 3 of 4 | x0.894 | x0.891 |
| blake3-servil-pipeline / solo / ContinuousBatches / 1024 | 10.578 | 10.737 | x1.015 | level | 1 of 4 | x1.010 | x0.979 |
| blake3-servil-pipeline / solo / ContinuousBatches / 4096 | 9.729 | 9.954 | x1.023 | level | 2 of 4 | x1.011 | x1.043 |
| blake3-servil-pipeline / solo / ContinuousBatches / 16384 | 9.814 | 9.876 | x1.006 | level | 1 of 4 | x1.006 | x0.945 |
| blake3-servil-pipeline / solo / ContinuousBatches / 65536 | 9.706 | 9.704 | x1.000 | level | 2 of 4 | x1.000 | x0.992 |
| blake3-servil-pipeline / solo / ReceivingMessage / saturated | 0.0808 | 0.0822 | x1.016 | level | 1 of 4 | x0.993 | x1.025 |
| blake3-servil-pipeline / solo / ReceivingMessage / 2 μs | 0.0934 | 0.0945 | x1.011 | level | 2 of 4 | x0.959 | x0.936 |
| blake3-servil-pipeline / solo / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 2 of 4 | x1.036 | x1.006 |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16 | 53.260 | 55.728 | x1.046 | level | 0 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 64 | 22.287 | 22.288 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 256 | 15.326 | 15.273 | x0.997 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 1024 | 14.301 | 12.421 | x0.869 | level | 4 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 4096 | 10.659 | 10.824 | x1.016 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 16384 | 11.300 | 11.724 | x1.037 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ContinuousBatches / 65536 | 12.129 | 12.273 | x1.012 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / saturated | 0.102 | 0.105 | x1.025 | level | 1 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 2 μs | 0.103 | 0.103 | x0.999 | level | 2 of 4 | - | - |
| blake3-servil-pipeline / shared-one-cache / ReceivingMessage / 20 μs | 0.916 | 0.916 | x1.000 | level | 3 of 4 | - | - |
