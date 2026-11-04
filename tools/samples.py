"""The one reader of bench-hashes samples files outside the program, for
Python tools that study results (AGENTS.md, "one implementation of every
rule"): comparisons and verdicts stay in bench-hashes (`compare`,
`regress`); a study reads the files here.

    import samples
    run = samples.read(path)
    run.headers["nonstop train"]          # a `# key: value` line
    run.cells[(contender, scenario, use_case, point)]   # [(ns, units), ...]
    run.cpus[key]                         # the CPU each sample's thread ended on, or None
    run.cores[key]                        # each sample's (P ns, P cycles, P instructions, E ns, E cycles, E instructions), or None
    samples.mean_ps(run.cells[key])       # picoseconds a unit, the cell's mean

A file of another version stops the reader (its own commit's tools read it).
"""
import collections

VERSION = "# bench-hashes samples v9"
COLUMNS = "contender\tscenario\tuse_case\tpoint\tunit\tns/units\tstart ms\tcpu ns\tenergy nJ\tcore counts\tcpu"

Run = collections.namedtuple("Run", "path headers cells cpus cores")


def read(path):
    """A samples file: its `# key: value` header lines, each cell's samples
    as (ns, units) in the order taken, keyed (contender, scenario, use case,
    point); and in the same order, the CPU each sample's thread ended on
    (None where the platform names none: macOS) and its thread's time and
    core cycles on each core kind (None where none was counted)."""
    with open(path) as f:
        lines = f.read().splitlines()
    assert lines and lines[0] == VERSION, f"{path}: a samples file begins with {VERSION!r}"
    headers, cells, cpus, cores, columns = {}, {}, {}, {}, False
    for line in lines[1:]:
        if line.startswith("#") or not line:
            if line.startswith("# ") and ": " in line:
                key, value = line[2:].split(": ", 1)
                headers[key] = value
        elif not columns:
            assert line == COLUMNS, f"{path}: the column row"
            columns = True
        else:
            fields = line.split("\t")
            assert len(fields) == 11, f"{path}: a row of eleven fields: {line}"
            key = tuple(fields[:4])
            assert key not in cells, f"{path}: {key} twice"
            cells[key] = [tuple(int(x) for x in s.split("/")) for s in fields[5].split(",")]
            cpus[key] = None if fields[10] == "-" else [int(c) for c in fields[10].split(",")]
            assert cpus[key] is None or len(cpus[key]) == len(cells[key]), f"{path}: {key}: a CPU for each sample"
            cores[key] = None if fields[9] == "-" else [tuple(int(x) for x in c.split(":")) for c in fields[9].split(",")]
            assert cores[key] is None or all(len(c) == 6 for c in cores[key]) and len(cores[key]) == len(cells[key]), f"{path}: {key}: six counts for each sample"
    return Run(path, headers, cells, cpus, cores)


def mean_ps(samples):
    """A cell's mean, as bench-hashes takes it (total time over total work),
    in picoseconds a unit, rounded once."""
    ns = sum(n for n, _ in samples)
    units = sum(u for _, u in samples)
    return (ns * 1000 + units // 2) // units


def machine(path):
    """A run's machine, from its file's path (benchmark-results/MACHINE/...)."""
    parts = path.split("/")
    return parts[-2] if parts[-1] == "bench-hashes.samples.tsv" else parts[-1].removesuffix(".tsv")
