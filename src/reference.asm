
; echo what is typed on the keyboard
echoer:
	mov	bh,0x00       ; ?
	mov	bl,0x07       ; colour 00000111b
;        mov     bl,00001010b       ; light green (in colour mode only!)

@@:
	xor	ax,ax	      ; wait for keystroke and read (INT 16,0)
	int	0x16	      ; Keyboard BIOS services - http://stanislavs.org/helppc/int_16.html
	mov	ah,0x0E       ; print char to screen (INT 10,0E)
	int	0x10	      ; BIOS video services - http://en.wikipedia.org/wiki/INT_10
	jmp	@b





; change screen res to 640x480x16
changeres:
	push ax

	mov ah,0	      ; INT 10,0 : set video mode (clear screen, add 80h to mode to prevent screen clr) - http://www.uv.tietgen.dk/staff/mlha/PC/Prog/asm/int/INT10.htm
	mov al,0x12	      ; VGA 640*480 16 color
	int 0x10	      ; BIOS video services - http://en.wikipedia.org/wiki/INT_10

	pop ax
	ret


; test to see if we can use LBA

lba_enabled:
	mov ah,41h
	mov al,0
	int 13h
	cmp ah,1
	je @enabled
	xor ax,ax
	jmp @end
@enabled:
	mov ax,1
@end:
	ret


;
; Better (proper)? LBA testing
;
test_lba_enabled:
	; save registers
	push bx
	push cx
	push dx

	; zero registers
	xor ax,ax
	; xor bx,bx
	xor cx,cx

	; call int13h
	mov ah,0x41 ; extensions check
	mov dl,0x00 ; floppy disk
	mov bx,0x55aa ; ?
	int 0x13

	; if carry flag is not set, it's not supported
	jnc test_lba_not_supported

	; if BX isn't certain value, it's not supported
	cmp bx,0xaa55 ; says it's now supposed to say this
	jne test_lba_not_supported

	; must be supported
	mov ax,cx ; return device support flags
	jmp test_lba_end


test_lba_not_supported:
	; return 0 / false
	xor eax,eax
test_lba_end:
	; restore registers
	pop dx
	pop cx
	pop bx
	ret
