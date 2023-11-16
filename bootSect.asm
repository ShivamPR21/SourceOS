; Basic boot srctor that jumps continuously in a loop

here:

    jmp here                ; Jump repeatedly to label loop

    times 510-($-$$) db 0   ; pads out 0 untill we reach 510th byte

    dw 0xaa55               ; boot magic number
