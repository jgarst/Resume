
resume := $(wildcard Latex/*.tex)
covers := $(wildcard Latex/covers/*.tex)
company := $(patsubst Latex/covers/%.tex,%,$(covers))
pdf := $(patsubst %,pdfs/%.pdf,$(company))

.DEFAULT: all
all: $(pdf) pdfs/software.pdf

$(company): %: pdfs/%.pdf

$(pdf): pdfs/%.pdf: pdfs/covers/%.pdf pdfs/software.pdf | pdfs/
	pdftk $^ cat output $@

pdfs/software.pdf: Latex/software.tex | latex.out/ pdfs/
	latexrun --latex-cmd lualatex -o pdfs/software.pdf $^

pdfs/covers/%.pdf: Latex/covers/%.tex | latex.out/ pdfs/covers/
	latexrun --latex-cmd lualatex -o $@ $^

pdfs/ pdfs/covers/ latex.out/:
	mkdir -p $@

.PHONY: clean watch
clean:
	latexrun --clean-all

watch:
	while true; do \
		make $(WATCHMAKE); \
		inotifywait -qre close_write .; \
	done
