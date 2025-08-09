CC = arm-linux-gnueabi-gcc
AS = arm-linux-gnueabi-as
LD = arm-linux-gnueabi-gcc   
QEMU = qemu-arm
CFLAGS = -Wall -O2 -static -march=armv7-a
ASFLAGS = -march=armv7-a
SRC_C = main.c
SRC_ASM = calc.s
OBJ_C = main.o
OBJ_ASM = calc.o
OUT = calc

.PHONY: all run clean

all: $(OUT)

$(OBJ_C): $(SRC_C)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_ASM): $(SRC_ASM)
	$(AS) $(ASFLAGS) -o $@ $<

$(OUT): $(OBJ_C) $(OBJ_ASM)
	$(LD) $(CFLAGS) -o $@ $^

run: $(OUT)
	@echo "Running in QEMU..."
	$(QEMU) ./$(OUT)

clean:
	rm -f $(OBJ_C) $(OBJ_ASM) $(OUT)
