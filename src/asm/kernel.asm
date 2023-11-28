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

        ;; Print screen heading and menue options
        mov si, menuestring      ; moving memory address at teststring into si register
        call print_string

        ;; Get user input print to screen and choose a menue option or run command
        push di                 ; Store di location to stack, to get user input command

get_input:
        mov di, cmdString       ; move location of command string to di

keyloop:
        mov ax, 0x00            ; ah = 0x00 and al = 0x00
        int 0x16                  ; BIOS int get keystroke ah=00, character goes into al

        mov ah, 0x0e
        mov bh, 0x00
        cmp al, 0xD             ; Did user presss 'Enter' key
        je run_cmd
        int 0x10                ; Print input character to screen
        mov [di], al            ; move command into [di]
        add di, 1               ; move to next byte
        jmp keyloop             ; Loop through keyloop

run_cmd:
        ; pop di                  ; restore di from stack
        mov byte [di], 0        ; null terminate cndString from di
        mov al, [cmdString]
        cmp al, 'F'           ; file table command/menue option
        jne not_found
        cmp al, 'N'             ; end current program
        je end_command
        mov si, success         ; command found!
        call print_string
        jmp get_input

not_found:
        mov si, failure
        call print_string
        jmp get_input

end_command:
        ;; End pgm
        cli                     ; clear int
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

menuestring:         db 'Kernel booted, Welcome to SourceOS!'   ; 0/null to null terminate ; 0xd carriage return `\r` & 0xa newline `\n`
                        ; times 80 - ($ - $$) db '-'
                        db 0xa, 0xd, 0xa, 0xd
                        db 'F> File & Program Broswer/Loader', 0xa, 0xd, 0

success:        db 'Command ran successfully!', 0
failure:        db 'Ooops! Something went wrong :(', 0
cmdString:      db ''

       ;; Sector padding magic
        times 512-($-$$) db 0   ; pads out 0 untill we reach 512th byte
