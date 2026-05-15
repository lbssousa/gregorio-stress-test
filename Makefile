MAIN_TEX := main.tex
GABC_FILES := $(shell find chapters -type f -name '*.gabc')
GTEX_FILES := $(patsubst %.gabc,%.gtex,$(GABC_FILES))

.PHONY: all phase1 phase2 build clean

all: build

phase1: $(GTEX_FILES)

%.gtex: %.gabc
	gregorio -o "$@" "$<"

phase2: phase1
	latexmk -lualatex -interaction=nonstopmode -halt-on-error $(MAIN_TEX)

build: phase2

clean:
	latexmk -C
	find chapters -type f -name '*.gtex' -delete
