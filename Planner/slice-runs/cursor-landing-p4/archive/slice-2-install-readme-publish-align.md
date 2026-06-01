# NEXT-SLICE — slice 2 (archived 2026-05-24, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (slice
    (number 2)
    (name install-readme-publish-align)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name install-readme-publish-align)
    (finish_line "Factory and publishable README, OVERVIEW, and install.md agree: clone factory → scripts/build-install-bundle.ps1 → scripts/sync-global-skill-install.ps1 → flat ~/.cursor/skills/cursor-landing/; factory root ≠ install bundle; canonical Cursor Skills URL; no install-bundle/ as install target.")
    (distance_closed "Closes P4 ro-2-readme-overview-install-accurate after slice 1 publishable-tree-scaffold.")
    (required_outcomes (ro-2-readme-overview-install-accurate))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8"
    "Planner/phase-map/PHASE-MAP.md P4 required_outcomes 2"
    "Planner/slice-runs/cursor-landing-p4/SLICE-LIST.md slice 2"
    "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md slice 1 reviewer_note"
    "scripts/build-install-bundle.ps1"
    "scripts/sync-global-skill-install.ps1"
    "cursor-landing/cursor-landing/BUNDLE-MANIFEST.md")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "install_docs; user_onboarding_readme; overview_publish_path; publishable_tree_sync")
    (layer_ownership
      (concept
        (name install_and_publish_guidance)
        (owner domain)
        (path references/install.md)
        (must_not_change "Canonical Skills URL; factory-only exclusions; flat global install; Cursor-only invoke gate"))
      (concept
        (name end_user_setup_copy)
        (owner presentation)
        (path README.md OVERVIEW.md)
        (must_not_change "Emergency section; four-step setup shape; install.md as authority for bundle list and exclusions"))
      (concept
        (name publishable_tree_build)
        (owner infrastructure)
        (path scripts/build-install-bundle.ps1 scripts/sync-global-skill-install.ps1)
        (must_not_change "Output only cursor-landing/cursor-landing/; install.md bundle patches in build script remain authoritative for publishable install copy")))
    (architecture_guardrails
      "Canonical Cursor Skills URL https://cursor.com/docs/skills in every touched file that links Skills docs."
      "Factory git root is maintainer workspace — not the user install bundle; publishable tree is cursor-landing/cursor-landing/ only."
      "No install-bundle/ as build output or copy target — cite install-bundle/DEPRECATED.md only if explaining legacy path."
      "Publishable copies must be regenerated via build-install-bundle.ps1 after factory doc edits — do not hand-edit publishable tree without rebuilding."
      "No edits to SKILL.md workflow, annex bodies, research/, tests/, Planner/, .cursor/, factory CONTEXT.md/AGENTS.md.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "README.md"
    "OVERVIEW.md"
    "references/install.md"
    "cursor-landing/cursor-landing/README.md"
    "cursor-landing/cursor-landing/OVERVIEW.md"
    "cursor-landing/cursor-landing/references/install.md"
    "cursor-landing/cursor-landing/BUNDLE-MANIFEST.md")

  (allowed_changes
    (edit "README.md")
    (edit "OVERVIEW.md")
    (edit "references/install.md")
    (run  "scripts/build-install-bundle.ps1 — regenerates cursor-landing/cursor-landing/ presentation + domain install copies")
    (optional_edit "scripts/build-install-bundle.ps1 — only if install.md README/OVERVIEW bundle patches need adjustment after factory copy changes"))

  (constraints
    (forbidden_edits
      SKILL.md
      references/annexes/
      references/research/
      references/scan-checklist.md
      references/scan-report.schema.json
      references/skill-authoring.md
      AGENTS.md
      CONTEXT.md
      .cursor/
      assets/
      tests/
      Planner/
      install-bundle/ except read DEPRECATED.md for wording
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/)
    (canonical_skills_url "https://cursor.com/docs/skills")
    (publishable_root "cursor-landing/cursor-landing/"))

  (proof
    (manual
      "Select-String -Path README.md,OVERVIEW.md,references/install.md,cursor-landing/cursor-landing/README.md,cursor-landing/cursor-landing/OVERVIEW.md,cursor-landing/cursor-landing/references/install.md -Pattern 'install-bundle/' → zero as install target (DEPRECATED mention in factory install optional if zero)"
      "Select-String -Path (same factory trio) -Pattern 'build-install-bundle|sync-global-skill-install|cursor-landing/cursor-landing' → present in install.md and README Setup"
      "Select-String -Path (same six paths) -Pattern 'cursor.com/docs/skills' → at least one per file that links Skills docs"
      "Select-String factory README,OVERVIEW,install -Pattern 'factory.*not.*bundle|not the install bundle' → present"
      "powershell -ExecutionPolicy Bypass -File scripts\\build-install-bundle.ps1 → exit 0; publishable install.md opens with bundle intro not factory-only paragraph")
    (command
      "python -c \"import json,jsonschema; jsonschema.validate(json.load(open('cursor-landing/cursor-landing/references/examples/scan-report-example.json')), json.load(open('cursor-landing/cursor-landing/references/scan-report.schema.json')))\"")
    (record_in "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md on review pass")
    (pass_criteria
      "Six inspect paths aligned; ro-2 PHASE-MAP checklist satisfied; rebuild run recorded in implementation_handback."))

  (implementer_checklist
    (step_1 "Edit factory references/install.md — remove install-bundle/ target; document cursor-landing/cursor-landing/ + build + sync from repo root")
    (step_2 "Edit factory README.md Setup and OVERVIEW.md Install — clone → build → sync; keep factory ≠ bundle and no auto-load notes")
    (step_3 "Run scripts/build-install-bundle.ps1; verify publishable README/OVERVIEW/install match factory intent")
    (step_4 "Run proof Select-String + jsonschema; append implementation_handback; set STATUS slice_review_needed"))

  (out_of_scope
    "GitHub install smoke narrative (slice 3)"
    "troubleshooting.md host coverage (slice 4)"
    "validate-package.py (slice 5)"
    "PROOF-LOG rollup (slice 6)"
    "Committing publishable tree to git unless user asks")

  (next_action
    (mode slice_planned)
    (write_only "implementation_handback on complete; STATUS slice_review_needed")
    (do_not_write PROOF_LOG PHASE_MAP)))
