# Provenance through the existing overview section

Zooko's contract: readers seeking provenance look in “About the hashes compared”.
Results readers should see machine metadata directly beside results, with the
long version/commit line moved out of that layout. Preserve the recorded identities
of every compared run, including file tools and the earlier-release comparison.

Implementation: keep the existing collapsed section. Inside, group records by
machine and by library/file/earlier-library run using native details elements.
Reuse map::details for the complete recorded header, build settings and samples
link; retain full benchmark version strings there. Earlier-format rows expose
their recorded header strings through the existing header-only path. Their
measurement rows stay with their original readers. Four old maps predate #run;
showing the headers here gives every machine the same reader-facing entry.
Remove the overview grid's version line. Give opened records readable contrast and
phone wrapping. Use the same source-compatible CSS correction on stored maps.

Validation: fixed source identities for distinct library/file/before records;
escaping and full-version anchors; a browser path through the existing section on
desktop and phone. Closed means no long provenance strings in the results layout;
open means exact identities and functioning commit/sample links. Negative controls
remove a source or expose the closed contents. Re-render only the overview; stored
map patches must reverse to original bytes, preserving every measured payload.
Check manifests, exact-head CI, landed tree and live deployment before closing.
Timed calls and statistical rules stay unchanged; dedicated timing checks add no
information about this presentation change and are skipped.
