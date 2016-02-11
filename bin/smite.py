#!/usr/bin/env python

import sh
import re
import math
import sys

ps = sh.ps
ps = ps.bake(["-U", "zack", "-o", "pid,%cpu,%mem,command"])

lines = str(ps()).lower().splitlines()
head = lines[0]
out = []
if len(lines) > 1 :
    out = lines[1:]
    out = filter( lambda x: len(x) > 0, out)

print head

to_find = sys.argv[1].lower()
r = re.compile(to_find)

#preform the search
out = list(filter( lambda x : r.search(x), out))

width = int(math.ceil(math.log10(len(out))))+1

for i in range( len(out)):
    print (str(i)+")").ljust(width), out[i]

try:
    num = int(raw_input("What number should be killed? "))
except ValueError:
    print ("Not an integer. Aborting")
    sys.exit(1)

if num < 0 or num >= len( out ):
    print ("Invalid index. Aborting")
    sys.exit(1)

pid_to_kill = out[num].split()[0]

print pid_to_kill

sh.kill.bake([str(pid_to_kill)])()
