SHELL  := /usr/bin/env bash
ROOT   := $(abspath .)
SHARED := $(ROOT)/shared
BUILD  := $(ROOT)/build
OUT    := $(ROOT)/out

IDS  := en-default en-bot ptbr-default ptbr-bot
PDFS := $(addprefix $(BUILD)/,$(addsuffix .pdf,$(IDS)))
LATEXMK_FLAGS := -xelatex -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: all clean check list preview dist $(IDS)
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
preview: ptbr-default ; @bash render-preview.sh
dist: all preview
	@mkdir -p $(OUT)
	@cp $(PDFS) $(OUT)/
	@dvisvgm --page=1 --no-fonts --stdout "$(BUILD)/ptbr-default.xdv" > "$(BUILD)/resume.svg" 2>/dev/null
	@inkscape "$(BUILD)/resume.svg" -w 600 -b '#ffffff' -y 1.0 -o "$(OUT)/resume.png" 2>/dev/null
	@echo "==> dist -> $(OUT) (4 committed PDFs + resume.png for cv.mvr.ac / mvr.ac hero)"
clean:
	@rm -rf $(BUILD)
	@find en ptbr -type f \( -name '*.aux' -o -name '*.log' -o -name '*.out' -o -name '*.bbl' \
	  -o -name '*.bcf' -o -name '*.blg' -o -name '*.run.xml' -o -name '*.fls' \
	  -o -name '*.fdb_latexmk' -o -name '*.xdv' \) -delete
