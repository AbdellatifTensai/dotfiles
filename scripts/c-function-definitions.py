#!/bin/python3
import re
import sys

def loadtxt(filename):
    "Load text file into a string. I let FILE exceptions to pass."
    f = open(filename)
    txt = ''.join(f.readlines())
    f.close()
    return txt

rproc = r"((?<=[\s:~])(\w+)\s*\(([\w\s,<>\[\].=&':/*]*?)\)\s*(const)?\s*(?={))"

if len(sys.argv) < 2:
    print('no file path provided')
    exit(1)
filename = sys.argv[1]

code = loadtxt(filename)
cppwords = ['if', 'while', 'do', 'for', 'switch']
procs = [(i.start(), i.group(2), i.group(3)) for i in re.finditer(rproc, code) if i.group(2) not in cppwords]

for i in procs: print(filename + ':' +str(i[0]) + ': ' + i[1] + '(' + i[2] + ')')
