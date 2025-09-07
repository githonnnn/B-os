TARGET=Bos
ISO=$(TARGET).iso 
CC=gcc
LD=ld 
AS=nasm
CFLAGS=-m32 -ffreestanding -02 -Wall -Wextra
LDFLAGS=-T linker.ld -m elf_i386
SRC=src/boot.s src/kernel.c 
OBJ=build/boot.o build/kernel.o 
all: $(ISO)
build/boot.o: src/boot.s
	mkdir -p build
	$(AS) -f elf32 $< -o $@
build/kernel.o: src/kernel.c 
	mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@
kernel.bin: $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $(OBJ)
$(ISO): kernel.bin
	mkdir -p isodir/boot/grub
	cp kernel.bin isodir/boot/
	echo 'set timeout=0' > iso/boot/grub/grub.cfg 
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo 'menuentry "Bos"{'>> iso/boot/grub/grub.cfg
	echo 'multiboot /boot/kernel.bin'>> iso/boot/grub/grub.cfg
	echo ' boot'>> iso/boot/grub/grub.cfg
	echo '}'>> iso/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) isodir
run:$(ISO)
	qemu-system-i386 -cdrom $(ISO)
clean:
	rm -rf build isodir $(ISO) kernel.bin $(ISO) iso
	