"""A one-shot FIFO writer must suffice for one named FIFO, alone or beside a file.
Correctness/liveness test, not timing. Each child has a five-second deadline.
"""
import os, subprocess, sys, tempfile, threading
from pathlib import Path
binary = sys.argv[1]
root = Path(__file__).resolve().parent
for extra in [False, True]:
    with tempfile.TemporaryDirectory(dir=root) as d:
        d = Path(d)
        fifo, regular = d / 'fifo', d / 'regular'
        os.mkfifo(fifo)
        regular.write_bytes(b'abc')
        def write_once():
            with fifo.open('wb', buffering=0) as f:
                f.write(b'abc')
        writer = threading.Thread(target=write_once, daemon=True)
        writer.start()
        command = [binary, '--num-threads', '1', str(fifo)] + ([str(regular)] if extra else [])
        child = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        try:
            stdout, stderr = child.communicate(timeout=5)
            print(f'extra_file={extra} exit={child.returncode} hashes={[line.split()[0].decode() for line in stdout.splitlines()]} stderr={stderr.decode()!r}')
        except subprocess.TimeoutExpired:
            child.kill()
            stdout, stderr = child.communicate()
            print(f'extra_file={extra} TIMEOUT writer_finished={not writer.is_alive()} stdout={stdout!r} stderr={stderr!r}')
        writer.join(timeout=1)
        assert not writer.is_alive(), 'writer did not finish'
