#!/bin/sh
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/runs/bench-bisect && python3 bisect.py
cat log.txt
