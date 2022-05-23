#!/usr/bin/python3

# convert hex(shellcode) to binary and run it

import sys
from pwn import *

context(os="linux", arch="amd64", log_level="error")

run_shellcode(unhex(sys.argv[1])).interactive()
