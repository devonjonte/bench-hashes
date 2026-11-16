#!/usr/bin/env python3
"""Build the tables of the 0.8 -> 0.9 -> 0.10 page from the hosts' deliveries.

b3sum cells are copied from each run's own report; library verdicts are
`bench-hashes compare`'s own lines over the kept check runs (evolve.py). This
script groups, counts and formats; it judges nothing and reads no sample.
Usage: page.py OUT_DIR   (writes tables/*.md and per-host pages; prints the summaries)
"""
from pathlib import Path
import re, statistics, sys
sys.path.insert(0, str(Path(__file__).parent))
import evolve

INBOX = Path("/home/agent/bench-hashes-validation/inbox")
DATA = Path("/home/agent/bench-hashes-data")
HOSTS = ["x86-epyc-9275f", "x86-epyc-9255", "x86-9700x", "x86-icelake", "x86-icelake-2", "x86-avx2"]

def field(text, name):
    return next((l.split(":", 1)[1].strip() for l in text.splitlines() if l.startswith(name + ":")), "?")

def sections(text):
    """[(title, contender names, {input: [cell text per contender]})] for the time tables."""
    lines, out = text.splitlines(), []
    for i, line in enumerate(lines):
        if line.startswith("input ") and i >= 2 and lines[i - 1].startswith("mean time"):
            names, rows = line.split()[1:], {}
            for row in lines[i + 1:]:
                if not row.strip():
                    break
                cells = re.split(r"\s{2,}", row.rstrip())
                assert len(cells) == len(names) + 1, cells
                rows[cells[0]] = cells[1:]
            out.append((lines[i - 2].strip(), names, rows))
    assert out
    return out

def short(cell):
    return re.sub(r" [\d.]+ GB/s", "", cell).replace(" x", " ×")

def ratio(cell):
    """('0.771', 'faster'|'slower'|'') from a judged cell."""
    m = re.search(r" x([\d.]+)(?: (slower|faster))?$", cell)
    assert m, cell
    return m.group(1), m.group(2) or ""

def mark(cell):
    r, label = ratio(cell)
    return f"**×{r}**" if label else f"×{r}"

def b3sum_host_page(host, text):
    out = [f"# b3sum 0.8.0, 0.9.0 and the 0.10 candidate: {field(text, 'machine')}", "",
           f"Host `{host}`; files on {field(text, 'files on')}. Load: {field(text, 'load')}. Runs: {field(text, 'runs')}.", "",
           "Each cell: mean time per run from the process's start to its exit, then the time ratio against `b3sum-0.9.0` "
           "(the geometric mean of the rounds' ratios; below 1 is faster). The words slower and faster appear where the rounds' pairs agree; "
           "an unmarked ratio is insufficient evidence of a difference. Copied from `b3sum.stdout.txt` in this host's evidence folder.", ""]
    for title, names, rows in sections(text):
        out += [f"## {title}", "", "| input | " + " | ".join(names) + " |", "|---|" + "---:|" * len(names)]
        out += ["| " + name + " | " + " | ".join(short(c) for c in cells) + " |" for name, cells in rows.items()]
        out.append("")
    return "\n".join(out)

def summary(reports, column, caption):
    """One table: inputs down, hosts across, the named column's judged ratio."""
    hosts = list(reports)
    out = []
    for index, state in enumerate(["warm", "cold"]):
        out += [f"**{caption}, {state} files**", "", "| input | " + " | ".join(f"`{h}`" for h in hosts) + " |", "|---|" + "---:|" * len(hosts)]
        first = sections(reports[hosts[0]])[index]
        for name in first[2]:
            cells = []
            for h in hosts:
                _title, names, rows = sections(reports[h])[index]
                cells.append(mark(rows[name][names.index(column)]))
            out.append(f"| {name} | " + " | ".join(cells) + " |")
        out.append("")
    return "\n".join(out)

