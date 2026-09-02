MAINS       = main-original main-comments main-final
PDFS        = $(addsuffix .pdf,$(MAINS))
VERSION     = $(shell tr -d '\r\n' < VERSION)
DIST_DIR    = dist

.PHONY: all original comments final test dispatch clean distclean

all: $(PDFS)

%.pdf: %.tex revmode.sty manuscript.tex preamble.tex revmode-config.tex
	latexmk -pdf -interaction=nonstopmode $<

original: main-original.pdf
comments: main-comments.pdf
final:    main-final.pdf

test: all
	bash tests/validate.sh --no-build

dispatch: test
	bash scripts/make-dispatch.sh --no-build

clean:
	latexmk -c $(addsuffix .tex,$(MAINS))

distclean:
	latexmk -C $(addsuffix .tex,$(MAINS))
	rm -rf $(DIST_DIR)
