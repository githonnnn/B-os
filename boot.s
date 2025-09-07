section .multiboot
align 4
    dd 0x1BADB002 ; magic number
    dd 0          ; flags
    dd -(0xBADB002+) ;checksum
section .text
global_start
_start:
    call kernel_main
.halt:
    jmp .halt