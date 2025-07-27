CC65_DIR := ../cc65

CC := $(CC65_DIR)/bin/cc65
CA := $(CC65_DIR)/bin/ca65
LD := $(CC65_DIR)/bin/ld65

TARGET_PLATFORM := nes

EMULATOR ?= mednafen

INCLUDE_DIR := ../include
CFG_DIR := ../cfg
LIB_DIR := ../lib
OBJ_DIR := obj
BUILD_DIR := build

CRT0_OBJ := $(LIB_DIR)/crt0.o

EXAMPLES := example1 example2 example3 example4 example5 \
            example6 example7 example8 example9 example10 example11

TARGETS := $(addprefix $(BUILD_DIR)/, $(addsuffix .nes, $(EXAMPLES)))
S_FILES := $(addprefix $(OBJ_DIR)/, $(addsuffix .s, $(EXAMPLES)))
O_FILES := $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(EXAMPLES)))

.SECONDARY: $(O_FILES) $(S_FILES)

.PHONY: all cc65 build clean clean-cc65 run

all: build

build: cc65 $(CRT0_OBJ) $(TARGETS)

run: $(TARGETS)
	@for rom in $^; do \
		$(EMULATOR) "$$rom"; \
	done

$(OBJ_DIR)/%.s: %.c
	@mkdir -p $(OBJ_DIR)
	$(CC) -Oi $< --target $(TARGET_PLATFORM) -I$(INCLUDE_DIR) -I$(CC65_DIR)/include --add-source -o $@

$(OBJ_DIR)/%.o: $(OBJ_DIR)/%.s
	$(CA) -o $@ $<

$(BUILD_DIR)/%.nes: $(OBJ_DIR)/%.o $(CRT0_OBJ)
	@mkdir -p $(BUILD_DIR)
	$(LD) -C $(CFG_DIR)/nrom_128_horz.cfg -o $@ $^ $(CC65_DIR)/lib/$(TARGET_PLATFORM).lib

$(CRT0_OBJ): $(LIB_DIR)/crt0.s
	$(CA) -o $@ $<

cc65:
	@if [ ! -d "$(CC65_DIR)/src" ]; then \
		git submodule update --init --recursive; \
	fi
	$(MAKE) -C $(CC65_DIR)

clean:
	rm -rf $(BUILD_DIR) $(OBJ_DIR) $(CRT0_OBJ)

clean-cc65:
	$(MAKE) -C $(CC65_DIR) clean