def across(reports, column, caption):
    """Inputs down; per file state the range of the hosts' judged ratios and how many hosts mark it."""
    hosts = list(reports)
    out = [f"**{caption}** ({len(hosts)} machines; time ratio, below 1 is faster)", "",
           "| input | warm: range | warm: machines faster / slower | cold: range | cold: machines faster / slower |", "|---|---:|---:|---:|---:|"]
    first = sections(reports[hosts[0]])
    for name in first[0][2]:
        cells = [name]
        for index in (0, 1):
            pairs = []
            for h in hosts:
                _title, names, rows = sections(reports[h])[index]
                pairs.append(ratio(rows[name][names.index(column)]))
            values = [float(r) for r, _ in pairs]
            cells += [f"×{min(values):.2f}–×{max(values):.2f}", f"{sum(l == 'faster' for _, l in pairs)} / {sum(l == 'slower' for _, l in pairs)}"]
        out.append("| " + " | ".join(cells) + " |")
    return "\n".join(out)

def reading(reports, column):
    """The across-table said in words: which inputs every machine marks, which some, which none."""
    hosts = list(reports)
    groups = {"all": {}, "some": {}, "level": {}, "slower": {}}
    values_all = []
    first = sections(reports[hosts[0]])
    for index, state in enumerate(["warm", "cold"]):
        for name in first[index][2]:
            pairs = []
            for h in hosts:
                _title, names, rows = sections(reports[h])[index]
                pairs.append(ratio(rows[name][names.index(column)]))
            values_all += [float(r) for r, _ in pairs]
            faster, slower = sum(l == "faster" for _, l in pairs), sum(l == "slower" for _, l in pairs)
            if slower:
                groups["slower"].setdefault(name, []).append(state)
            group = "all" if faster == len(hosts) else "some" if faster else None if slower else "level"
            if group:
                groups[group].setdefault(name, []).append(state)
    def said(group):
        return "; ".join(f"{name} ({' and '.join(states)})" for name, states in group.items())
    cells = 2 * len(first[0][2])
    if sum(len(v) for v in groups["all"].values()) == cells:
        return f"- **Faster on every input, warm and cold, on all {len(hosts)} machines:** from ×{max(values_all):.2f} to ×{min(values_all):.2f}."
    out = []
    if groups["all"]:
        out.append(f"- **Faster on all {len(hosts)} machines:** " + said(groups["all"]) + ".")
    if groups["some"]:
        out.append("- **Faster on some machines:** " + said(groups["some"]) + ".")
    if groups["level"]:
        out.append("- **Level on every machine:** " + said(groups["level"]) + ".")
    out.append("- **Slower on a machine:** " + (said(groups["slower"]) + "." if groups["slower"] else "no input, warm or cold."))
    return "\n".join(out)

def marks(text, column):
    """{(state, input): 'faster'|'slower'|''} for one report's judged column."""
    out = {}
    for index, state in enumerate(["warm", "cold"]):
        _title, names, rows = sections(text)[index]
        for name, cells in rows.items():
            out[(state, name)] = ratio(cells[names.index(column)])[1]
    return out

def again(first, second, column):
    """How the second run of the same programs marks what the first run marked."""
    hosts = [h for h in first if h in second]
    if not hosts:
        return ""
    count = {"faster": [0, 0, 0], "slower": [0, 0, 0]}  # both runs, the first only, the second only
    named = {"slower": []}
    for h in hosts:
        a, b = marks(first[h], column), marks(second[h], column)
        for key in a:
            for label in ("faster", "slower"):
                one, two = a[key] == label, b[key] == label
                if one or two:
                    count[label][0 if one and two else 1 if one else 2] += 1
                    if label == "slower":
                        named["slower"].append(f"`{h}` {key[1]}, {key[0]} ({'both runs' if one and two else 'the first run only' if one else 'the second run only'})")
    f, sl = count["faster"], count["slower"]
    text = (f"**A second run** of the same programs on {len(hosts)} machines, each machine's 20 cells again: "
            f"{f[0]} cells are marked faster in both runs, {f[1]} in the first only and {f[2]} in the second only. ")
    text += ("Marked slower: " + "; ".join(named["slower"]) + "." if named["slower"] else "Neither run marks a cell slower.")
    return text

MAC = "apple-m6"
MAC_RESULTS = Path("/home/agent/mac-runner/results")
MAC_B3SUM = Path("/home/agent/bench-pin-move/benchmark-results/AppleM6.darwin27/b3sum.result.txt")

