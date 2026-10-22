"""A dead worker should stop a sleeping sibling through its supervisor."""
import sys
import time
sys.path.insert(0, 'tools/verify')
import workers


def job(which):
    if which == 'fail':
        raise RuntimeError('deliberate worker failure')
    time.sleep(60)
    return 'sleep finished'


if __name__ == '__main__':
    for result in workers.each(job, ['fail', 'sleep'], 2):
        print(result, flush=True)
