compare: old side: bench d1c20fdfcf75 clean; servil f62bc6ac0bc1 clean
compare: new side: bench 55436819e59a clean; servil f62bc6ac0bc1 clean
| cell | old ns/unit | new ns/unit | new/old | verdict | pairs faster | CPU time | energy |
|---|---:|---:|---:|---|---:|---:|---:|
| blake3-servil-mt / solo / ContinuousMessages / 64 B | 0.842 | 1.227 | x1.458 | level | 0 of 4 | x2.912 | - |
| blake3-servil-mt / solo / ContinuousMessages / 4 KiB | 0.321 | 0.132 | x0.411 | faster | 4 of 4 | x1.643 | - |
| blake3-servil-mt / solo / ContinuousMessages / 64 KiB | 0.0725 | 0.115 | x1.592 | slower | 0 of 4 | x3.153 | - |
| blake3-servil-mt / solo / ContinuousMessages / 1 MiB | 0.0785 | 0.104 | x1.321 | slower | 0 of 4 | x2.668 | - |
| blake3-servil-mt / solo / ContinuousBatches / 16 | 6.771 | 12.451 | x1.839 | slower | 0 of 4 | x4.344 | - |
| blake3-servil-mt / solo / ContinuousBatches / 256 | 5.795 | 9.475 | x1.635 | slower | 0 of 4 | x3.425 | - |
| blake3-servil-mt / solo / ContinuousBatches / 4096 | 6.111 | 7.411 | x1.213 | slower | 0 of 4 | x3.590 | - |
| blake3-servil-mt / solo / LentMessages / 64 B | 0.842 | 0.841 | x0.999 | level | 2 of 4 | x1.000 | - |
| blake3-servil-mt / solo / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 2 of 4 | x1.001 | - |
| blake3-servil-mt / solo / LentMessages / 64 KiB | 0.0725 | 0.0727 | x1.003 | level | 1 of 4 | x1.003 | - |
| blake3-servil-mt / solo / LentMessages / 1 MiB | 0.103 | 0.102 | x0.991 | level | 3 of 4 | x1.406 | - |
| blake3-servil-mt / solo / LentBatches / 16 | 6.771 | 6.785 | x1.002 | level | 1 of 4 | x1.002 | - |
| blake3-servil-mt / solo / LentBatches / 256 | 5.795 | 5.825 | x1.005 | level | 1 of 4 | x1.005 | - |
| blake3-servil-mt / solo / LentBatches / 4096 | 6.111 | 6.240 | x1.021 | level | 0 of 4 | x1.021 | - |
| blake3-servil-mt / solo / ContinuousCollection / git objects | 0.125 | 0.111 | x0.890 | level | 4 of 4 | x2.166 | - |
| blake3-servil-mt / solo / ContinuousCollection / Nix files | 0.138 | 0.110 | x0.799 | faster | 4 of 4 | x1.597 | - |
| blake3-servil-mt / solo / ReceivingMessage / saturated | 0.163 | 0.113 | x0.692 | faster | 4 of 4 | x1.379 | - |
| blake3-servil-mt / solo / ReceivingMessage / 2 μs | 0.164 | 0.108 | x0.659 | faster | 4 of 4 | x1.248 | - |
| blake3-servil-mt / solo / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 0 of 4 | x1.483 | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 B | 0.840 | 1.035 | x1.232 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 4 KiB | 0.320 | 0.140 | x0.438 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 64 KiB | 0.0725 | 0.114 | x1.574 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousMessages / 1 MiB | 0.0774 | 0.111 | x1.434 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 16 | 6.815 | 10.038 | x1.473 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 256 | 5.899 | 8.597 | x1.457 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousBatches / 4096 | 6.144 | 7.970 | x1.297 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 B | 0.840 | 0.840 | x1.001 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 4 KiB | 0.320 | 0.320 | x1.000 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 64 KiB | 0.0725 | 0.0725 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentMessages / 1 MiB | 0.132 | 0.130 | x0.984 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 16 | 6.815 | 6.746 | x0.990 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 256 | 5.899 | 5.850 | x0.992 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / LentBatches / 4096 | 6.144 | 6.122 | x0.996 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / git objects | 0.126 | 0.109 | x0.865 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ContinuousCollection / Nix files | 0.141 | 0.108 | x0.770 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / saturated | 0.174 | 0.116 | x0.668 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 2 μs | 0.175 | 0.116 | x0.663 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-one-cache / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.001 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 B | 0.842 | 0.940 | x1.116 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 4 KiB | 0.321 | 0.126 | x0.394 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 64 KiB | 0.0727 | 0.0946 | x1.302 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousMessages / 1 MiB | 0.0776 | 0.0845 | x1.090 | level | 1 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 16 | 6.830 | 10.722 | x1.570 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 256 | 5.908 | 8.130 | x1.376 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousBatches / 4096 | 6.155 | 7.404 | x1.203 | slower | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 B | 0.842 | 0.841 | x0.999 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 4 KiB | 0.321 | 0.321 | x1.000 | level | 3 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 64 KiB | 0.0727 | 0.0726 | x1.000 | level | 2 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentMessages / 1 MiB | 0.108 | 0.105 | x0.970 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentBatches / 16 | 6.830 | 6.757 | x0.989 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentBatches / 256 | 5.908 | 5.860 | x0.992 | level | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / LentBatches / 4096 | 6.155 | 6.250 | x1.015 | level | 0 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / git objects | 0.125 | 0.0911 | x0.731 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ContinuousCollection / Nix files | 0.138 | 0.0875 | x0.634 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / saturated | 0.163 | 0.0984 | x0.605 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 2 μs | 0.164 | 0.102 | x0.621 | faster | 4 of 4 | - | - |
| blake3-servil-mt / shared-two-caches / ReceivingMessage / 20 μs | 0.915 | 0.915 | x1.000 | level | 0 of 4 | - | - |
