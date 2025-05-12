
bits 32
section .text
    ; Multiboot header (aligned and checksummed)
    align 4
    dd 0x1BADB002         ; Magic number
    dd 0x00               ; Flags
    dd -(0x1BADB002 + 0x00) ; Checksum

global start
global read_port
global write_port
global load_idt
global keyboard_handler
extern kmain
extern keyboard_handler_main

read_port:
    mov edx, [esp + 4]
    in al, dx
    ret

write_port:
    mov edx, [esp + 4]
    mov al, [esp + 8]
    out dx, al
    ret

load_idt:
    mov edx, [esp + 4]
    lidt [edx]
    sti
    ret

keyboard_handler:
    call keyboard_handler_main
    iret

start:
    cli
    mov esp, stack_space + 8192
    call kmain
.hang:
    hlt
    jmp .hang

section .bss
    align 16
    resb 8192
stack_space:

