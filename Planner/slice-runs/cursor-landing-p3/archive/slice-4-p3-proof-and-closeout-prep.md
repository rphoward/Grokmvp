# NEXT-SLICE — slice 4 p3-proof-and-closeout-prep (archived 2026-05-24, passed_closing)

**Review:** schema exit 0 (re-run); § P3 closeout proof outcomes 1–4; link pass OK (9-file scope); PHASE-BACKLOG + phase_lessons; fixtures README rollup link; rows 1–3 unchanged; scope PROOF-LOG + PHASE-BACKLOG + fixtures README only; closes ro-4; ready for `final_closeout`.
```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p3")
  (slice
    (number 4)
    (name p3-proof-and-closeout-prep)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name p3-proof-and-closeout-prep)
    (finish_line "P3 maintainer proof rollup in PROOF-LOG traces PHASE-MAP outcomes 1–4 to slices 1–3; schema + link pass recorded; P4 deferrals finalized in PHASE-BACKLOG; fixtures README points at P3 closeout proof; ready for final_closeout.")
    (distance_closed "Closes ro-4-maintainer-proof-note; last implementation slice before final_closeout. Does not re-run dogfood, re-edit slices 1–3 product files, or scaffold P4 publish tree.")
    (required_outcomes (ro-4-maintainer-proof-note))
    (optional_deferred_outcomes
      (publishable-tree-scaffold "P4 — document in PHASE-BACKLOG; not created here")
      (validate-package-py "P4 after P3 dogfood pass")))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8 P3"
    "Planner/phase-map/PHASE-MAP.md P3 required_outcomes 1–4"
    "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md rows 1–3"
    "Planner/slice-runs/cursor-landing-p3/PHASE-BACKLOG.md"
    "Planner/slice-runs/cursor-landing-p3/archive/slice-1-install-skills-docs-align.md"
    "Planner/slice-runs/cursor-landing-p3/archive/slice-2-titan-dogfood.md"
    "Planner/slice-runs/cursor-landing-p3/archive/slice-3-fixtures-sanitize-sync.md"
    "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md § P2 closeout proof (pattern)"
    "tests/fixtures/README.md"
    "tests/fixtures/dogfood-notes.md"
    "AGENTS.md proof command")

  (run_dir_validation
    (dogfood_path "C:\\Projects\\Kbupgrade - Copy (4)")
    (dogfood_read_only true)
    (titan_path_superseded "C:\\Antigravity_Dev\\Titan_GenAI_KB_Builder_v5_Standalone")
    (note "Trace table documents Kbupgrade substitution; do not re-init dogfood or write on external path"))

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "p3_proof_log_rollup; phase_backlog_finalize; p3_fixtures_proof_note; maintainer_link_pass")
    (layer_ownership
      (concept
        (name p3_proof_log_rollup)
        (owner presentation)
        (path Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md)
        (must_not_change "Rows 1–3 proof text unchanged; add ## P3 closeout proof (maintainer) with outcomes 1–4 → slices 1–3; ### Re-run commands; ### Deferred to P4; slice 4 table row added on review only"))
      (concept
        (name phase_backlog_finalize)
        (owner presentation)
        (path Planner/slice-runs/cursor-landing-p3/PHASE-BACKLOG.md)
        (must_not_change "P4 deferred phase + carried P2/P3 optional items; phase_lessons one line max; note actual dogfood path Kbupgrade vs PHASE-MAP Titan label"))
      (concept
        (name p3_fixtures_proof_note)
        (owner infrastructure)
        (path tests/fixtures/README.md)
        (must_not_change "P3 subsection exists from slice 3 — add rollup link to PROOF-LOG § P3 closeout proof and link-pass scope line only; do not duplicate dogfood-notes content"))
      (concept
        (name maintainer_link_pass)
        (owner presentation)
        (path README.md)
        (must_not_change "Verify-only unless broken relative href; fix README links only if pass finds breakage")))
    (architecture_guardrails
      "Closeout prep only — no SKILL, references product bodies (except README href fix), .cursor/rules, or adopted/capex3 edits."
      "PROOF-LOG rows 1–3 already passed_closing — rollup cites them; do not rewrite slice proof rows."
      "Dogfood evidence: read-only checklist on Kbupgrade path (≥2 .mdc count, CONTEXT/AGENTS presence) recorded in § P3 closeout proof; no Phase 2 writes on external repo."
      "PHASE-MAP P3 outcome 2 still names Titan in header text — trace table uses Kbupgrade per slice 2 fixture_substitution; do not edit PHASE-MAP in this slice."
      "final_closeout (separate mode) writes STATUS closeout_validation — not this slice.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect_first
    "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md rows 1–3"
    "Planner/slice-runs/cursor-landing-p3/archive/slice-2-titan-dogfood.md"
    "tests/fixtures/README.md"
    "tests/fixtures/dogfood-notes.md")

  (inspect
    "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md"
    "Planner/slice-runs/cursor-landing-p3/PHASE-BACKLOG.md"
    "Planner/slice-runs/cursor-landing-p3/SLICE-LIST.md"
    "Planner/phase-map/PHASE-MAP.md P3 required_outcomes 1–4"
    "tests/fixtures/README.md"
    "tests/fixtures/dogfood-notes.md"
    "AGENTS.md"
    "README.md"
    "OVERVIEW.md"
    "CONTEXT.md"
    "references/install.md"
    "references/skill-authoring.md"
    "references/troubleshooting.md"
    "references/annexes/INDEX.md"
    "references/annexes/cursor.md")

  (allowed_changes
    (edit "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md")
    (edit "Planner/slice-runs/cursor-landing-p3/PHASE-BACKLOG.md")
    (edit "tests/fixtures/README.md")
    (edit "README.md" "relative link targets only if link pass finds broken href"))

  (constraints
    (forbidden_edits
      "C:\\Projects\\Kbupgrade - Copy (4)\\"
      SKILL.md
      references/ except README href-only fix
      assets/
      scripts/
      .cursor/rules/
      Planner/adopted/
      Planner/contracts/
      Planner/phase-map/
      Planner/router-state.md
      Planner/AGENTS.md
      Planner/context-index.md
      AGENTS.md
      CONTEXT.md
      OVERVIEW.md
      docs/
      src/ lib/ apps/ domain/ application/)
    (proof_log_edits
      "Append ## P3 closeout proof (maintainer): table outcomes 1–4 → slices 1–3 → evidence (cite rows 1–3 + dogfood-notes); note Kbupgrade vs Titan; ### Re-run commands (schema + link pass scope/result + optional read-only dogfood checklist); ### Deferred to P4. Do not add slice 4 table row until review.")
    (phase_backlog_edits
      "Confirm P4 run dir; publishable-tree-scaffold + validate-package-py; phase_lessons one line; dogfood path note Kbupgrade.")
    (fixtures_readme_edits
      "Under ## P3 maintainer proof: add link to PROOF-LOG § P3 closeout proof; document P3 link-pass file list (slice 1 paths + standard maintainer set).")
    (link_pass_scope
      "Relative href verify: README, OVERVIEW, CONTEXT, AGENTS.md, references/install.md, references/skill-authoring.md, references/troubleshooting.md, references/annexes/INDEX.md, references/annexes/cursor.md — read-only except README broken-target fix.")
    (dogfood_checklist_read_only
      "Optional: Get-ChildItem 'C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules\\*.mdc' -Name; Test-Path CONTEXT.md AGENTS.md — record counts in PROOF-LOG § P3 closeout proof; no writes on external path.")
    (run_state_on_implement
      "Update STATUS.md to slice_review_needed only among Planner/slice-runs/cursor-landing-p3/ allowed paths."))

  (proof
    (command
      "python -c \"import json,jsonschema; jsonschema.validate(json.load(open('tests/fixtures/scan-report-example.json')), json.load(open('references/scan-report.schema.json')))\""
      "Expect exit code 0 from repo root.")
    (manual
      "PROOF-LOG rows 1–3 status passed_closing"
      "PROOF-LOG § P3 closeout proof maps outcomes 1–4 to slices 1–3 (outcome 2 cites Kbupgrade + ≥2 .mdc)"
      "Link pass recorded in PROOF-LOG re-run table; broken href zero or README-only fixes listed"
      "PHASE-BACKLOG: P4 deferred phase + publishable-tree + validate-package-py; phase_lessons ≤1 line"
      "tests/fixtures/README.md links to PROOF-LOG § P3 closeout proof"
      "grep '(to add)' CONTEXT.md → zero (read-only)")
    (record_in "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md slice 4 row on review")
    (pass_criteria
      "P3 outcomes 1–4 traced; schema + link pass documented; P4 deferrals in PHASE-BACKLOG; scope limited to allowed_changes; ready for final_closeout after review."))

  (implementer_checklist
    (step_1 "Read PROOF-LOG rows 1–3 and archives; confirm no edits to row proof text")
    (step_2 "Run schema validate; optional read-only dogfood path checklist")
    (step_3 "Run link pass on scope; fix README only if broken href")
    (step_4 "Add ## P3 closeout proof (maintainer) + re-run + deferrals sections to PROOF-LOG.md")
    (step_5 "Finalize PHASE-BACKLOG.md (P4 table, carried items, phase_lessons)")
    (step_6 "Touch tests/fixtures/README.md — rollup link + P3 link-pass scope line")
    (step_7 "Set STATUS slice_review_needed; append implementation_handback below"))

  (out_of_scope
    "final_closeout and STATUS closeout_validation (next session after slice 4 review)"
    "PHASE-MAP header Titan→Kbupgrade wording (user or final_closeout)"
    "router-state.md active_phase update"
    "Re-implementing slices 1–3"
    "Publishable tree scaffold (P4)"
    "scripts/validate-package.py (P4)"
    "Dogfood re-run or writes on Kbupgrade")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths + STATUS on implement; PROOF-LOG slice 4 row on review")
    (do_not_write closeout_validation PHASE_MAP_router_state)))

```

