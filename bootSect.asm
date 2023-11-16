;;
;; Simple Boot Loader that uses INT13 to read disk into memory
;;
        org 0x7c00              ; Indicated where Boot code starts; makes sure adresses don't change

        ;; set up dx register for disk loading
        mov dh, 1               ; # sectors we want to load into memory
        mov dl, 0               ; drive number to load (0=boot disk)

        ;; set up ES:BX memory address/segment:offset to load sector(s) into
        mov bx, 0x1000          ; load sector to memory address 0x1000
        mov es, bx              ; ES = 0x1000
        mov bx, 0               ; ES:BX = 0x1000:0

        call disk_load          ; loads our kernel into memory

        ;; reset segment registers for RAM
        mov ax,0x1000
        mov ds, ax                ; data segment
        mov es, ax                ; extra segment
        mov fs, ax                ; ""
        mov gs, ax                ; ""
        mov ss, ax                ; stack segment

        ; jmp es:bx               ; jump to wherever it's loaded
        jmp 0x1000:0x0            ; jump to wherever it's loaded

        ;; include files
        include 'disk_load.asm'
        include 'print_string.asm'

        ;; Boot sector magic
        times 510-($-$$) db 0   ; pads out 0 untill we reach 510th byte

        dw 0xaa55               ; boot magic number
