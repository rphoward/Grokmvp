# SLICE-LIST — cursor-landing-p3

Phase **P3 — Dogfood & fixtures**. Authority: [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) deferred order 3, [SPEC-SEED](../../intake/SPEC-SEED-cursor-landing.md) §7–§8.

```lisp
(extraction_slice_list
  (run_dir "Planner/slice-runs/cursor-landing-p3")
  (phase "P3 — Dogfood & fixtures")
  (project_shape multi_phase)
  (source_packet "Planner/intake/SPEC-SEED-cursor-landing.md")
  (prior_closeout "Planner/slice-runs/cursor-landing-p2/STATUS.md — final_closeout 2026-05-22; phase_sealed")

  (goal
    (finish_line "Close P3: install/skills docs accurate; Titan dogfood proves ≥2 .mdc + CONTEXT/AGENTS on fixture; factory tests/fixtures/ holds sanitized examples only.")
    (done_proof "Three implementation slices + closeout prep in PROOF-LOG with passed_closing or passed_with_debt; PHASE-MAP P3 outcomes 1–4 satisfied.")
    (slice_count 4)
    (required_outcomes
      (ro-1-install-skills-docs-aligned)
      (ro-2-titan-dogfood-complete)
      (ro-3-fixtures-sanitized)
      (ro-4-maintainer-proof-note))
    (optional_deferred_outcomes
      (publishable-tree-scaffold "P4 — cursor-landing/cursor-landing/")
      (validate-package-py "P4 after P3 Titan pass"))
    (non_negotiable_user_intent
      "Skill-only factory; dogfood writes on target path only (C:\\Projects\\Kbupgrade - Copy (4)); no dogfood tree import into factory; ≥2 .mdc on fixture unless user chose one combined rule (Q13); CONTEXT glossary only on targets; no MCP auto-merge."))

  (constraints
    (layer_mapping "SPEC-SEED §7 — references/ domain, SKILL.md application, assets/ scripts/ infrastructure, README OVERVIEW presentation, tests/fixtures/ infrastructure")
    (forbidden_edits src lib apps domain application)
    (forbidden_planner_adopted "Planner/adopted/capex3/ — reference-only unless explicit fix")
    (dogfood_rule "Slice 2 writes only on C:\\Projects\\Kbupgrade - Copy (4) (substituted for planned Titan); factory root must not receive skill Phase 2 outputs except deliberate self-migration")
    (canonical_skills_url "https://cursor.com/docs/skills — sole Cursor Skills doc URL in touched install/README/skill-authoring paths")
    (proof_style "Titan path checklist + schema validate + link pass; record in PROOF-LOG.md per slice"))

  (slices
    (slice
      (number 1)
      (name install-skills-docs-align)
      (slice_type standard)
      (status passed_closing)
      (reviewed 2026-05-23)
      (depends none)
      (archive "Planner/slice-runs/cursor-landing-p3/archive/slice-1-install-skills-docs-align.md")
      (inspect
        "references/install.md"
        "README.md setup section"
        "OVERVIEW.md install mentions"
        "references/skill-authoring.md"
        "references/troubleshooting.md"
        "references/annexes/cursor.md")
      (done
        "Canonical Skills URL https://cursor.com/docs/skills everywhere this slice touches; install.md documents project install under .cursor/skills/ and .agents/skills/; install.md + README state factory repo root is not the install bundle (copy to ~/.cursor/skills/cursor-landing/ or project skills path); short note that skills use paths in frontmatter while target .mdc rules use globs; README/install state opening the factory repo does not auto-load the skill")
      (required_outcomes (ro-1-install-skills-docs-aligned)))

    (slice
      (number 2)
      (name titan-dogfood)
      (slice_type standard)
      (status passed_closing)
      (reviewed 2026-05-24)
      (depends 1)
      (archive "Planner/slice-runs/cursor-landing-p3/archive/slice-2-titan-dogfood.md")
      (inspect
        "C:\\Projects\\Kbupgrade - Copy (4)"
        "SKILL.md Phase 0–2")
      (fixture_substitution "Planned Titan → Kbupgrade - Copy (4) per user 2026-05-23")
      (done
        "Q14 dual-host: /cursor-landing on Kbupgrade - Copy (4); CONTEXT glossary-only; AGENTS.md + GEMINI.md left for Antigravity; conduct + safety + kb-pipeline.mdc; proof in conduct.mdc; factory root clean")
      (required_outcomes (ro-2-titan-dogfood-complete)))

    (slice
      (number 3)
      (name fixtures-sanitize-sync)
      (slice_type standard)
      (status passed_closing)
      (reviewed 2026-05-24)
      (depends 2)
      (archive "Planner/slice-runs/cursor-landing-p3/archive/slice-3-fixtures-sanitize-sync.md")
      (inspect
        "tests/fixtures/README.md"
        "tests/fixtures/scan-report-example.json"
        "tests/fixtures/dogfood-notes.md")
      (done
        "dogfood-notes.md + P3 README; fictional scan-report-example.json; schema exit 0; no Kbupgrade import")
      (required_outcomes (ro-3-fixtures-sanitized)))

    (slice
      (number 4)
      (name p3-proof-and-closeout-prep)
      (slice_type standard)
      (status passed_closing)
      (reviewed 2026-05-24)
      (depends 1 2 3)
      (archive "Planner/slice-runs/cursor-landing-p3/archive/slice-4-p3-proof-and-closeout-prep.md")
      (inspect
        "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md"
        "tests/fixtures/README.md"
        "Planner/slice-runs/cursor-landing-p3/PHASE-BACKLOG.md")
      (done
        "PROOF-LOG complete for slices 1–3; P3 outcomes 1–4 trace table; link/schema pass noted; P4 deferrals in PHASE-BACKLOG; fixtures README P3 subsection")
      (required_outcomes (ro-4-maintainer-proof-note)))

  (next_action
    (mode complete)
    (active_slice none)
    (active_slice_file none)
    (next_phase_run_dir "Planner/slice-runs/cursor-landing-p4/")
    (all_slices_passed true)
    (closeout 2026-05-24)
    (slice_list_approved 2026-05-23)))
```

| # | Slice | Closes |
|---|--------|--------|
| 1 | install-skills-docs-align | PHASE-MAP P3 ro-1 — docs before dogfood |
| 2 | titan-dogfood | ro-2 — ≥2 `.mdc` + CONTEXT/AGENTS on `C:\Projects\Kbupgrade - Copy (4)` |
| 3 | fixtures-sanitize-sync | ro-3 — sanitized `tests/fixtures/` |
| 4 | p3-proof-and-closeout-prep | ro-4 + P3 proof rollup |

## Slice 1 detail (install-skills-docs-align)

Before Titan dogfood, align user-facing install docs:

| Requirement | Target files (typical) |
|-------------|------------------------|
| One canonical Skills URL: `https://cursor.com/docs/skills` | `install.md`, `README.md`, `skill-authoring.md`, `troubleshooting.md`, `annexes/cursor.md` — replace `https://cursor.com/docs/context/skills` if present |
| Project install: `.cursor/skills/` **and** `.agents/skills/` | `install.md` Team share / project-local section |
| Factory root ≠ install bundle; copy to `~/.cursor/skills/cursor-landing/` (or project skills path) | `install.md`, `README.md` Setup |
| Skills `paths` in frontmatter vs target `.mdc` `globs` — do not mix | Short note in `install.md` and/or `README.md` Setup |
| Opening factory repo does **not** auto-load skill; install globally or project skills path | `install.md`, `README.md` |
