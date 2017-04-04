#
# file - Makefile
# author - Harlan J. Waldrop <waldroha@oregonstate.edu>
#

default: debug

MAKEFLAGS += --no-builtin-rules

PROJECT = boilerplate

#
# Code Section
#
CC = avr-gcc
CP = avr-objcopy
DUMP = avr-objdump

ISP = avrdude
ISP_TOOL = usbasp
ISP_TARGET = m128

TARGET = atmega128
TARGET_ARCH = avr:51

OPTIMIZE   = -Os
CDEFS_LIST = DEBUG VERBOSE
CDEFS      = $(addprefix -D, $(CDEFS_LIST))

override CFLAGS  += -g -Wall -Werror $(OPTIMIZE) $(CDEFS) -nostdlib -mmcu=$(TARGET)
override LDFLAGS += -lm -Wl,-Map,$(PROJECT).map

SRC  = $(shell find . -name "*.S")
SRC += $(shell find . -name "*.c")
OBJ  = $(addsuffix .o, $(SRC))

ELF = $(PROJECT).elf
HEX = $(PROJECT).hex

#
# Misc. Files
#
TEX = $(shell find . -name '*.tex')
PDF = $(TEX:.tex=.pdf)

LATEX_DIR = ./.latex
LATEX_FLAGS = -output-directory $(LATEX_DIR) -halt-on-error

#
# Targets
#
flash: $(HEX)
	sudo $(ISP) -p $(ISP_TARGET) -c $(ISP_TOOL) -P usb -B 16 -U flash:w:$(HEX)

debug: clean flash

dump: $(HEX)
	@$(DUMP) -m $(TARGET_ARCH) -D $^ > $^.dump
	@echo "Dumping $^ ($(TARGET)/$(TARGET_ARCH))..."

$(HEX): $(ELF)
	$(CP) -j .text -j .data -O ihex $^ $@ 

$(ELF): $(OBJ)
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

%.o: %
	$(CC) $(CFLAGS) -c -o $@ $^

#
# Misc. Targets
#
pdf: $(LATEX_DIR) $(PDF)

$(LATEX_DIR):
	mkdir $@

%.pdf: %.tex
	pdflatex $(LATEX_FLAGS) $^
	mv $(LATEX_DIR)/$@ .

clean:
	rm -f *.elf *.hex *.o *.zip

deep-clean: clean
	rm -f *.dump *.map

zip:
	zip $(PROJECT).zip *.c *.def *.h *.inc *.S *.tex Makefile

.PHONY: all clean debug dump flash pdf zip