def mac_job(number):
    """The dedicated timing Mac's kept samples for a job, or a path that is absent."""
    found = sorted(MAC_RESULTS.glob(f"{number}-*-mac-m6-timing"))
    return found[-1] / "samples" if found and (found[-1] / "complete.json").exists() else Path("/absent")

def single(text, column, base):
    """One machine's judged column beside its base, warm and cold."""
    warm, cold = sections(text)[0], sections(text)[1]
    out = [f"| input | warm: {base} | warm: {column} | cold: {base} | cold: {column} |", "|---|---:|---:|---:|---:|"]
    for name in warm[2]:
        cells = [name]
        for _title, names, rows in (warm, cold):
            cells += [short(rows[name][names.index(base)]), short(rows[name][names.index(column)])]
        out.append("| " + " | ".join(cells) + " |")
    return "\n".join(out)

TRANSITIONS = [
    ("0.8.0 → 0.9.0", lambda h: DATA / "2026-11-13/release-022" / h / "kept-core"),
    ("0.9.0 → 0.10 candidate", lambda h: mac_job(3210) if h == MAC else INBOX / h / "release-023-cade30fd/kept-release"),
    ("0.8.0 → 0.10 candidate", lambda h: INBOX / h / "evolution-010/kept-08-to-010"),
]

CONTROL = lambda h: mac_job(3211) if h == MAC else INBOX / h / "release-023-cade30fd/kept-control"

def library(host):
    """(page text, {step: {form: [cells, faster, slower, moved with the benchmark's call]}})."""
    out, counts = [f"# The library's cells, 0.8.0 → 0.9.0 → 0.10 candidate: `{host}`", "",
                   "Every verdict is `bench-hashes compare`'s over the kept runs of a release check. A time ratio below 1 is faster. "
                   "Faster and slower need the pairs to agree; every other cell is level, which means insufficient evidence of a difference.", ""], {}
    for name, where in TRANSITIONS:
        folder = where(host)
        if not folder.is_dir():
            continue
        sides, rows, pairs = evolve.compare(folder)
        moved = {}
        if name.startswith("0.9.0") and CONTROL(host).is_dir():
            control_sides, control_rows, _pairs = evolve.compare(CONTROL(host))
            moved = {r["key"]: r for r in control_rows if r["label"].lower() in ("faster", "slower")}
        forms = {}
        for r in rows:
            form = evolve.NAMES.get(r["key"].split("|", 1)[0], r["key"].split("|", 1)[0])
            c = forms.setdefault(form, [0, 0, 0, 0])
            if r["key"] in moved:
                c[3] += 1
                continue
            c[0] += 1; c[1] += r["label"].lower() == "faster"; c[2] += r["label"].lower() == "slower"
        counts[name] = forms
        for form in forms:
            best = min((r for r in rows if r["key"] not in moved and r["label"].lower() == "faster" and evolve.NAMES.get(r["key"].split("|", 1)[0]) == form),
                       key=lambda r: float(r["ratio"]), default=None)
            forms[form].append(f"{' · '.join(best['key'].split('|')[1:])} ×{best['ratio']}" if best else "")
        _sides, head, body = evolve.table(folder, frozenset(moved))
        out += [f"## {name}", "", "`" + "`; `".join(s.removeprefix("compare: ") for s in sides) + "`", "", head, "", body, ""]
        kept = [r for r in rows if r["key"] not in moved]
        slower = [r for r in kept if r["label"].lower() == "slower"]
        faster = sorted((r for r in kept if r["label"].lower() == "faster"), key=lambda r: float(r["ratio"]))[:10]
        if slower:
            out += ["Slower cells, each by name:", ""] + [f"- `{r['key']}`: ×{r['ratio']}" for r in slower] + [""]
        if faster:
            out += ["The ten largest gains:", ""] + [f"- `{r['key']}`: ×{r['ratio']}" for r in faster] + [""]
        if moved:
            by_key = {r["key"]: r for r in rows}
            out += [f"### Cells that move with the benchmark's own call ({len(moved)})", "",
                    "The two bench releases call the library differently in these cells: the same library "
                    f"(`{control_sides[1].removeprefix('compare: new side: ')}`) under both benches already differs, so the tables above leave them out. "
                    "Each line: the release comparison's ratio, then the same-library control's.", ""]
            out += [f"- `{k}`: ×{by_key[k]['ratio']} {by_key[k]['label']}; control ×{c['ratio']} {c['label']}" for k, c in moved.items() if k in by_key] + [""]
    return "\n".join(out), counts

