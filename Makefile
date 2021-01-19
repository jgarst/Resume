
resume := $(wildcard Latex/*.tex)
covers := $(wildcard Latex/covers/*.tex)
company := $(patsubst Latex/covers/%.tex,%,$(covers))
pdf := $(patsubst %,pdfs/%.pdf,$(company))
viewer := mupdf

.DEFAULT: base

base: pdfs/software.pdf

all: $(pdf) pdfs/software.pdf

$(company): %: pdfs/%.pdf

$(pdf): pdfs/%.pdf: pdfs/covers/%.pdf pdfs/software.pdf pdfs/hardware.pdf | pdfs/
	pdfjam --outfile $@ $^

pdfs/%.pdf: Latex/%.tex | latex.out/ pdfs/covers/
	env TEXINPUTS=".:./lib//:" \
		latexrun --latex-cmd lualatex -o $@ $^

pdfs/ pdfs/covers/ latex.out/:
	mkdir -p $@

.PHONY: clean watch
clean:
	latexrun --clean-all

watch:
	while true; do \
		make $(WATCHMAKE); \
		pkill -HUP $(viewer) ; \
		inotifywait -qre close_write .; \
	done
