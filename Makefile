CC65_DIR := cc65

CC := $(CC65_DIR)/bin/cc65
CA := $(CC65_DIR)/bin/ca65
LD := $(CC65_DIR)/bin/ld65

TARGET_PLATFORM := nes

EMULATOR ?= mednafen

SRC_DIR := src
INCLUDE_DIR := include
CFG_DIR := cfg
LIB_DIR := lib
OBJ_DIR := obj
BUILD_DIR := build

TARGET := $(BUILD_DIR)/hello.nes
ASM_FILE := $(OBJ_DIR)/main.s
OBJ_FILE := $(OBJ_DIR)/main.o

.PHONY: all cc65 build clean clean-cc65

all: build

build: cc65 $(TARGET)

run: $(TARGET)
	$(EMULATOR) $^

cc65:
	@if [ ! -d "$(CC65_DIR)/src" ]; then \
		git submodule update --init --recursive; \
	fi
	$(MAKE) -C $(CC65_DIR)

$(ASM_FILE): $(SRC_DIR)/main.c | $(OBJ_DIR)
	$(CC) -Oi $< --target $(TARGET_PLATFORM) -I$(INCLUDE_DIR) -I$(CC65_DIR)/include --add-source -o $@

$(OBJ_FILE): $(ASM_FILE)
	$(CA) -o $@ $<

$(BUILD_DIR)/hello.nes: $(OBJ_FILE) lib/crt0.o | $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)
	$(LD) -C $(CFG_DIR)/nrom_128_horz.cfg -o $@ $^ $(CC65_DIR)/lib/$(TARGET_PLATFORM).lib

lib/crt0.o: $(LIB_DIR)/crt0.s | $(LIB_DIR)
	$(CA) -o $@ $<

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(LIB_DIR):
	mkdir -p $(LIB_DIR)

clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR) lib/crt0.o

clean-cc65:
	$(MAKE) -C $(CC65_DIR) clean
