# coding:utf-8
# -*- coding: utf-8 -*-
#!/usr/bin/env python
from sys import argv
from collections import Counter
import sys
import string
import re
import os  
raw=argv[1]
def rename(inf,out):
	fa_reader=open(inf)
	outf=open(out,'w')
	con=0
	for line in fa_reader:
		line=line.split()	
		outf.write(">"+line[1]+"_"+line[0]+"\n"+line[2]+"\n")
	outf.flush()
	outf.close()
	fa_reader.close()
	pass
rename(raw,argv[2])
