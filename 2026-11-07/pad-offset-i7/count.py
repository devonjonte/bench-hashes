import sys, glob
def per_unit(path, contender='blake3-servil-st', uc='ContinuousMessages', point='64 B'):
    for line in open(path):
        p = line.rstrip('\n').split('\t')
        if p[:4] == [contender, 'solo', uc, point]:
            units = [int(s.split('/')[1]) for s in p[5].split(',')]
            instr = [int(c.split(':')[2]) for c in p[9].split(',') if c]
            return sum(instr)/sum(units), units[0], [round(i/u, 3) for i, u in zip(instr, units)]
for f in sys.argv[1:]:
    print(f, per_unit(f))
