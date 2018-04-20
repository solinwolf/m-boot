
CROSS_COMPLE=arm-none-linux-gnueabi-

all: start.o 
	arm-none-linux-gnueabi-ld -Tu-boot.lds -o u-boot.elf $^
	arm-none-linux-gnueabi-objcopy -O binary u-boot.elf u-boot.bin
%.o : %.S
	arm-none-linux-gnueabi-gcc -g -c $^
	
%.o : %.c
	arm-none-linux-gnueabi-gcc -g -c $^
	
.PHONY: clean
clean:
	rm *.o *.elf *.bin
