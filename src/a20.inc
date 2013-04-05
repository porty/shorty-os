; not sure what to do here yet...

	cli				;{0}
	lgdt	[cs:gdt]		;Load GDT
	mov	ecx, CR0		;Switch to protected mode
	inc	cx
	mov	CR0, ecx		;{5}
@@:	in	al, 0x64		;Enable A20 {4A}
	test	al, 2
	jnz	@b
