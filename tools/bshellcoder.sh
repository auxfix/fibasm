#!/bin/bash

# load a .text part of binary - shellcode

for i in $(objdump -d $1 |grep "^ " |cut -f2); do echo -n $i; done; echo;
