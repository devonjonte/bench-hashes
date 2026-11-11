# First (added 16:45): BLAKE3 #297's trees by name, 16 pairs, before the segments.
import subprocess as _sp, os as _os
_H = _os.path.expanduser("~"); _os.makedirs(_H + "/runs/gate-297", exist_ok=True)
with open(_H + "/runs/gate-297/named.stdout.txt", "w") as _o, open(_H + "/runs/gate-297/named.stderr.txt", "w") as _e:
    _r = _sp.run([_H + "/work/bench-hashes/target/release/bench-hashes", "check", "--fork", _H + "/work/BLAKE3", "--new", "f2902fb2", "--against", "3313686b",
                  "--points", "merkle 1048576 x 32 B,merkle 65536 x 32 B,merkle 1048576 x 16 B,continuous batch 16,continuous batch 1024", "--layouts", "16", "--when-quiet",
                  "--keep", _H + "/runs/gate-297/kept-named"], stdout=_o, stderr=_e, cwd=_H + "/work/bench-hashes")
    _o.write(f"check exit {_r.returncode}\n")
