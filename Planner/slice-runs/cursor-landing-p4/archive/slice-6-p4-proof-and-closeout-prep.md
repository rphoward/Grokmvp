# NEXT-SLICE — slice 6 p4-proof-and-closeout-prep (archived 2026-05-24, passed_closing)

**Review:** schema exit 0 (re-run); build 38 files; validate exit 0; § P4 closeout proof outcomes 1–6; link pass OK (7-file scope, 83 links); PHASE-BACKLOG out-of-map + phase_lessons; fixtures § P4 maintainer proof; rows 1–5 unchanged; scope allowed paths only; closes ro-6; ready for `final_closeout` → `project_complete`.

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (slice
    (number 6)
    (name p4-proof-and-closeout-prep)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name p4-proof-and-closeout-prep)
    (finish_line "P4 maintainer proof rollup in PROOF-LOG traces PHASE-MAP outcomes 1–6 to slices 1–5; build + validate-package + schema commands recorded; link pass documented; out-of-map deferrals finalized in PHASE-BACKLOG; fixtures README carries P4 maintainer proof subsection; ready for final_closeout → project_complete.")
    (distance_closed "Closes ro-6-maintainer-proof-note; last implementation slice before final_closeout. Does not re-run build smoke, re-edit slices 1–5 product files, or commit publishable tree.")
    (required_outcomes (ro-6-maintainer-proof-note))
    (optional_deferred_outcomes
      (automated-repo-scanner "out of phase map — document in PHASE-BACKLOG; not implemented here")
      (team-mcp-merge-templates "user-invoked only — PHASE-BACKLOG")))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8 P4"
    "Planner/phase-map/PHASE-MAP.md P4 required_outcomes 1–6"
    "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md rows 1–5"
    "Planner/slice-runs/cursor-landing-p4/PHASE-BACKLOG.md"
    "Planner/slice-runs/cursor-landing-p4/archive/slice-1-publishable-tree-scaffold.md"
    "Planner/slice-runs/cursor-landing-p4/archive/slice-2-install-readme-publish-align.md"
    "Planner/slice-runs/cursor-landing-p4/archive/slice-3-github-install-smoke.md"
    "Planner/slice-runs/cursor-landing-p4/archive/slice-4-troubleshooting-hosts-coverage.md"
    "Planner/slice-runs/cursor-landing-p4/archive/slice-5-validate-package-script.md"
    "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md § P3 closeout proof (pattern)"
    "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md § P2 closeout proof (pattern)"
    "tests/fixtures/README.md"
    "AGENTS.md proof command")

  (run_dir_validation
    (publishable_root "cursor-landing/cursor-landing/")
    (publishable_tree_commit "optional — note untracked state in rollup if still uncommitted; do not scope-commit in this slice unless user asks")
    (github_smoke "recorded in fixtures README § P4 GitHub install smoke — cite not re-run unless re-run table needs fresh exit codes"))

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "p4_proof_log_rollup; phase_backlog_finalize; p4_fixtures_proof_note; maintainer_link_pass")
    (layer_ownership
      (concept
        (name p4_proof_log_rollup)
        (owner presentation)
        (path Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md)
        (must_not_change "Rows 1–5 proof text unchanged; add ## P4 closeout proof (maintainer) with outcomes 1–6 → slices 1–5; ### Re-run commands; ### Out of phase map; slice 6 table row added on review only"))
      (concept
        (name phase_backlog_finalize)
        (owner presentation)
        (path Planner/slice-runs/cursor-landing-p4/PHASE-BACKLOG.md)
        (must_not_change "Out-of-map deferrals only; confirm P4 is final mapped phase; no new product scope; phase_lessons one line max if warranted"))
      (concept
        (name p4_fixtures_proof_note)
        (owner infrastructure)
        (path tests/fixtures/README.md)
        (must_not_change "P4 GitHub smoke + validate-package subsections exist from slices 3/5 — add ## P4 maintainer proof consolidating schema + build + validate + link pass + rollup link; do not duplicate smoke table"))
      (concept
        (name maintainer_link_pass)
        (owner presentation)
        (path README.md)
        (must_not_change "Verify-only unless broken relative href; fix README links only if pass finds breakage")))
    (architecture_guardrails
      "Closeout prep only — no SKILL, references product bodies (except README href fix), assets/, scripts/, .cursor/rules/, or adopted/capex3 edits."
      "PROOF-LOG rows 1–5 already passed_closing — rollup cites them; do not rewrite slice proof rows."
      "Build/validate re-run commands recorded in § P4 closeout proof; implementer may re-run for fresh exit codes but must not change publishable tree content beyond allowed paths."
      "PHASE-MAP deferred_phases empty after P4 closeout → project_complete; PHASE-BACKLOG holds out-of-map items only."
      "final_closeout (separate mode) writes STATUS closeout_validation — not this slice.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect_first
    "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md rows 1–5"
    "Planner/slice-runs/cursor-landing-p4/PHASE-BACKLOG.md"
    "tests/fixtures/README.md § P4 GitHub install smoke and § P4 validate-package")

  (inspect
    "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md"
    "Planner/slice-runs/cursor-landing-p4/PHASE-BACKLOG.md"
    "Planner/slice-runs/cursor-landing-p4/SLICE-LIST.md"
    "Planner/phase-map/PHASE-MAP.md P4 required_outcomes 1–6"
    "tests/fixtures/README.md"
    "AGENTS.md"
    "README.md"
    "OVERVIEW.md"
    "CONTEXT.md"
    "references/install.md"
    "references/troubleshooting.md"
    "references/annexes/INDEX.md"
    "scripts/build-install-bundle.ps1"
    "scripts/validate-package.py"
    "cursor-landing/cursor-landing/BUNDLE-MANIFEST.md")

  (allowed_changes
    (edit "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md")
    (edit "Planner/slice-runs/cursor-landing-p4/PHASE-BACKLOG.md")
    (edit "tests/fixtures/README.md")
    (edit "README.md" "relative link targets only if link pass finds broken href"))

  (constraints
    (forbidden_edits
      SKILL.md
      references/ except README href-only fix
      assets/
      scripts/
      cursor-landing/cursor-landing/
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
      install-bundle/
      src/ lib/ apps/ domain/ application/)
    (proof_log_edits
      "Append ## P4 closeout proof (maintainer): table outcomes 1–6 → slices 1–5 → evidence (cite rows 1–5 + fixtures README smoke/validate subsections); ### Re-run commands (schema + build + validate-package + link pass scope/result); ### Out of phase map (automated scanner, MCP merge templates, etc.). Do not add slice 6 table row until review.")
    (phase_backlog_edits
      "Confirm P4 final mapped phase; out-of-map table aligned with SLICE-LIST optional_deferred_outcomes and PHASE-MAP § Out of phase map; phase_lessons ≤1 line if closeout note warrants.")
    (fixtures_readme_edits
      "Add ## P4 maintainer proof (factory) after existing P4 subsections: schema command, build → validate-package command chain, P4 link-pass file list, rollup link to PROOF-LOG § P4 closeout proof; echo that GitHub smoke + validate subsections remain authoritative detail.")
    (link_pass_scope
      "Relative href verify: README, OVERVIEW, CONTEXT, AGENTS.md, references/install.md, references/troubleshooting.md, references/annexes/INDEX.md — read-only except README broken-target fix. Do not edit publishable tree paths in this slice.")
    (re_run_commands
      "From repo root: schema validate (AGENTS.md); scripts\\build-install-bundle.ps1 → cursor-landing/cursor-landing/; python scripts/validate-package.py → exit 0; record counts (file count, validate checks) in PROOF-LOG § P4 closeout proof.")
    (run_state_on_implement
      "Update STATUS.md to slice_review_needed only among Planner/slice-runs/cursor-landing-p4/ allowed paths."))

  (proof
    (command
      "python -c \"import json,jsonschema; jsonschema.validate(json.load(open('tests/fixtures/scan-report-example.json')), json.load(open('references/scan-report.schema.json')))\""
      "scripts\\build-install-bundle.ps1"
      "python scripts/validate-package.py"
      "Expect schema exit 0; build emits cursor-landing/cursor-landing/; validate exit 0 on publishable root.")
    (manual
      "PROOF-LOG rows 1–5 status passed_closing"
      "PROOF-LOG § P4 closeout proof maps outcomes 1–6 to slices 1–5 (outcome 6 self-reference to this section + fixtures README)"
      "Re-run table records schema + build + validate-package + link pass scope/result"
      "Link pass: broken href zero or README-only fixes listed"
      "grep '(to add)' CONTEXT.md → zero (read-only)"
      "PHASE-BACKLOG: out-of-map deferrals present; notes P4 final phase"
      "tests/fixtures/README.md has ## P4 maintainer proof subsection with rollup link")
    (record_in "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md slice 6 row on review")
    (pass_criteria
      "P4 outcomes 1–6 traced; build/validate/schema + link pass documented; out-of-map deferrals in PHASE-BACKLOG; fixtures README P4 maintainer proof; scope limited to allowed_changes; ready for final_closeout → project_complete after review."))

  (implementer_checklist
    (step_1 "Read PROOF-LOG rows 1–5 and archives; confirm no edits to row proof text")
    (step_2 "Re-run schema validate + build-install-bundle.ps1 + validate-package.py; record exit codes and file count in rollup")
    (step_3 "Run link pass on scope; fix README only if broken href")
    (step_4 "Add ## P4 closeout proof (maintainer) + re-run + out-of-map sections to PROOF-LOG.md")
    (step_5 "Finalize PHASE-BACKLOG.md (out-of-map table, phase_lessons if warranted)")
    (step_6 "Add ## P4 maintainer proof to tests/fixtures/README.md — rollup link + command chain + link-pass scope")
    (step_7 "Set STATUS slice_review_needed; append implementation_handback below"))

  (out_of_scope
    "final_closeout and STATUS closeout_validation (next session after slice 6 review)"
    "PHASE-MAP header refresh (final_closeout or user slice)"
    "router-state.md active_phase / project_complete update"
    "Re-implementing slices 1–5"
    "Editing cursor-landing/cursor-landing/ publishable copies"
    "Committing publishable tree to git unless user explicitly asks")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths + STATUS on implement; PROOF-LOG slice 6 row on review")
    (do_not_write closeout_validation PHASE_MAP_router_state)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **PROOF-LOG.md** | Add **## P4 closeout proof (maintainer)** — table mapping PHASE-MAP P4 outcomes 1–6 → slices 1–5 → evidence (cite rows 1–5; outcome 3 → fixtures § GitHub smoke; outcome 5 → validate-package row + fixtures § validate); **### Re-run commands** (schema + `build-install-bundle.ps1` + `validate-package.py` + link pass scope/result); **### Out of phase map** (scanner, MCP templates, monorepo depth, PRD issues). Do **not** add slice 6 table row until review. |
