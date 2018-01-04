# Returns network byte order hex for an IP addresse.  This is a utility script that was used
# to help speed up conversions for shellcode.
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

# !/usr/bin/python

from optparse import OptionParser
import socket
import binascii

def convert_to_hex(data):
    val = data
    if not len(val) % 2 == 0:
        val = "0" + val
    return ''.join('\\x' + val[i:i + 2] for i in range(0, len(val), 2))


parser = OptionParser()
parser.description = "Generates network byte order hex of IP address for use in shellcode."
parser.add_option("-i", dest="ip", help="IP address", type="string")

(options, args) = parser.parse_args()
if not options.ip:
    parser.print_help()
    exit(1)

ip_bytes = binascii.hexlify(socket.inet_aton(options.ip)).decode()
reversed = ""
for (first, second) in zip(ip_bytes[0::2], ip_bytes[1::2]):
    reversed = first + second + reversed

print(convert_to_hex(reversed))
