#!/usr/bin/env python3
import re


#######################################
f = open("./tests/test1.txt","r")
#######################################

ul2_mr = float(re.findall(r"\d.\d\d\d\d",f.readline())[0])
il1_mr = float(re.findall(r"\d.\d\d\d\d",f.readline())[0])
dl1_mr = float(re.findall(r"\d.\d\d\d\d",f.readline())[0])
total_inst = int(re.findall(r"\d{9}",f.readline())[0])
total_ref = int(re.findall(r"\d{9}",f.readline())[0])

f.close()

lsp = total_ref/total_inst

l1_mp = 10
l2_mp = 100
base_cpi = 1

il1_cpi = il1_mr * l1_mp
dl1_cpi = dl1_mr * l1_mp * lsp
ul2_cpi = (il1_mr + dl1_mr * lsp) * ul2_mr * l2_mp

total = base_cpi + il1_cpi + dl1_cpi + ul2_cpi

print(total)
