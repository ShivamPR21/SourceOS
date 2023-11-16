;;
;; Prints character string in bx register
;;

print_string:
        pusha                   ; store all register values on the stack

print_char:
        mov al, [bx]            ; move charecter value at address in bx into al
        cmp al, 0
        je end_print              ; jump if equal (al == 0) to halt label
        int 0x10                ; Call for BIOS video interrupt
        add bx, 1               ; Move address to next charecter
        jmp print_char        ; Jump back to the loop, and continue

end_print:
        popa                    ; restore registers from stack before returning
        ret
