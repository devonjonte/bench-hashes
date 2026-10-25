"""prove_x86.py --representative with 2 workers in place of 16, so the
largest cases' Z3 processes fit this machine's memory at once."""
import sys
sys.path.insert(0, 'tools/verify')


def main():
    sys.argv = ['prove_x86.py']
    import prove_x86 as p, workers, x86
    todo = p.cases(set())
    for isa, w in {(c[0], c[1]) for c in todo}:
        so = p.assemble(isa, w); x86.symbols(so); x86.image(so)
    todo.sort(key=lambda c: -(c[3][0] * c[3][1] if isinstance(c[3], tuple) else (c[3] or 1)))
    bad = 0
    for (isa, w, kind, arg), verdict in workers.each(p.prove_case, todo, 2):
        print(isa, "windows" if w else "unix", kind, arg, ":", verdict, flush=True)
        bad += not verdict.startswith("proved")
    print(f"{len(todo) - bad} of {len(todo)} cases proved")


if __name__ == "__main__":
    main()
