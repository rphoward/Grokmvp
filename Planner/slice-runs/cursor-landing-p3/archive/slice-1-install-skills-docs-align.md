# NEXT-SLICE — slice 1 (archived 2026-05-23, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p3")
  (slice
    (number 1)
    (name install-skills-docs-align)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name install-skills-docs-align)
    (finish_line "User-facing install paths document canonical Cursor Skills URL, global vs project skill paths, factory root ≠ install bundle, skills frontmatter paths vs target .mdc globs, and that opening the factory repo does not auto-load the skill.")
    (distance_closed "Closes P3 ro-1-install-skills-docs-aligned before Titan dogfood.")
    (required_outcomes (ro-1-install-skills-docs-aligned))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8"
    "Planner/phase-map/PHASE-MAP.md P3 required_outcomes 1"
    "Planner/slice-runs/cursor-landing-p3/SLICE-LIST.md slice 1"
    "references/install.md"
    "README.md Setup"
    "OVERVIEW.md How it works"
    "references/skill-authoring.md"
    "references/troubleshooting.md"
    "references/annexes/cursor.md")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "install_docs; user_onboarding_readme; overview_install; skill_authoring_maintainer; cursor_annex_scan")
    (layer_ownership
      (concept
        (name install_and_skills_guidance)
        (owner domain)
        (path references/install.md)
        (must_not_change "Canonical Skills doc URL; bundle file list; factory-only exclusions; Cursor-only invoke gate"))
      (concept
        (name end_user_setup_copy)
        (owner presentation)
        (path README.md OVERVIEW.md)
        (must_not_change "Emergency section; four-step setup flow shape; link to install.md as authority for bundle list"))
      (concept
        (name maintainer_skill_packaging)
        (owner domain)
        (path references/skill-authoring.md)
        (must_not_change "disable-model-invocation; install bundle table; SKILL.md frontmatter rules"))
      (concept
        (name cursor_host_inventory)
        (owner domain)
        (path references/annexes/cursor.md)
        (must_not_change "Scan-only scope; skills/rules path table; compatibility paths listed not ranked")))
    (architecture_guardrails
      "Canonical Cursor Skills URL https://cursor.com/docs/skills in every file this slice touches that links Skills docs."
      "Factory git root is maintainer workspace — not the user install bundle; copy to ~/.cursor/skills/cursor-landing/ or project skills path."
      "Skills optional frontmatter paths ≠ target repo .mdc globs — do not instruct users to put globs in SKILL.md."
      "disable-model-invocation: opening factory repo does not auto-run skill; user installs globally or project-local."
      "No edits to SKILL.md workflow, annex bodies beyond cursor.md Skills link, research/, tests/, Planner/, .cursor/.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "references/install.md"
    "README.md"
    "OVERVIEW.md"
    "references/skill-authoring.md"
    "references/troubleshooting.md"
    "references/annexes/cursor.md")

  (allowed_changes
    (edit "references/install.md")
    (edit "README.md")
    (edit "OVERVIEW.md")
    (edit "references/skill-authoring.md")
    (edit "references/troubleshooting.md")
    (edit "references/annexes/cursor.md"))

  (constraints
    (forbidden_edits
      SKILL.md
      references/annexes/ except cursor.md
      references/research/
      references/MDC-RULES-FORMAT.md
      references/scan-checklist.md
      references/scan-report.schema.json
      AGENTS.md
      CONTEXT.md
      .cursor/
      assets/
      scripts/
      tests/
      Planner/
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/)
    (canonical_skills_url "https://cursor.com/docs/skills")
    (replace_legacy_url "https://cursor.com/docs/context/skills → canonical in touched files only"))

  (proof
    (manual
      "Select-String -Path references/install.md,README.md,OVERVIEW.md,references/skill-authoring.md,references/troubleshooting.md,references/annexes/cursor.md -Pattern 'context/skills' → zero"
      "Select-String -Path (same) -Pattern 'cursor.com/docs/skills' → at least one per file that links Skills docs"
      "Select-String references/install.md '.agents/skills' → present"
      "Select-String references/install.md,README.md -Pattern 'auto-load|does not load' → factory-open note present"
      "Select-String references/install.md,README.md -Pattern 'globs|frontmatter' → paths-vs-globs note present")
    (record_in "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md on review pass")
    (pass_criteria
      "All six inspect paths updated; ro-1 checklist in SLICE-LIST satisfied; no forbidden paths edited."))

  (out_of_scope
    "Titan dogfood (slice 2)"
    "tests/fixtures (slice 3)"
    "PROOF-LOG rollup (slice 4)"
    "references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md"
    "Factory .mdc rules")

  (implementation_handback
    (completed 2026-05-23)
    (files_edited
      references/install.md
      README.md
      OVERVIEW.md
      references/skill-authoring.md
      references/troubleshooting.md
      references/annexes/cursor.md)
    (proof_run
      "Zero context/skills in six touched paths; canonical docs/skills in install, README, OVERVIEW, skill-authoring, cursor annex; .agents/skills + paths-vs-globs + factory auto-load notes present; schema validate exit 0"))

  (next_action
    (mode slice_review_needed)
    (write_only "PROOF-LOG on passed review; STATUS needs_next_slice_plan for slice 2")
    (do_not_write PHASE_MAP)))
```

## Review record (2026-05-23)

**Outcome:** `passed_closing` — closes P3 `ro-1-install-skills-docs-aligned`.

**Proof:** Zero `context/skills` in six touched paths; canonical `cursor.com/docs/skills` in install, README, OVERVIEW, skill-authoring, cursor annex; `.cursor/` + `.agents/` project paths in install + README + troubleshooting; factory ≠ bundle + no auto-load in install, README, OVERVIEW, troubleshooting; paths vs `globs` in install, README, OVERVIEW; install→annexes/cursor.md link OK; schema validate exit 0; git diff limited to six allowed product paths (+ run files); SKILL.md / research / Planner / `.cursor/` untouched.

**After review:** STATUS `needs_next_slice_plan` for slice 2 `titan-dogfood`.
