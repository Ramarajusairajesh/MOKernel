#!/bin/bash
set -e

# Paths
OUT_DIR=..
ISO_DIR="$OUT_DIR/isodir"
BOOT_DIR="$ISO_DIR/boot"
GRUB_DIR="$BOOT_DIR/grub"

# Clean old files
rm -f $OUT_DIR/kernel.bin $OUT_DIR/kernel.iso
mkdir -p $GRUB_DIR

# Compile kernel
nasm -f elf32 start.asm -o start.o
gcc -m32 -ffreestanding -fno-stack-protector -c kernel.c -o kernel.o
ld -m elf_i386 -T link.ld -o $OUT_DIR/kernel.bin start.o kernel.o

# Copy to ISO structure
cp $OUT_DIR/kernel.bin $BOOT_DIR/kernel.bin

# Create ISO
grub-mkrescue -o $OUT_DIR/kernel.iso $ISO_DIR

echo "✅ ISO created: $OUT_DIR/kernel.iso"
