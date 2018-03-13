
tex := $(wildcard Latex/*.tex)
pdf := $(patsubst Latex/%.tex,aux/%.pdf,$(tex))
cover := $(filter Latex/%_cover.tex,$(tex))
resume := $(patsubst Latex/%_cover.tex,pdfs/%_resume.pdf,$(cover))

.DEFAULT: all
all: $(resume) pdfs/software_resume.pdf

$(resume): pdfs/%_resume.pdf: aux/%_cover.pdf aux/software_resume.pdf | pdfs/
	pdftk $^ cat output $@

pdfs/software_resume.pdf: aux/software_resume.pdf | pdfs/
	cp $^ $@

$(pdf): aux/%.pdf: Latex/%.tex | aux/
	lualatex --output-directory aux $^

pdfs/ aux/:
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf aux pdfs
