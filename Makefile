SHELL  := /usr/bin/env bash
ROOT   := $(abspath .)
SHARED := $(ROOT)/shared
BUILD  := $(ROOT)/build

IDS  := en-original en-human en-bot ptbr-original ptbr-human ptbr-bot
PDFS := $(addprefix $(BUILD)/,$(addsuffix .pdf,$(IDS)))
LATEXMK_FLAGS := -xelatex -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: all clean check list preview $(IDS)
all: $(PDFS)
list: ; @printf '%s\n' $(IDS)
$(IDS): %: $(BUILD)/%.pdf

.SECONDEXPANSION:
$(BUILD)/%.pdf: $$(wildcard $$(subst -,/,$$*)/*.tex) $(SHARED)/altacv.cls $(SHARED)/refs.bib | $(BUILD)
	@dir="$(subst -,/,$*)"; echo "==> [xelatex] $* ($$dir)"; \
	cd "$$dir" && TEXINPUTS=".:$(SHARED):" BIBINPUTS=".:$(SHARED):" \
	  latexmk $(LATEXMK_FLAGS) -jobname=$* -output-directory=$(BUILD) main.tex >/dev/null 2>&1 \
	|| { echo "  ! build failed for $*; rerunning verbosely:"; cd "$(ROOT)/$$dir" && \
	     TEXINPUTS=".:$(SHARED):" BIBINPUTS=".:$(SHARED):" \
	     latexmk $(LATEXMK_FLAGS) -jobname=$* -output-directory=$(BUILD) main.tex; exit 1; }

$(BUILD): ; @mkdir -p $(BUILD)
check: all
	@fail=0; shopt -s nullglob; \
	for t in tests/*.sh; do echo "==> test: $$t"; bash "$$t" || fail=1; done; \
	exit $$fail
preview: ptbr-human ; @bash render-preview.sh
clean:
	@rm -rf $(BUILD)
	@find en ptbr -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.bbl' \
	  -o -name '*.bcf' -o -name '*.blg' -o -name '*.run.xml' -o -name '*.fls' \
	  -o -name '*.fdb_latexmk' -o -name '*.xdv' \) -delete
