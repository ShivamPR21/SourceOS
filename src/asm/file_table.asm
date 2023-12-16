;;
;;  file_table.asm: basic 'file table' made with db, strings consists of '{fileName1-sector#, fileName2-sector#, ..., fileNameN-sector#}'
;;

db '{calculator-04, program2-06}'

        ;; sector padding magic
        times 512-($-$$) db 0       ; Pad rest of the file with 0s till 512 byte/end of sector
