shorty-os
=========

Pretty much the worst Operating System ever (worse than Windows ME)

How Do I Make It?
-----------------

It might work with other assemblers, but I used [http://flatassembler.net/download.php](Flat Assembler)

Just compile ``main.asm`` (``fasm main.asm``). You can also open it in the FASM GUI and hit compile.

How Do I Run It?
----------------

You should have a 1.44MB file called ``main.bin``. If you put that as Floppy Disk in your favourite
Virtual Hypervisor and boot it up you should be good. If you find a machine with a genuine floppy drive
you can bust out a ``dd if=main.bin of=/dev/floppy bs=1440k count=1`` and that'd be even better.

Progress
--------

Done:
- Boot
- Not crash
- Halt without doing an expensive spin-loop
- Print messages to the screen
- Detect Logical Block Addressing (LBA) status of the system

Todo:
- Something useful

Disclaimer
----------

All work was done prior to joining a large company and signing away my rights to work on other code.

Licence
-------

Not to be used for any useful purposes.

