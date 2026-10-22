# The overview, first drawing (October 22, 2026)

`bench-hashes overview` at source `89dbbf19` (devonjonte/bench-hashes,
`candidate/devon-overview`), run on the three published runs of
bench-hashes 0.16.1 (i7-12700K, Apple M4 Max, the VM on it), from
upstream main `a23f994a`'s `benchmark-results/`.

- `overview-run.txt`: the command's text output (the grid and headline).
- `index-89dbbf19.html`: the page it wrote.
- `shot6.png`: the page in Chromium at 1280 px, a Mac user agent.
- `FROZEN-overview-draft.md`: the draft of FROZEN's section, as Zooko
  edited it in conversation (files: the mixed tree; sha1sum and md5sum).

The figures are those runs' plain means (0.16.1's rule) and carry no
verdict; they illustrate the page, not a comparison between releases.

`f54f2908`: the page as bars (`index-f54f2908.html`, `shot-bars.png`), after Zooko asked for shapes in place of figures and the map's presentation.

`e0017273`: toggles, one colour one name, scales in GB/s, the map's tooltip (`shot-looked-at.png`); `overview-run-e0017273.txt` adds Sam Shackleton's EPYC 9255 run (bench-hashes#63, `d1eb15f3`).