def main(out_dir):
    out = Path(out_dir); (out / "b3sum").mkdir(parents=True, exist_ok=True); (out / "library").mkdir(exist_ok=True); (out / "tables").mkdir(exist_ok=True)
    evo, official = {}, {}
    for h in HOSTS:
        p = INBOX / h / "evolution-010/b3sum.stdout.txt"
        if (INBOX / h / "evolution-010/stdout.txt").exists() and "EVOLUTION_EXIT=0" in (INBOX / h / "evolution-010/stdout.txt").read_text():
            evo[h] = p.read_text()
            (out / "b3sum" / f"{h}.md").write_text(b3sum_host_page(h, evo[h]))
        official[h] = (INBOX / h / "release-023-cade30fd/b3sum.stdout.txt").read_text()
    evo2 = {h: (INBOX / h / "evolution-010-b3sum-again/b3sum.stdout.txt").read_text() for h in evo
            if (INBOX / h / "evolution-010-b3sum-again/stdout.txt").exists() and "AGAIN_EXIT=0" in (INBOX / h / "evolution-010-b3sum-again/stdout.txt").read_text()}
    (out / "tables").mkdir(exist_ok=True)
    (out / "tables" / "AGAIN-09.md").write_text(again(evo, evo2, "b3sum-0.10-candidate") + "\n")
    for h, text in evo2.items():
        (out / "b3sum" / f"{h}-second-run.md").write_text(b3sum_host_page(h, text).replace("# b3sum 0.8.0, 0.9.0 and the 0.10 candidate:", "# The second run of b3sum 0.8.0, 0.9.0 and the 0.10 candidate:", 1).replace("in this host's evidence folder", "in this host's `evolution-010-b3sum-again` evidence folder"))
    a = summary(evo, "b3sum-0.10-candidate", "b3sum 0.10 candidate against b3sum 0.9.0")
    b = summary(evo, "b3sum-0.8.0", "b3sum 0.8.0 against b3sum 0.9.0")
    c = summary(official, "b3sum", "b3sum 0.10 candidate against official b3sum 1.8.7")
    loads = "\n".join(f"- `{h}`: {field(t, 'machine')}; {field(t, 'load')}; {field(t, 'runs')}" for h, t in evo.items())
    for name, text in [("READING-OFFICIAL", reading(official, "b3sum")), ("READING-09", reading(evo, "b3sum-0.10-candidate")), ("READING-08", reading(evo, "b3sum-0.8.0"))]:
        (out / "tables" / f"{name}.md").write_text(text + "\n")
    lib_rows = ["| host | step | form | cells | faster | slower | left out: the benchmark's call changed |", "|---|---|---|---:|---:|---:|---:|"]
    mac = MAC_B3SUM.read_text()
    (out / "tables" / "mac-vs-official.md").write_text(
        f"Load: {field(mac, 'load')}. Runs: {field(mac, 'runs')}.\n\n" + single(mac, "b3sum", "official") + "\n\n" + reading({MAC: mac}, "b3sum").replace("on all 1 machines", "there").replace("on a machine", "there").replace("on every machine", "there") + "\n")
    for h in HOSTS + [MAC]:
        if h == MAC and not CONTROL(h).is_dir():
            continue  # its counts wait for its same-library control
        text, counts = library(h)
        (out / "library" / f"{h}.md").write_text(text)
        for step, forms in counts.items():
            for form, (cells, faster, slower, moved, best) in forms.items():
                lib_rows.append(f"| `{h}` | {step} | {form} | {cells} | {faster} | {slower} | {moved or ''} | {best} |")
    totals = {}
    for row in lib_rows[2:]:
        h, step, form, cells, faster, slower = [c.strip() for c in row.split("|")][1:7]
        totals.setdefault((step, form), []).append((int(cells), int(faster), int(slower)))
    words = []
    for (step, form), rows in totals.items():
        f, sl = [r[1] for r in rows], [r[2] for r in rows]
        words.append(f"- **{step}, {form}** ({len(rows)} machines): {min(f)} to {max(f)} cells faster and {min(sl)} to {max(sl)} slower per machine, of {" to ".join(map(str, sorted({min(r[0] for r in rows), max(r[0] for r in rows)})))}.")
    (out / "tables" / "READING-LIBRARY.md").write_text("\n".join(words) + "\n")
    for name, text in [("across-010-vs-09", across(evo, "b3sum-0.10-candidate", "b3sum 0.10 candidate against b3sum 0.9.0")),
                       ("across-08-vs-09", across(evo, "b3sum-0.8.0", "b3sum 0.8.0 against b3sum 0.9.0")),
                       ("across-010-vs-official", across(official, "b3sum", "b3sum 0.10 candidate against official b3sum 1.8.7")),
                       ("b3sum-010-vs-09", a), ("b3sum-08-vs-09", b), ("b3sum-010-vs-official", c), ("hosts", loads), ("library", "\n".join(lib_rows))]:
        (out / "tables" / f"{name}.md").write_text(text + "\n")
    return evo

