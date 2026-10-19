# The Merkle tree cells' first runs (bench-hashes #52)

`first-try/`: the first run, whose layer buffers were all the leaves'
size: servil st's first shared samples took 431 ms instead of 26 (page
faults). The run beside it has the fix: 262144 leaves, servil mt 0.124
ns/B, st 0.323, official 0.326, SHA-256 0.879, SHA3-256 2.97.
