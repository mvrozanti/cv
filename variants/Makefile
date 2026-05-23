SHELL := /usr/bin/env bash
ROOT  := $(abspath .)
SHARED:= $(ROOT)/shared
BUILD := $(ROOT)/build

VARIANTS := $(sort $(notdir $(patsubst %/,%,$(dir $(wildcard v*/main.tex)))))

LATEXMK_FLAGS := -interaction=nonstopmode -halt-on-error -file-line-error -shell-escape

# default engine: xelatex (altacv + Lato), per-variant override via ENGINE_<id>
ENGINE_DEFAULT := xelatex

# variants that prefer pdflatex (moderncv, plain LaTeX-only)
ENGINE_v05_moderncv_classic   := pdflatex
ENGINE_v06_moderncv_banking   := pdflatex
ENGINE_v07_moderncv_casual    := pdflatex
ENGINE_v24_moderncv_classic_ptbr := pdflatex

.PHONY: all clean list $(VARIANTS)

all: $(VARIANTS)

list:
	@printf '%s\n' $(VARIANTS)

# build pattern: each variant dir vNN_* compiles to build/vNN_*.pdf
$(VARIANTS): %: $(BUILD)/%.pdf

$(BUILD)/%.pdf: %/main.tex | $(BUILD)
	@engine="$$(echo $(ENGINE_$*))"; [[ -z "$$engine" ]] && engine="$(ENGINE_DEFAULT)"; \
	echo "==> [$$engine] $*"; \
	cd $* && \
	TEXINPUTS=".:$(SHARED):" BIBINPUTS=".:$(SHARED):" \
	  latexmk -$$engine $(LATEXMK_FLAGS) -jobname=$* -output-directory=$(BUILD) main.tex \
	  >/dev/null 2>&1 || { \
	    echo "  ! build failed for $*; rerunning with output:"; \
	    TEXINPUTS=".:$(SHARED):" BIBINPUTS=".:$(SHARED):" \
	      latexmk -$$engine $(LATEXMK_FLAGS) -jobname=$* -output-directory=$(BUILD) main.tex; \
	    exit 1; \
	  }

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
	find . -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.bbl' \
	  -o -name '*.bcf' -o -name '*.blg' -o -name '*.run.xml' -o -name '*.fls' \
	  -o -name '*.fdb_latexmk' -o -name '*.toc' -o -name '*.synctex.gz' \) \
	  -not -path './shared/*' -delete
