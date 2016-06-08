#!/usr/bin/env python

import sh
import re
import math
import sys
import argparse

parser = argparse.ArgumentParser(description = "kill a process after searching for it by name",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("-u","--user", default="", type=str, help="The user's processes to check")
parser.add_argument("-s","--signal", default=15, metavar="S", type=int,
        help="Signal to send to the selected process.")
parser.add_argument("search_string", nargs="+", action='append', help="The string[s] to search for. Case insensitive")

args = parser.parse_args()

find_list = args.search_string[0]
for s in find_list:
    s = s.lower()

user=None
try:
    user = args.user
except IndexError:
    pass


signal = args.signal

ps = sh.ps
if user == "":
    user = str(sh.whoami()).strip()

print "user:'"+user+"'"

ps = ps.bake(["-U", user])
ps = ps.bake(["-o", "pid,%cpu,%mem,command"])

lines = str(ps()).lower().splitlines()
head = lines[0]
out = []
if len(lines) > 1 :
    out = lines[1:]
    out = filter( lambda x: len(x) > 0, out)

out=out[:]
print head


#remove all elements not containing an element from the find_list from the output set
for f in find_list:
    r = re.compile(f, re.IGNORECASE)
    out = list(filter( lambda x : r.search(x), out))

width = 0
if len(out) != 0 :
    width = int(math.ceil(math.log10(len(out))))+1
else:
    print "nothing found, quitting"
    sys.exit(0)


for i in range( len(out)):
    print (str(i)+")").ljust(width), out[i]

killlist=[]

text = raw_input("What number should be killed? ").strip()
if "," in text or " " in text:
    text_lst = text.replace(","," ").split()
    try:
        killlist = list( map( int, text_lst))
    except ValueError:
        print ("Non integer found in the list")
        sys.exit(1)
else:
    try:
        num = int(text)
        killlist=[num]
    except ValueError:
        print ("Not an integer or integer list. Aborting")
        sys.exit(1)

def kill(pid, sig):
    kill=sh.kill.bake(["-"+str(sig), str(pid)])
    kill()


for num in killlist:
    if num < 0 or num >= len( out ):
        print ("Invalid index. Aborting")
        sys.exit(1)

    pid_to_kill = out[num].split()[0]

    kill(pid_to_kill, signal)
