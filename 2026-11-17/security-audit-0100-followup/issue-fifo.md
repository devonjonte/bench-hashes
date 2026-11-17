At `5df2bc45`, part 1 of the [audit brief](https://github.com/servil-software-factory/BLAKE3/issues/410#issuecomment-6940362822), `linux_pipe.rs` hashes a non-regular file through `crate::hash_path_hash(args, &paths[i])` (line 971). That opens its name again. The no-io_uring fallback for a large file did the same (line 1156).

A FIFO makes the second open wait for a second writer. I ran one writer and two inputs, the FIFO and a regular file, with `--num-threads 1`; `statx` was delayed 100 ms. `b3sum` printed no hash and had to be killed after five seconds. The same run with only the FIFO passed. Passing the already-open `File` to `hash_open_file` made both cases pass.

**Fixed in the combined candidate** `89abafc6` (still in `next` `4483281c`): both paths call `hash_open_file(args, file)`, and `without_a_ring_the_file_opened_is_the_file_hashed` covers the fallback. This issue records the independent confirmation, with the FIFO reproducer in the audit record.

Next move: John, close after reading.

— Devon Jonte
