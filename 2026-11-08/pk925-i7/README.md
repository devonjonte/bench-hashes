# Packed lanes (BLAKE3 #297) on the #299 integration, i7-12700K

**Commits.** pk925 = 925e28d9 (#299 integration) + #297 cherry-picked; against 925e28d9. bench-hashes 49f45960.

**Command.** `check --new pk925 --against o8new --points "merkle 65536 x 32 B,merkle 1048576 x 32 B,merkle 1048576 x 16 B,merkle 65536,64 B,continuous batch 1024,lent batch 1024,collection git objects,16,64,turn 1024 x 1 KiB" --when-quiet`.

**Verdict.** No cell slower. Faster every pair: st 32/16 B trees -47..-49%, mt -15..-28%, shared -13..-36%. Posted on BLAKE3 #297.
