# CV variants — routing index

Curated set of Marcelo Vironda Rozanti CV variants. Two axes per CV:

- **Template**: visual class / layout
- **Framing**: tone, structure, emphasis (what story it tells)

Pick by **target audience** + **submission channel** (ATS vs. recruiter human eye vs. exec / hiring manager).

## Quick chooser

| If the target is...                                 | Use                            |
| --------------------------------------------------- | ------------------------------ |
| ATS-scanned job board, unknown parser               | `v11_ats_keyword`              |
| Brazilian fintech / bank, recruiter human eye       | `v03_altacv_fintech`           |
| FAANG / Big Tech IC application                     | `v13_faang_xyz`                |
| Staff / Architect role                              | `v20_architect_systems`        |
| Startup generalist (Series A–C)                     | `v21_startup_generalist`       |
| Consulting / contract                               | `v18_consultant_star`          |
| Open-source / DevTools / craft-aware company        | `v14_craft_oss`                |
| Tight one-pager, dense                              | `v04_altacv_compact` / `v10_deedy_dense` |
| Conservative European / academic style              | `v05_moderncv_classic`         |
| Compliance / regulated industry emphasis            | `v19_compliance_fintech`       |
| Portuguese (PT-BR) submission                       | `v23`–`v26`                    |

## Full catalog

| ID  | Template            | Framing                          | Page len | Tone                | When to pick |
| --- | ------------------- | -------------------------------- | -------- | ------------------- | ------------ |
| v01 | altacv sidebar      | baseline (cleaned current)       | 2        | neutral             | known-good fallback |
| v02 | altacv sidebar      | impact / metrics rewrite         | 2        | outcome-driven      | senior IC, eng-led orgs |
| v03 | altacv sidebar      | fintech / banking narrative      | 2        | domain-expert       | Brazilian fintech, banks |
| v04 | altacv sidebar      | compact one-pager                | 1        | terse               | recruiter quick-scan |
| v05 | moderncv classic    | classic chrono                   | 2        | conservative        | European, academic, gov |
| v06 | moderncv banking    | banking layout (right-aligned)   | 2        | formal              | finance, traditional |
| v07 | moderncv casual     | casual                            | 2        | warm                 | mid-size product cos |
| v08 | awesome-cv style    | impact-led, accent headers       | 2        | sharp               | product cos, design-conscious |
| v09 | awesome-cv style    | OSS-first                        | 2        | builder              | devtools, infra cos |
| v10 | deedy two-column    | dense, single page               | 1        | terse                | new grad-style packed, but senior |
| v11 | ATS one-column      | keyword-heavy plain text         | 2        | machine-readable    | LinkedIn Easy Apply, ATS |
| v12 | ATS one-column      | executive summary lead           | 2        | narrative           | hiring manager forward |
| v13 | one-column impact   | FAANG XYZ-formula bullets        | 1–2      | quantified          | Big Tech IC apps |
| v14 | minimal typographic | OSS hacker / craft               | 2        | personal             | devtools, infra, ML infra |
| v15 | minimal typographic | polyglot breadth                 | 2        | curious              | early-stage, multi-stack |
| v16 | typographic minimal | pure typography no icons         | 1        | austere              | high-signal eng audience |
| v17 | tikz timeline       | visual timeline + bullets        | 2        | designer-friendly   | scale-up, brand-aware |
| v18 | consultant STAR     | situation/task/action/result     | 2        | consulting           | contract, advisory |
| v19 | altacv sidebar      | compliance / security emphasis   | 2        | regulated-industry  | banks, payments, health |
| v20 | one-column          | systems architect / staff        | 2        | systems-level       | staff / principal roles |
| v21 | one-column          | startup generalist scrappy       | 1        | builder              | Series A–C "wear many hats" |
| v22 | two-col engineering | compact engineering              | 1        | dense                | infra / SRE-flavored apps |
| v23 | altacv sidebar      | PT-BR impact rewrite             | 2        | outcome-driven      | BR fintech, recruiter |
| v24 | moderncv classic    | PT-BR classic                    | 2        | conservative        | BR formal / gov |
| v25 | ATS one-column      | PT-BR keyword                    | 2        | machine-readable    | BR job boards |
| v26 | one-column          | PT-BR executive summary          | 2        | narrative            | BR hiring manager |

## Building

```sh
# build one variant
make v02_altacv_impact

# build all
make all

# clean LaTeX artifacts
make clean
```

PDFs land in `build/<id>.pdf`. Each variant is self-contained in `vNN_*/main.tex` and uses shared assets from `../shared/` (photo, bib, altacv.cls where needed) via TEXINPUTS injected by the Makefile.

## Content invariants

All variants describe the same factual history. Differences are wording, ordering, density, emphasis, and visual template. No invented metrics — only stronger framing of the same work.

If a future variant needs a brand-new fact (e.g. "reduced p99 latency by 40%"), add it to `shared/facts.md` first so all variants stay consistent.

## Adding a new variant

1. Pick the next free `vNN`
2. `mkdir vNN_short_name && cp v01_altacv_baseline/main.tex vNN_short_name/main.tex` (or a closer-matching template)
3. Rewrite the body to the new framing
4. Add a row to the catalog table above
5. `make vNN_short_name` to verify it builds

## For LLMs reading this

If you are an LLM helping the user tailor a CV for a specific job posting:

1. Read the posting; identify role level (IC / staff / mgr), company stage (startup / scaleup / enterprise / FAANG / bank), industry, ATS likelihood.
2. Pick the closest variant from the Quick chooser table.
3. Open that variant's `main.tex`; propose small surgical edits to align taglines, top bullets, and skill ordering to the posting. Do **not** invent metrics. Do **not** silently rewrite everything — show a diff.
4. If no existing variant fits, propose creating one (next free `vNN`) with the new framing rationale before writing it.