```

## Implementation handback (2026-05-24)

**Files edited:** `references/install.md`, `README.md`, `OVERVIEW.md`, `scripts/build-install-bundle.ps1` (bundle patches: install.md, README.md, OVERVIEW.md for publishable tree).

**Rebuild:** `scripts/build-install-bundle.ps1` → 38 files in `cursor-landing/cursor-landing/`.

**Proof run:**
- `install-bundle/` only in factory `references/install.md` (deprecated note); zero in publishable six-path set.
- Factory README/OVERVIEW/install: `build-install-bundle`, `sync-global-skill-install`, `cursor-landing/cursor-landing`, factory ≠ bundle.
- Publishable install/README/OVERVIEW: bundle copy steps only (no factory `build-install-bundle` in publishable presentation files).
- jsonschema on publishable example exit 0.

## Review record (2026-05-24)

**Outcome:** `passed_closing` — closes P4 `ro-2-readme-overview-install-accurate`.

**Proof:** Factory install/README/OVERVIEW document `cursor-landing/cursor-landing/` + build/sync; publishable trio bundle-copy only (no `install-bundle/` target, no `build-install-bundle` in publishable README/OVERVIEW); canonical Skills URL in all six inspect paths; rebuild exit 0; publishable jsonschema exit 0; `scripts/build-install-bundle.ps1` bundle patches for install + README + OVERVIEW.

**Reviewer note:** Factory `references/install.md` retains deprecated `install-bundle/` mention only. Publishable tree still untracked in git until user commits. Slice 3: GitHub install smoke in `install.md` or fixtures README.
