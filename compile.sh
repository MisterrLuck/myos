export PATH="$HOME/cross/bin:$PATH"

cd $HOME/src

i686-elf-as boot.s -o boot.o
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

# if you want C++ instead; uncomment this
# i686-elf-g++ -c kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

i686-elf-gcc -T linker.ld -o $HOME/myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

cd $HOME
cp myos.bin isodir/boot/myos.bin
grub2-mkrescue -o myos.iso isodir -d /usr/lib/grub/i386-pc

if grub-file --is-x86-multiboot myos.bin; then
  echo multiboot confirmed
else
  echo the file is not multiboot
fi

# cp myos.bin $HOME/../../mnt/c/Users/joshu/OneDrive/Documents/wsl/myos.bin
# cp myos.iso $HOME/../../mnt/c/Users/joshu/OneDrive/Documents/wsl/myos.iso

