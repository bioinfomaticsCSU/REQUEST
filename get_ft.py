# coding:utf-8
# -*- coding: utf-8 -*-
#!/usr/bin/env python
from sys import argv
from collections import Counter
import sys
import string
import re
import os  
def getft(org,out):
    inputfa = open(org)
    output = open(out, 'w')
    temp="0"
    ftset=[ 'A', 'AA', 'AAA', 'AAC', 'AAG', 'AAT', 'AC', 'ACA', 'ACC', 'ACG', 'ACT', 'AG', 'AGA', 'AGC', 'AGG', 'AGT', 'AT', 'ATA', 'ATC', 'ATG', 'ATT', 'C', 'CA', 'CAA', 'CAC', 'CAG', 'CAT', 'CC', 'CCA', 'CCC', 'CCG', 'CCT', 'CG', 'CGA', 'CGC', 'CGG', 'CGT', 'CT', 'CTA', 'CTC', 'CTG', 'CTT', 'G', 'GA', 'GAA', 'GAC', 'GAG', 'GAT', 'GC', 'GCA', 'GCC', 'GCG', 'GCT', 'GG', 'GGA', 'GGC', 'GGG', 'GGT', 'GT', 'GTA', 'GTC', 'GTG', 'GTT', 'T', 'TA', 'TAA', 'TAC', 'TAG', 'TAT', 'TC', 'TCA', 'TCC', 'TCG', 'TCT', 'TG', 'TGA', 'TGG', 'TGT', 'TT', 'TTA', 'TTC', 'TTG', 'TTT','TGC']
    # output.write('\t'.join(ftset)+'\t'+'len'+'\n')
    for line in inputfa:
        if not line.startswith(">"):
            line=line.replace('\n','')
            for x in ftset:
                output.write(str(line.count(x))+'\t')
            output.write(str(len(line))+'\n')
    output.flush()
    inputfa.close( )
    output.close()

# fa2fa(argv[1],argv[1]+".fa")
# getft(argv[1]+".fa",argv[2])
getft(argv[1],argv[2])
print("Get features Done!")

                                                                                                                                                                                                                                                  