#!/bin/sh
export PATH=$HOME/.cargo/bin:$PATH
cd $HOME/runs/sessions && python3 sessions.py
cat log.txt
