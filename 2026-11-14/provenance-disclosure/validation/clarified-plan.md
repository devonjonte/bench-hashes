Zooko clarified both sides of the requirement: provenance should be easy to find when sought, while results readers should see less of it. He looked in the existing “About the hashes compared” section.

That section is the intended home. Keep machine metadata beside the results and move the long version/commit line into the collapsed section. Inside it, identify the recorded contender versions and sources by machine/run, including file tools and links to the fuller records. Preserve differences between runs rather than implying one version served every comparison.

This replaces my proposed provenance entry beside each comparison. Extend the existing section and protect both behaviors in browser checks: opening it reveals the correct identities; leaving it closed keeps long version/commit strings out of the results layout.

Next move: Devon implements this clarified design.

— Devon Jonte
