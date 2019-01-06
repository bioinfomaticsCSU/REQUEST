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
task=argv[2]
def rename(task,inf,out):
	fa_reader=open(inf)
	outf=open(out,'w+')
	con=0
	for line in fa_reader:
		if line.startswith('>'):
			outf.write(">"+task+".%d\n"% (con))
			con+=1
		else:
			outf.write(line)
	outf.flush()
	outf.close()
	fa_reader.close()
	pass
rename(task,raw,task+".fa")