## Implementer checklist

| Task | Detail |
|------|--------|
| **PROOF-LOG.md** | Add **## P3 closeout proof (maintainer)** — table mapping PHASE-MAP P3 outcomes 1–4 → slices 1–3 → evidence (cite existing rows 1–3; outcome 2: Kbupgrade path, ≥2 `.mdc`, Q14); **### Re-run commands** (schema + link pass scope/result + optional dogfood read-only checklist); **### Deferred to P4**. Do **not** add slice 4 table row until review. |
| **PHASE-BACKLOG.md** | Finalize P4 run dir; `publishable-tree-scaffold` + `validate-package-py`; note Kbupgrade as actual P3 dogfood path; **phase_lessons** ≤1 line. |
| **tests/fixtures/README.md** | Under **## P3 maintainer proof**: link to PROOF-LOG § P3 closeout proof; list P3 link-pass files (install, skill-authoring, troubleshooting, cursor annex + standard set). |
| **Link pass (verify)** | README, OVERVIEW, CONTEXT, AGENTS.md, `references/install.md`, `references/skill-authoring.md`, `references/troubleshooting.md`, `references/annexes/INDEX.md`, `references/annexes/cursor.md` — record OK or fixes in PROOF-LOG. |
| **Schema** | AGENTS.md command from repo root → exit 0. |
| **Dogfood (read-only)** | Optional: confirm `C:\Projects\Kbupgrade - Copy (4)` still has CONTEXT, AGENTS, ≥2 `.mdc` — record in rollup; no writes. |
| **Do not** | Edit SKILL, references/ (except README href fix), rules, CONTEXT, OVERVIEW, AGENTS, phase-map, router-state, or slice 1–3 product files. |

**After implement:** fresh session → **review the active slice** → slice 4 row in PROOF-LOG → **final_closeout** in a following session.

## implementation_handback

| Check | Result |
|-------|--------|
| Schema validate | exit 0 (2026-05-24) |
| Link pass | 80 relative links in 9 files — zero broken; no README edits |
| `(to add)` in CONTEXT.md | zero |
| PROOF-LOG rows 1–3 | unchanged; `passed_closing` |
| Dogfood read-only | Kbupgrade: CONTEXT, AGENTS, GEMINI; 3× `.mdc` (conduct, safety, kb-pipeline) |
| Files touched | `PROOF-LOG.md` (§ P3 closeout proof), `PHASE-BACKLOG.md`, `tests/fixtures/README.md`, `STATUS.md` |
| Slice 4 PROOF-LOG row | deferred to review |

**Scope:** allowed paths only; no product/reference/skill edits.
