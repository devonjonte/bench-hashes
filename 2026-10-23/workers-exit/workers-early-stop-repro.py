"""A caller that stops taking results early leaves no worker running."""
import os
import subprocess
import sys
import time
sys.path.insert(0, 'tools/verify')
import workers


def job(x):
    time.sleep(0.2 if x else 30)
    return x


if __name__ == '__main__':
    t = time.time()
    g = workers.each(job, [1, 0], 2)
    print(next(g))
    g.close()
    left = subprocess.run(['ps', '-o', 'args=', '--ppid', str(os.getpid())], capture_output=True, text=True).stdout
    left = sum('forkserver' not in l and 'resource_tracker' not in l and 'ps ' not in l for l in left.splitlines())
    print(f"early stop took {time.time() - t:.1f}s; children left: {left}")
