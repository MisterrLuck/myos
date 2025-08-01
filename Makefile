SRCDIR := src
TMPDIR := tmp
BINDIR := bin
ISODIR := iso

OSNAME := myos

COMPILER := cross/bin/i686-elf

grub-bootloader: linker
	@grub-mkrescue -o $(BINDIR)/$(OSNAME).iso $(ISODIR)

linker: kernel boot
	@$(COMPILER)-gcc -T $(SRCDIR)/linker.ld -o $(BINDIR)/$(OSNAME).bin -ffreestanding -O2 -nostdlib $(TMPDIR)/boot.o $(TMPDIR)/kernel.o -lgcc
	@cp $(BINDIR)/$(OSNAME).bin $(ISODIR)/boot/$(OSNAME).bin
	@grub-file --is-x86-multiboot $(BINDIR)/$(OSNAME).bin

boot:
	@$(COMPILER)-as $(SRCDIR)/boot.s -o $(TMPDIR)/boot.o

kernel:
	@$(COMPILER)-gcc -c $(SRCDIR)/kernel.c -o $(TMPDIR)/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
# if you want C++ instead; uncomment this
# i686-elf-g++ -c kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti


.PHONY: clean q qw fullclean

qw:
	qemu-system-i386 -kernel $(ISODIR)/boot/$(OSNAME).bin

q:
	qemu-system-i386 -cdrom $(BINDIR)/$(OSNAME).iso

clean:
	rm -rf $(TMPDIR)/*

fullclean:
	rm -rf $(TMPDIR)/*
	rm -rf $(BINDIR)/*