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

    ; mov ax, 0x0e54                ; Should directly print the charater
    mov ah, 0x0e            ; int 10/ ah Bios teletype output
    mov bx, teststring      ; moving memory address at teststring into bx register
    mov al, [bx]            ; Charater we want to print
    int 0x10                ; BIOS video interrupt
    mov al, [bx+1]          ; Add 1 byte offset to bx address, mov into al; 'E'
    int 0x10                ; BIOS video interrupt
    add bx, 2               ; Adds 2 byte offset to value in bx, 'S'
    mov al, [bx]            ; mov address of bx to al
    int 0x10                ; BIOS video interrupt
    mov al, [bx+1]          ; Add 1 byte offset to bx address, mov into al; 'S'
    int 0x10                ; BIOS video interrupt

    ; mov al, 'E'
    ; int 0x10

    ; mov al, 'S'
    ; int 0x10

    ; mov al, 'T'
    ; int 0x10


teststring:         db 'TEST', 0   ; 0/null to null terminate

; here:

    jmp $                   ; Jump repeatedly to label loop : Similar command `jmp $`

    times 510-($-$$) db 0   ; pads out 0 untill we reach 510th byte

    dw 0xaa55               ; boot magic number
