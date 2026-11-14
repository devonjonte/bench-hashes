#!/bin/sh
set -eu
cd <development-home>/bench-hashes-validation/autonomous-20261114/grid-input/current
npm exec --yes --package=envinfo@7.21.0 -- envinfo --preset playwright
