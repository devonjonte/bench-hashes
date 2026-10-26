"""mutants.py's x86 stages alone (the Arm stage needs AArch64 binutils):
main()'s x86 loops, unchanged."""
import sys
sys.path.insert(0, 'tools/verify')
import multiprocessing
import mutants as m, workers
FORK = multiprocessing.get_context("fork")


def main():
    failures = 0
    for result in workers.each(m.x86_positive, [None], 1, FORK):
        print(f"AVX2 mutant-domain positive control: proved {result}", flush=True)
    for line, failed in workers.each(m.run, m.x86_mutant_jobs(), 2, FORK):
        print(line, flush=True); failures += failed
    for result in workers.each(m.x86_memory_positive, [None], 1, FORK):
        print(f"x86 memory-mutant positive controls: proved {result}", flush=True)
    for line, failed in workers.each(m.run, m.x86_memory_mutant_jobs(), 2, FORK):
        print(line, flush=True); failures += failed
    for line, failed in workers.each(m.run, m.chunk_root_mutant_jobs(), 2, FORK):
        print(line, flush=True); failures += failed
    print(f"x86 stages: {failures} failures")
    sys.exit(1 if failures else 0)


if __name__ == "__main__":
    main()
