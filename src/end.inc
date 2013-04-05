

; There are two things required to get a basic bootsector running: keep the bootsector at
; exactly 512bytes in size and the last two bytes of the code must be 0x55AA.


TIMES 510-($-$$) db 0
SIGNATURE dw 0xAA55