def readme(out_dir):
    """README.md from README.in.md: each @@name@@ is a generated table or a section of readings.md."""
    out, here = Path(out_dir), Path(__file__).parent
    parts, name = {}, None
    for line in (here / "readings.md").read_text().splitlines():
        if line.startswith("@@") and line.endswith("@@"):
            name = line.strip("@"); parts[name] = []
        elif name:
            parts[name].append(line)
    parts = {k: "\n".join(v).strip() for k, v in parts.items()}
    for table in (out / "tables").glob("*.md"):
        parts[table.stem] = table.read_text().strip()
    hosts = sorted(p.stem for p in (out / "b3sum").glob("*.md") if not p.stem.endswith("-second-run"))
    parts["B3SUM-PAGES"] = ", ".join(f"[`{h}`](b3sum/{h}.md)" for h in hosts) + "."
    parts["LIBRARY-PAGES"] = ", ".join(f"[`{p.stem}`](library/{p.stem}.md)" for p in sorted((out / "library").glob("*.md"))) + "."
    text = (here / "README.in.md").read_text()
    for name, value in parts.items():
        text = text.replace(f"@@{name}@@", value)
    for name, value in parts.items():
        text = text.replace(f"@@{name}@@", value)
    assert "@@" not in text, [l for l in text.splitlines() if "@@" in l]
    (out / "README.md").write_text(text)

def evidence(out_dir):
    """The deliveries the page reads, beside it: logs with the home prefix redacted, samples as delivered."""
    import shutil
    out, here = Path(out_dir), Path(__file__).parent
    def copy(src, dst):
        for p in src.rglob("*"):
            if p.is_file():
                q = dst / p.relative_to(src); q.parent.mkdir(parents=True, exist_ok=True)
                data = p.read_bytes()
                q.write_bytes(data if p.suffix in {".tsv", ".html", ".svg"} else data.replace(b"/home/devon", b"<worker-home>"))
    for h in HOSTS:
        if (out / "b3sum" / f"{h}.md").exists():
            copy(INBOX / h / "evolution-010", out / "evidence" / h / "evolution-010")
            if (out / "b3sum" / f"{h}-second-run.md").exists():
                copy(INBOX / h / "evolution-010-b3sum-again", out / "evidence" / h / "evolution-010-b3sum-again")
    for run in ("recipe-010", "recipe-010-v2", "evict-010"):
        copy(INBOX / "x86-workhorse" / run, out / "evidence/recipe" / run)
    (out / "tools").mkdir(exist_ok=True)
    for name in ("evolution.sh", "b3sum-again.sh", "b3sum-again-all.sh", "recipe.sh", "recipe2.sh", "evict.sh", "evolve.py", "page.py", "README.in.md", "readings.md"):
        shutil.copyfile(here / name, out / "tools" / name)

if __name__ == "__main__":
    main(sys.argv[1])
    if "--publish" in sys.argv:
        readme(sys.argv[1]); evidence(sys.argv[1])
