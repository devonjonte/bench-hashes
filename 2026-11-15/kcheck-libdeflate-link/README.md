# Sam's checked Adler-32 linked into libdeflate, checked as shipped

November 15, 2026. [Builds/artifacts tracker](https://github.com/servil-software-factory/BLAKE3/issues/383);
[benchmark-workflow interface](https://github.com/servil-software-factory/BLAKE3/issues/384).

Sam's `odeadler32.o` (fork `experiment/sam-wide-model`, kcheck at `550627ae`,
object SHA-256 `85a60585600310f63a8f2f5dbcbcb663905c3b5afbdf9249d7b172b46fe179ca`)
joined libdeflate's shared library unchanged, with the earlier experiment's
two-call adapter (`changes.diff`): both whole-buffer zlib checksum calls route
to `ode_adler32`, seed 1, System V `(pointer, length)`.

`check_file.py libdeflate-ode.so adler32.spec` verified **both contract functions
from the shipped library's bytes in 0.29 s**, through the `.ode.proof` section the
linker carried (`check.json`, with the file/spec digests and per-function records).
Nine zlib streams from empty to 1 MiB round-trip; each stream's stored Adler-32
equals Python zlib's (`round-trips.json`). All ten kcheck example programs also
check on this machine in 25.6 s (`kcheck-programs.stdout.txt`).

This is a correctness/toolchain exercise on the i7: no timing, and the built
library stays local (its SHA-256 is in the records). Nothing stopped; the one
adapter choice worth noting is that the checked symbol stays exported here,
where the earlier experiment hid its alias behind `--exclude-libs`.
