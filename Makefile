
resume := $(wildcard Latex/*.tex)
covers := $(wildcard Latex/covers/*.tex)
company := $(patsubst Latex/covers/%.tex,%,$(covers))
pdf := $(patsubst %,pdfs/%.pdf,$(company))

.DEFAULT: all
all: $(pdf) pdfs/software.pdf

$(company): %: pdfs/%.pdf

$(pdf): pdfs/%.pdf: aux/%.pdf aux/software.pdf | pdfs/
	pdftk $^ cat output $@

pdfs/software.pdf: aux/software.pdf | pdfs/
	cp $^ $@

aux/software.pdf: Latex/software.tex | aux/
	lualatex --output-directory aux $^

aux/%.pdf: Latex/covers/%.tex | aux/
	lualatex --output-directory aux $^

pdfs/ aux/:
	mkdir -p $@

.PHONY: clean watch
clean:
	rm -rf aux pdfs

watch:
	while true; do \
		make $(WATCHMAKE); \
		inotifywait -qre close_write .; \
	done
