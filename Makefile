PROJNAME=main

.PHONY: all clean

all: $(PROJNAME).pdf

$(PROJNAME).pdf: $(PROJNAME).tex
	latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" -use-make $<

clean:
	-@$(RM) \
		$(wildcard main-gnuplottex*) \
		$(addprefix main,.gnuploterrors .aux .bbl .bcf .blg .lof .log .lol .lot .out .run.xml .toc .acn .glo .ist .acr .tdo .alg .glg .gls .fdb_latexmk .fls)

cleanall: clean
	-@$(RM) \
		$(wildcard *.dvi *.ps *.pdf)
