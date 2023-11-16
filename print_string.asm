;;
;; Prints character string in si register
;;

print_string:
        pusha                   ; store all register values on the stack
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
        popa                    ; restore registers from stack before returning
        ret
