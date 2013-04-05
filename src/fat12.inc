
;jmp short start
jmp start
nop

; FAT boot sector
; http://en.wikipedia.org/wiki/FAT12#Boot_Sector
oemname 	   db 'SHORTY  '	; OEM Name (padded with spaces 0x20). This value determines in which system disk was formatted
bytespersector	   dw 512		; Bytes per sector. A common value is 512, especially for file systems on IDE (or compatible) disks. The BIOS Parameter Block starts here
sectorspercluster  db 1 		; Sectors per cluster. Allowed values are powers of two from 1 to 128. However, the value must not be such that the number of bytes per cluster becomes greater than 32 KB.
reservedsectors    dw 1 		; Reserved sector count. The number of sectors before the first FAT in the file system image. Should be 1 for FAT12/FAT16. Usually 32 for FAT32
numberoffats	   db 2 		; Number of file allocation tables. Almost always 2
maxrootdirentries  dw 224		; Maximum number of root directory entries. Only used on FAT12 and FAT16, where the root directory is handled specially. Should be 0 for FAT32. This value should always be such that the root directory ends on a sector boundary (i.e. such that its size becomes a multiple of the sector size). 224 is typical for floppy disks.
totalsectors	   dw 2880		; Total sectors (if zero, use 4 byte value at offset 0x20) (2880 x 512 = 1440kb floppy)
mediadescriptor    db 0xf0		; Media descriptor (3.5" double sided, 80 tracks per side, 18 or 36 sectors per track (18 = 1.44MB, 36 = 2.88MB)
sectorsperfat	   dw 9 		; 9 x 512 = 4.5kb fat
sectorspertrack    dw 18		; Sectors per track (Only useful on disks with geometry) 18 = 1.44MB
numberofheads	   dw 2 		; Number of heads (Only useful on disks with geometry)
hiddensectors	   dd 0 		; Count of hidden sectors preceding the partition that contains this FAT volume. This field should always be zero on media that are not partitioned
moarsectors	   dd 0 		; Total sectors (if greater than 65535; otherwise, see offset 0x13)

; Extended BIOS Parameter Block
; http://en.wikipedia.org/wiki/FAT12#Extended_BIOS_Parameter_Block
physdrivenum	   db 0x00		; Physical drive number (0x00 for removable media, 0x80 for hard disks)
reserved	   db 0x00		; Reserved ("current head"). In Windows NT bit 0 is a dirty flag to request chkdsk at boot time. bit 1 requests surface scan too
extendedbootsig    db 0x29		; Extended boot signature. (Should be 0x29. Indicates that the following 3 entries exist.)
serialnum	   dd 0xdeadbeef	; ID (serial number)
volumelabel	   db 'shorty     '	; 11 char Volume Label, padded with blanks (0x20).
fattype 	   db 'FAT12   '	; 8 char FAT file system type, padded with blanks (0x20), e.g.: "FAT12   ", "FAT16   ". This is not meant to be used to determine drive type, however, some utilities use it in this way.
