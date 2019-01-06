#!/usr/bin/env python
from sys import argv

def fa2fa(org,out):
    fin=open(org,"r")
    fout=open(out,"w")
    seq=""
    while 1:
        line=fin.readline()
        if not line:
            break
        if line.startswith(">"):
            if seq!="":
                fout.write(seq+"\n")
            seq=""
            fout.write(line.strip("\n").strip(">")+"\t")
        else:
            line=line.strip("\n")
            seq+=line
    fout.write(seq+"\n")
    fin.close()
    fout.close()

if __name__=="__main__":
    org=argv[1]
    out=argv[2]
    fa2fa(org,out)