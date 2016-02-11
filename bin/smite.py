#!/usr/bin/env python

import sh
import re
import math
import sys
import argparse

parser = argparse.ArgumentParser(description = "kill a process after searching for it by name",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("-s","--signal", default=15, metavar="S", type=int,
        help="Signal to send to the selected process.")
parser.add_argument("search_string", nargs="+", action='append', help="The string[s] to search for. Case insensitive")

args = parser.parse_args()

find_list = args.search_string[0]
for s in find_list:
    s = s.lower()

signal = args.signal

ps = sh.ps.bake(["-U", "zack", "-o", "pid,%cpu,%mem,command"])

lines = str(ps()).lower().splitlines()
head = lines[0]
out = []
if len(lines) > 1 :
    out = lines[1:]
    out = filter( lambda x: len(x) > 0, out)

print head


#remove all elements not containing an element from the find_list from the output set
for f in find_list:
    r = re.compile(f)
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

kill=sh.kill.bake(["-"+str(signal), str(pid_to_kill)])
kill()

