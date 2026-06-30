# CV — Marcelo Vironda Rozanti

One LaTeX repo, **6 canonical CVs = 2 languages × 3 framings**. Pick by audience + channel.

## Three hard rules (do not violate)

1. **Never lose job-description information when editing.** When changing any CV, no
   responsibility, achievement, technology, domain, date, employer, or role may be
   dropped. Reorder, reframe, restyle freely; delete substance never. Trimming pure
   filler (adjectives, connective fluff) is allowed only if every fact survives. This
   applies to orphan fixes, tailoring, and translation alike.
2. **No orphan / leftover pages.** Every CV is either ≤1 full page, or a genuinely
   filled multi-page document (last page ≥ ~half). `make check` is the gate and MUST
   pass after any edit. Fix an orphan **non-destructively**, in this order:
   (a) geometry/margins, (b) typography (`\AtBeginEnvironment{itemize}{\small}`, tighter
   `\divider`/itemsep, `\footnotesize` tag rows), (c) expand to honestly fill the extra
   page. **Never fix an orphan by cutting job info — rule 1 wins.**
3. **Reverse-chronological always.** Every CV lists the most recent role first,
   oldest last. Applies to all six.

## The matrix

|          | original (hand-authored) | human (altacv, impact) | bot (ATS plain-text) |
|----------|--------------------------|------------------------|----------------------|
| **en**   | `en/original`            | `en/human`             | `en/bot`             |
| **ptbr** | `ptbr/original`          | `ptbr/human`           | `ptbr/bot`           |

- **original** — the hand-authored altacv CV. Leave wording; structural moves only.
- **human** — altacv "pretty", outcome/impact bullets (`main.tex` + `sidebar.tex`).
  Recruiter human eye, direct/networked sends.
- **bot** — ATS-safe: single self-contained `article`, no columns/graphics/icons,
  keyword-dense. Job boards, LinkedIn Easy Apply, unknown parsers.

**Primary/featured CV: `ptbr/original`** — the README hero (`make preview`); polish focus.

## Structure

    shared/   altacv.cls  refs.bib  facts.md  photo.png   # facts.md = source of truth
    en/   original/  human/  bot/    # each: main.tex (+ sidebar.tex for altacv)
    ptbr/ original/  human/  bot/
    build/   # gitignored; PDFs never committed (only preview.png is)

## Source of truth

`shared/facts.md` is canonical for every claim. **Never invent metrics** — no fabricated
p99 / throughput / cost numbers. Stronger verbs and domain framing ("regulated",
"high-availability") are fine. A new fact goes into `facts.md` first, then into the CVs,
so all six stay consistent.

## Build & check

    make            # all six -> build/<id>.pdf
    make en-human   # one CV
    make check      # build all + assert no orphan pages (MUST pass)
    make preview    # regenerate preview.png (ptbr/human page 1)
    make clean

Engine is xelatex for all six; `latexmk` auto-runs `biber` for the altacv CVs.
Page measurement uses `dvisvgm` on the `.xdv` (ghostscript is not installed; `gs` is
shell-aliased to `git status`). Render path for images: dvisvgm `.xdv` → svg → inkscape.

## EN ↔ PTBR parity

`en/<framing>` and `ptbr/<framing>` describe the same facts/roles/stack. Edit both
together. PT-BR text runs ~15% longer, so re-run `make check` on the ptbr side after any
content change (PT-BR is where orphans appear first).

## Tailoring for a specific job

1. Read the posting: level (IC/staff/mgr), company stage, industry, ATS likelihood.
2. Pick framing: ATS/job-board → `bot`; recruiter human eye → `human`; conservative/as-is
   → `original`.
3. Open that `main.tex`; propose small surgical edits to tagline, top bullets, skill
   ordering. Do not invent metrics. Do not silently rewrite — show a diff. **Never drop a
   role's responsibilities or tech (rule 1).**
4. `make <id> check` before sending.

## Conventions

Conventional Commits (`feat`/`fix`/`docs`/`refactor`/`build`, scope `cv`). Do not track
build artifacts: `build/` and `*.pdf` are gitignored; the only committed generated asset
is `preview.png` (via `make preview`).
