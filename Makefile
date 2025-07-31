SRCDIRS := src
TMPDIRS := tmp
BINDIRS := bin

COMPILER := cross/bin/i686-elf

myos.iso: myos.bin
	grub-mkrescue -o $(BINDIRS)/myos.iso isodir -d /usr/lib/grub/i386-pc

myos.bin: kernel.o boot.o
	$(COMPILER)-gcc -T $(SRCDIRS)/linker.ld -o $(BINDIRS)/myos.bin -ffreestanding -O2 -nostdlib $(TMPDIRS)/boot.o $(TMPDIRS)/kernel.o -lgcc

boot.o:
	$(COMPILER)-as $(SRCDIRS)/boot.s -o $(TMPDIRS)/boot.o

kernel.o:
	$(COMPILER)-gcc -c $(SRCDIRS)/kernel.c -o $(TMPDIRS)/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra


.PHONY: clean q qw

qw:
	qemu-system-i386 -kernel $(BINDIRS)/myos.bin

q:
	qemu-system-i386 -cdrom $(BINDIRS)/myos.iso

clean:
	rm -rf $(TMPDIRS)/*