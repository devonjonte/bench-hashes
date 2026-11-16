#!/bin/sh
# Which unprivileged command evicts one file from the page cache? Pages cached after each.
set -u
O="$HOME/runs/evict-010"
W="$HOME/work/evict-010"; rm -rf "$W"; mkdir -p "$W"; cd "$W"
{
stat -f -c 'filesystem %T' .
head -c 268435456 /dev/urandom > FILE
sync FILE; echo "sync exit $?"
cat FILE > /dev/null; printf 'after read: '; fincore -n -o PAGES FILE
dd of=FILE oflag=nocache conv=notrunc,fdatasync count=0 2> /dev/null; printf 'after dd of= nocache: '; fincore -n -o PAGES FILE
cat FILE > /dev/null; printf 'after read: '; fincore -n -o PAGES FILE
dd if=FILE iflag=nocache count=0 2> /dev/null; printf 'after dd if= nocache: '; fincore -n -o PAGES FILE
dd --version | head -1
} > "$O/evict.txt" 2>&1
rm -rf "$W"
echo DONE
