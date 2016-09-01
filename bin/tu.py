#!/usr/bin/env python3
"""Tmux utility program"""


import subprocess
import os
import sys
import re

class Action:
    def __init__(self,regex, function):
        self.raw = regex
        self.regex = re.compile(regex)
        self.function=function

    def __call__(self):
        self.function()

    def match(self, s):
        return bool(self.regex.match(s))

def select_action():
    while True:
        choice = input("tu> ")
        for action in actions:
            if(action.match(choice)):
                action()
                break
        else:
            print("Invalid choice: try help for help")


    if(re.match(R"^movew$", choice)):
        session_name = select_session()
        window_name = select_window(session_name)
        #get arguments



class Tmux_Error(Exception):
    pass

def tmux_do(s):
    pipe = subprocess.Popen("tmux "+s, 
            shell=True,
            stdout=subprocess.PIPE,
            stdin=subprocess.DEVNULL,
            stderr=subprocess.PIPE)

    out,err = pipe.communicate()
    ret = pipe.wait()
    if ret:
        print (err)
        raise Tmux_Error("tmux "+s +" returned an error")
    return str(out, 'utf8')

def get_sessions():
    return tmux_do("ls")

def get_windows(session):
    return tmux_do("lsw -t {}".format(session))

def print_help():
    """Print this message"""
    for action in actions:
        print (action.raw, "--> ", action.function.__doc__)

def quit():
    """Quit the program"""
    sys.exit()

def move_window():
    """Move a window from one session to another"""
    out = get_sessions()
    print(out)

    source = input("To session: ")
    target = input("From session: ")

    win_list = get_windows(target)
    print(win_list)
    win = input("Target Window: ")

    tmux_do("movew -t {} -s {}:{}".format(source,target,win))

actions=[
        Action(R"^(h|help)$", print_help),
        Action(R"^movew$", move_window),
        Action(R"^(q|quit)$",quit)
        ]

    

def main():
    select_action()


if __name__ == "__main__":
    ret = main()
    if ret :
        sys.exit(ret)
    sys.exit(0)
