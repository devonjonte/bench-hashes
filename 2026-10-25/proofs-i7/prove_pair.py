import sys
sys.path.insert(0, 'tools/verify')


def main():
    sys.argv = ['prove_x86.py']
    import prove_x86 as p, workers, x86
    todo = [(isa, w, "hash_many", (2, b, True)) for w in (False, True) for isa in ("avx2", "avx512") for b in range(1, 16)]
    for isa, w in {(c[0], c[1]) for c in todo}:
        so = p.assemble(isa, w); x86.symbols(so); x86.image(so)
    bad = 0
    for (isa, w, kind, arg), verdict in workers.each(p.prove_case, todo, 8):
        print(isa, "windows" if w else "unix", arg, ":", verdict, flush=True)
        bad += not verdict.startswith("proved")
    print(f"{len(todo) - bad} of {len(todo)} cases proved")


if __name__ == "__main__":
    main()
