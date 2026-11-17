# The Pipeline's shared continuous cells against 0.8.0 (BLAKE3 #368)

November 17, 2026. Devon Jonte. The question in #368 was whether the old stream's 64-pair slowdown on the 96-thread EPYC 7443 pair carries to the Pipeline. The job was declared in `run/run.sh` before it ran: level or faster in the shared cells answers it.

`next` `a12a4d35` against 0.8.0 `b5b988d8`, bench-hashes 0.23, `--contenders blake3-servil-mt --points 'continuous 1 MiB,continuous 4 MiB'`, 16 pairs. The check exited 0, `no cell slower`.

| scenario | 1 MiB | 4 MiB |
|---|---|---|
| solo | ×0.292 faster (16/16) | ×0.275 faster (16/16) |
| shared-one-cache | ×0.470 faster (16/16) | ×0.394 faster (16/16) |
| shared-two-caches | ×0.557 faster (16/16) | ×0.543 faster (16/16) |

The run folder contains the job, stdout/stderr, versions and kept samples. The comparison above is computed with `bench-hashes compare` from those samples. No binaries.
