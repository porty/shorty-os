
;
; Shorty boot file
;

; BIOS always loads this in to 0x7C00
org 0x7C00

include "fat12.inc"
include "routines_16.inc"

start:

	; set up the registers
	xor ax,ax
	mov ss,ax
	mov sp,ax;boot_program
	;push ss
	;pop ds
	mov ds,ax

	; let the user know that something is happening
	mov  si,msg_intro
	call PrintString16
       ; jmp Halt

;; test to see if we can use LBA
;        mov ah,41h
;        mov al,0
;        int 13h
;        xor cx,cx
;        mov cl,ah
;        cmp cl,0
;        mov bh,0x00
;        mov bl,0x07
;        jz echoer
;@@:
;
;        mov ah,0x0E
;        mov al,'.'
;        int 0x10
;        loop @b
;         jmp echoer
;        mov ah,0x0E
;        mov al,'|'
;        int 0x10
;       ; mov ah,0x0E
;       ; mov al,10
;       ; int 0x10
;
;        mov ah,41h
;        mov al,0
;        int 13h
;
;        xor cx,cx
;        mov cl,al
;        cmp cl,0
;        jz echoer

	call test_lba_enabled
	cmp  ax,0
	jne  @f
	mov  si,msg_lba_not_supported
	jmp  show_lba_supportness
@@:
	mov  si,msg_lba_supported
show_lba_supportness:
	call PrintString16

echoer:
	mov	bh,0x00       ; ?
	mov	bl,0x07       ; colour 00000111b

@@:
	xor	ax,ax	      ; wait for keystroke and read (INT 16,0)
	int	0x16	      ; Keyboard BIOS services - http://stanislavs.org/helppc/int_16.html
	mov	ah,0x0E       ; print char to screen (INT 10,0E)
	int	0x10	      ; BIOS video services - http://en.wikipedia.org/wiki/INT_10
	jmp	@b

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
	mov dl,0x80 ; hard disk
	mov bx,0x55aa ; ?
	int 0x13

	; if carry flag is not set, it's not supported
	jc  test_lba_not_supported

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


;msg_boot_loader_start   db 'Shorty boot loader',13,10,'Currently running in 16-bit',13,10,0
;msg_loading_modules     db 'Loading modules...',13,10,0


msg_intro		db 'Shorty Boot Loader started!!',13,10,0
msg_enabling_a20	db 'Enabling A20 line...',13,10,0
msg_loading_kernel	db 'Loading kernel in to memory...',13,10,0
msg_entering_pmode	db 'Entering protected mode...',13,10,0
msg_setup_gdt		db 'Setting up memory protection...',13,10,0
msg_setup_idt		db 'Setting up interrupt table...',13,10,0
msg_setup_stack 	db 'Setting up 32-bit stack...',13,10,0

msg_lba_not_supported	db 'LBA not supported :(',13,10,0
msg_lba_supported	db 'LBA supported :)',13,10,0

;include "a20.inc"

include "end.inc"

TIMES 1474560-($-$$) DB 0
