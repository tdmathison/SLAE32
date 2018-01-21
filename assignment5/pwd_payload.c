/** msfvenom -p linux/x86/exec cmd="pwd" -e x86/shikata_ga_nai -b '\x00' -f c
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
"\xda\xc3\xba\x35\xb7\x98\xe3\xd9\x74\x24\xf4\x58\x29\xc9\xb1"
"\x0a\x83\xc0\x04\x31\x50\x16\x03\x50\x16\xe2\xc0\xdd\x93\xbb"
"\xb3\x70\xc2\x53\xee\x17\x83\x43\x98\xf8\xe0\xe3\x58\x6f\x28"
"\x96\x31\x01\xbf\xb5\x93\x35\xbb\x39\x13\xc6\xb4\x4e\x77\xc6"
"\x63\xe2\xfe\x27\x46\x84";

main()
{
    printf("Shellcode Length:  %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}

	
