## Simple 32-bit x86 Kernel

This project is a minimal operating system kernel for 32-bit x86 architecture. It demonstrates:

- Custom interrupt descriptor table (IDT) setup
- Keyboard interrupt handling via IRQ1
- Basic screen output using VGA text buffer
- Support for Enter and Backspace keys
- GRUB Multiboot compliance
- Bootable ISO generation

---
##  Project Structure

```

.
├── build.sh             # Build script to compile and create ISO
├── link.ld              # Linker script (loads kernel at 0x100000)
├── kernel.c             # Kernel logic (IDT, keyboard handler, screen output)
├── start.asm            # Assembly boot code, IDT loader, port I/O
├── grub.cfg             # GRUB bootloader config
├── isodir/
│   └── boot/
│       └── grub/
│           └── grub.cfg
└── kernel.iso           # Final bootable ISO (generated)

````

---

##  Requirements

Make sure you have the following tools installed:

```bash
sudo apt install gcc nasm xorriso grub-pc-bin qemu-system-x86
sudo pacman install gcc nasm grub qemu-system-x86
````

---

## Build & Run

### Build ISO

```bash
./build.sh
```

This generates:

* `kernel.bin` – the compiled kernel
* `kernel.iso` – bootable ISO

### Run in QEMU

```bash
qemu-system-i386 -cdrom kernel.iso
```

---

## Keyboard Features

* Characters appear on screen as typed
* `Enter` key moves to the next line
* `Backspace` deletes the last character
* VGA color: light gray text on black background

---

## Bootloader

This kernel uses **GRUB Multiboot** for loading:

* `grub.cfg` sets up the GRUB menu
* `kernel.bin` is Multiboot-compliant and loaded at `0x100000`

---

