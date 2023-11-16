; 16 bit real mode

; Boot sector that prints a charecter using BIOS int 0x10/ AH 0x0e

; Registers : ax, bx, cx, dx

; One word : 2 bytes

; ax:
; ah:      al:
; 00000000 11111111

; 32 bit protected mode
; eax, ebx, ecx, edx

; 64 bit long mode
; rax, rbx, rcx, rdx

        org 0x7c00              ; Indicated where Boot code starts; makes sure adresses don't change

        ; Set video mode
        mov ah, 0x00            ; Int 0x10/ ah 0x00 => set video mode
        mov al, 0x03            ; 80x25 test mode
        int 0x10

        ; Change color
        mov ah, 0x0b            ; Int 0x10/ ah 0x0b => set color/ pallet
        mov bh, 0x00
        mov bl, 0x01
        int 0x10

        ; Tele-type output
        ; mov ax, 0x0e54                ; Should directly print the charater
        ; mov ah, 0x0e            ; int 10/ ah Bios teletype output
        mov bx, teststring      ; moving memory address at teststring into bx register

        call print_string

        mov bx, string2
        call print_string

        mov dx, 0x12AB          ; sample hex number to print
        call print_hex

        ;; End pgm
        jmp $

        include 'print_string.asm'
        include 'print_hex.asm'

teststring:         db 'CHAR TEST: Testing', 0xd, 0xa, 0   ; 0/null to null terminate ; 0xd carriage return `\r` & 0xa newline `\n`
string2:            db 'Hex Test: ', 0

    ;; Boot sector magic
    times 510-($-$$) db 0   ; pads out 0 untill we reach 510th byte

    dw 0xaa55               ; boot magic number