| **PHASE-BACKLOG.md** | Finalize out-of-map deferrals aligned with SLICE-LIST + PHASE-MAP; note P4 is final mapped phase; **phase_lessons** ≤1 line if warranted. |
| **tests/fixtures/README.md** | Add **## P4 maintainer proof (factory)** — schema + build + validate command chain, P4 link-pass file list, rollup link to PROOF-LOG § P4 closeout proof; point at existing GitHub smoke + validate subsections for detail. |
| **Link pass (verify)** | README, OVERVIEW, CONTEXT, AGENTS.md, `references/install.md`, `references/troubleshooting.md`, `references/annexes/INDEX.md` — record OK or fixes in PROOF-LOG. |
| **Re-run (verify)** | Schema exit 0; build → `cursor-landing/cursor-landing/` (38 files per prior slices); `validate-package.py` exit 0. |
| **Do not** | Edit SKILL, references/ (except README href fix), scripts/, publishable tree, rules, CONTEXT, OVERVIEW, AGENTS, phase-map, router-state, or slice 1–5 product files. |

**After implement:** fresh session → **review the active slice** → slice 6 row in PROOF-LOG → **final_closeout** in a following session → `project_complete`.

## implementation_handback

| Check | Result |
|-------|--------|
| Schema validate | exit 0 (2026-05-24) |
| Build | `scripts\build-install-bundle.ps1` → exit 0, **38** files in `cursor-landing/cursor-landing/` |
| validate-package | `python scripts/validate-package.py` → exit 0 |
| Link pass | 83 relative links in 7 files — zero broken; no README edits |
| `(to add)` in CONTEXT.md | zero (read-only) |
| PROOF-LOG rows 1–5 | unchanged; `passed_closing` |
| Files touched | `PROOF-LOG.md` (§ P4 closeout proof), `PHASE-BACKLOG.md`, `tests/fixtures/README.md` (§ P4 maintainer proof), `STATUS.md` |
| Slice 6 PROOF-LOG row | deferred to review |

**Scope:** allowed paths only; no SKILL, references product bodies, scripts, publishable tree, rules, phase-map, or router-state edits.
