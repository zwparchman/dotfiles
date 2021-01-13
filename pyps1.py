#!/usr/bin/env python3
import os, sys, argparse, pwd, platform
import subprocess

def getUsername():
    return pwd.getpwuid( os.getuid() )[0]

def getComputerName():
    return platform.uname()[1]

def gitStr():
    try:
        fin = subprocess.run(['git', 'rev-parse', '--abbrev-ref', 'HEAD' ], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
        if fin.returncode != 0:
            return ""

        return f" \x1b[92m[{str(fin.stdout, 'utf-8').strip()}]\x1b[39m"
    except:
        return " [git-error]"

def main():
    where=f"{getUsername()}@{getComputerName()}"
    path=os.getcwd()
    git=gitStr()
    print(f"{where} {path}{git}\n$ ", end='')

if __name__ == "__main__":
    main()
