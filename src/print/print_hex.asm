;;
;;  Prints hexadecimal values using register `dx` and print_string.asm
;;
;;  ASCII '0'-'9' = 0x30 - 0x39
;;  ASCII 'A'-'F' = 0x41 - 0x46
;;  ASCII 'a'-'f' = ox61 - 0x66

print_hex:
        pusha                   ; save all registers to stack
        mov cx, 0               ; Initialize loop counter

hex_loop:
        cmp cx, 4               ; check for end of loop, in 16bit real mode, each hex digit is 4 bit, and 2 of them makes a byte
        je end_hexloop

        ;; convert dx hex values to ascii
        mov ax, dx
        ; shr ax, 4               ; 0000000011111111 -> 0000000000001111
        ; turn first 3 digit to zero and keep final digit to convert
        and ax, 0x000F            ; 0001 0010 1010 1011 & 0000 0000 0000 1111 -> 0000 0000 0000 1011
        add al, 0x30              ; get ascii number letter value
        cmp al, 0x39              ; is hex value 0-9 (<= 0x39) or A-F (> 0x39)
        jle move_intoBx
        add al, 0x7               ; to get ascii 'A'-'F'

        ;; Move ascii char into bx string

move_intoBx:
        mov bx, hexString + 5     ; base address of hexstring + length of string -> last character
        sub bx, cx                ; move to the target character in the string
        mov [bx], al              ; dereference the target address and move the desired value in it
        ror dx, 4                 ; rotate right by 4 bits(1 hex digit) 0x12AB -> 0xB12A -> 0xAB12 -> ...
                                  ; additional carry flag is stored `find about it`

        add cx, 1                 ; increase the counter
        jmp hex_loop              ; loop for next digit in `dx`

end_hexloop:
        mov bx, hexString       ; set final target string and call `print_string`
        call print_string       ; calling print string to print from bx

        popa                    ; restore all registers from the stack
        ret                     ; return to caller

        ;; Data
hexString:      db '0x0000', 0
