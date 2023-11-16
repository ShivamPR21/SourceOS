;;
;; kernel.asm : Basic 'kernel' loaded from our bootsector
;;
        ; Set video mode
        mov ah, 0x00            ; Int 0x10/ ah 0x00 => set video mode
        mov al, 0x03            ; 80x25 test mode
        int 0x10

        ; Change color
        mov ah, 0x0b            ; Int 0x10/ ah 0x0b => set color/ pallet
        mov bh, 0x00
        mov bl, 0x01
        int 0x10

        mov si, teststring      ; moving memory address at teststring into si register
        call print_string

        ;; End pgm
        hlt                     ; halt the cpu

print_string:
        mov ah, 0x0e            ; int 10/ ah Bios teletype output
        mov bh, 0x0             ; page number
        mov bl, 0x07            ; color

print_char:
        mov al, [si]            ; move charecter value at address in si into al
        cmp al, 0
        je end_print              ; jump if equal (al == 0) to halt label
        int 0x10                ; Call for BIOS video interrupt
        add si, 1               ; Move address to next charecter
        jmp print_char        ; Jump back to the loop, and continue

end_print:
        ret

teststring:         db 'Kernel booted, Welcome to SourceOS!', 0xd, 0xa, 0   ; 0/null to null terminate ; 0xd carriage return `\r` & 0xa newline `\n`

       ;; Sector padding magic
        times 512-($-$$) db 0   ; pads out 0 untill we reach 512th byte
