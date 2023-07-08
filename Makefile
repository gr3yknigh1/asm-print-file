.PHONY: all run clean

RM  := rm -rf

SRC := main.asm
OBJ := main.o
OUT := main

LD        := ld
LD_FLAGS  :=
ASM       := nasm
ASM_FLAGS := -felf64

all: $(OUT)

$(OUT): $(OBJ)
	$(LD) $(LD_FLAGS) $^ -o $@

$(OBJ): $(SRC)
	$(ASM) $(ASM_FLAGS) $^ -o $@

run: $(OUT)
	./$(OUT)

clean:
	$(RM) $(OUT)
	$(RM) $(OBJ)
