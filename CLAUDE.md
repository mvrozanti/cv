# CV — Marcelo Vironda Rozanti

One LaTeX repo, **4 canonical CVs = 2 languages × 2 framings**. Pick by audience + channel.

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
   oldest last. Applies to all four.

## The matrix

|          | default (hand-authored altacv) | bot (ATS plain-text) |
|----------|--------------------------------|----------------------|
| **en**   | `en/default`                   | `en/bot`             |
| **ptbr** | `ptbr/default`                 | `ptbr/bot`           |

- **default** — the hand-authored altacv CV (`main.tex` + `sidebar.tex`). Leave
  wording; structural moves only. Recruiter eye, direct/networked sends.
- **bot** — ATS-safe: single self-contained `article`, no columns/graphics/icons,
  keyword-dense. Job boards, LinkedIn Easy Apply, unknown parsers.

**Primary/featured CV: `ptbr/default`** — the README hero (`make preview`); polish focus.

## Structure

    shared/   altacv.cls  refs.bib  facts.md  photo.png   # facts.md = source of truth
    en/   default/  bot/    # each: main.tex (+ sidebar.tex for altacv)
    ptbr/ default/  bot/
    build/   # gitignored scratch (latex artifacts + intermediate PDFs)
    out/     # COMMITTED deliverables: 4 <id>.pdf + resume.png (via `make dist`)

## Source of truth

`shared/facts.md` is canonical for every claim. **Never invent metrics** — no fabricated
p99 / throughput / cost numbers. Stronger verbs and domain framing ("regulated",
"high-availability") are fine. A new fact goes into `facts.md` first, then into the CVs,
so all four stay consistent.

## Build & check

    make            # all four -> build/<id>.pdf
    make en-default # one CV
    make check      # build all + assert no orphan pages (MUST pass)
    make preview    # regenerate preview.png (ptbr/default, all pages)
    make dist       # build + copy 4 PDFs to out/ + render out/resume.png
    make clean

Engine is xelatex for all four; `latexmk` auto-runs `biber` for the altacv CVs.
Page measurement uses `dvisvgm` on the `.xdv` (ghostscript is not installed; `gs` is
shell-aliased to `git status`). Render path for images: dvisvgm `.xdv` → svg → inkscape.

## EN ↔ PTBR parity

`en/<framing>` and `ptbr/<framing>` describe the same facts/roles/stack. Edit both
together. PT-BR text runs ~15% longer, so re-run `make check` on the ptbr side after any
content change (PT-BR is where orphans appear first).

## Tailoring for a specific job

1. Read the posting: level (IC/staff/mgr), company stage, industry, ATS likelihood.
2. Pick framing: ATS/job-board → `bot`; recruiter human eye → `default`.
3. Open that `main.tex`; propose small surgical edits to tagline, top bullets, skill
   ordering. Do not invent metrics. Do not silently rewrite — show a diff. **Never drop a
   role's responsibilities or tech (rule 1).**
4. `make <id> check` before sending.

## Conventions

Conventional Commits (`feat`/`fix`/`docs`/`refactor`/`build`, scope `cv`). `build/` and
`*.pdf` are gitignored *except* `out/*.pdf`. Committed generated assets: `preview.png`
(README hero, `make preview`) and everything under `out/` — the 4 PDFs + `resume.png`
consumed by `cv.mvr.ac` and the `mvr.ac` landing hero (`make dist`). Refresh `out/` with
`make dist` after any content change so the committed PDFs never drift from source.
