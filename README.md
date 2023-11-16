# SourceOS

## 16 bit real mode

### Load kernel in QEMU

```shell
fasm bootSect.asm
fasm kernel.asm
cat bootSect.bin kernel.bin > OS.bin
qemu-system-x86_64 -drive format=raw,if=floppy,file=OS.bin
```
