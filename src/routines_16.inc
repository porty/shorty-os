;
; Routines (16-bit)
;

;
; Print a NULL-terminated string stored in SI
;

PrintString16:
	push	ax
	push	bx
	mov	ah,0x0E
	mov	bh,0x00
	mov	bl,0x07
@@:
	lodsb		      ; load what is pointed to by SI in to AL and increment SI
	or al,al
	jz @f
	int	0x10
	jmp @b
@@:
	pop bx
	pop ax
	ret

;
; Spinloop that doesn't return
;

Halt:
@@:
	nop
	nop
	nop
	nop
	jmp @b

;
; Print the byte specified in AL as binary
;
PrintByteBinary16:
	push ax
	push bx

	mov	bl,al
	neg	bl
	or	bl,11111110b
	neg	bl
	test	bl,bl
	jz	@f
@@:
;
	pop bx
	pop ax
	ret

PrintZeroOrOne:
	push bp
	mov bp,sp

	pop bp
