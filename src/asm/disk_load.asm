;;
;;  disk_load:Read DH sectors into ES:BX memory location from drive DL
;;

disk_load:
        push dx             ; store DX on stack so we can check number of sectors actually read later

        mov ah, 0x02        ; int 13/ah=02, BIOS read disk sectors into memory
        mov al, dh          ; number of sectors we want to read ex, 1
        mov ch, 0x00        ; cylinder 0
        mov dh, 0x00        ; head 0
        mov cl, 0x02        ; start reading at `cl` sector : sector 2 -> right after the boot sector

        int 0x13            ; BIOS interruprs for disk functions

        jc disk_error       ; Jump if discrete error carry command is set(=1)

        pop dx              ; restore dx from stack
        cmp dh, al          ; if al(# sectors actually read) != dh(# sectors we wanted to read)
        jne disk_error      ; error, sectors read not equal to number we wanted to read
        ret                 ; return to caller

disk_error:
        mov bx, DISK_ERROR_MSG
        call print_string
        hlt

DISK_ERROR_MSG:         db 'Disk read error!!!!!!!', 0
