# NEXT-SLICE — slice 4 (archived 2026-05-24, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (slice
    (number 4)
    (name troubleshooting-hosts-coverage)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name troubleshooting-hosts-coverage)
    (finish_line "Factory references/troubleshooting.md documents nested global-install mistake, factory git repo vs ~/.cursor/skills/cursor-landing/, project-local skills paths, and P1 scan-only hosts (Kiro, Augment Intent, Amp) with verify-locally notes and annex links; publishable copy refreshed via build-install-bundle.ps1.")
    (distance_closed "Closes P4 ro-4-troubleshooting-new-hosts after slices 1–3 passed_closing.")
    (required_outcomes (ro-4-troubleshooting-new-hosts))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8"
    "Planner/phase-map/PHASE-MAP.md P4 required_outcomes 4"
    "Planner/slice-runs/cursor-landing-p4/SLICE-LIST.md slice 4"
    "Planner/contracts/codex-router-planner-unified.md project_layer_mapping cursor-landing"
    "references/troubleshooting.md"
    "references/annexes/INDEX.md"
    "references/annexes/kiro.md"
    "references/annexes/augment-intent.md"
    "references/annexes/amp.md")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "support_troubleshooting; host_annex_crosslinks")
    (layer_ownership
      (concept
        (name end_user_troubleshooting_playbook)
        (owner domain)
        (path references/troubleshooting.md)
        (must_not_change "Scan-only for non-Cursor hosts; no annex body merge into SKILL; no MCP auto-merge; factory ≠ publishable install target"))
      (concept
        (name host_scan_reference_annexes)
        (owner domain)
        (path references/annexes/kiro.md references/annexes/augment-intent.md references/annexes/amp.md)
        (must_not_change "Annexes stay inventory-only; path tables authoritative — troubleshooting summarizes and links, does not duplicate full tables"))
      (concept
        (name publishable_support_copy)
        (owner infrastructure)
        (path scripts/build-install-bundle.ps1)
        (must_not_change "troubleshooting.md copied flat to cursor-landing/cursor-landing/ — refresh via build, do not hand-edit publishable tree")))
    (architecture_guardrails
      "Cursor Landing runs only in Cursor Agent on the target repo — troubleshooting must state Kiro/Intent/Amp are Phase 0 inventory only."
      "Verify-locally disclaimers must match annex tone (May 2026 reviewed; paths drift)."
      "Do not instruct users to run /cursor-landing inside Kiro, Intent, or Amp."
      "Distinguish Amazon Kiro from Amazon Q Developer (checklist-only) per INDEX.md."
      "No secrets or MCP server configs in troubleshooting examples.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "references/troubleshooting.md"
    "cursor-landing/cursor-landing/references/troubleshooting.md"
    "references/annexes/INDEX.md"
    "references/annexes/kiro.md"
    "references/annexes/augment-intent.md"
    "references/annexes/amp.md")

  (allowed_changes
    (edit "references/troubleshooting.md — add or expand sections: nested bundle folder, factory vs global vs project skills, scan-only hosts (Kiro, Intent, Amp) with symptom/fix tables and links to annexes + INDEX")
    (run  "scripts/build-install-bundle.ps1 — refresh publishable references/troubleshooting.md")
    (optional_edit "references/annexes/INDEX.md — at most one cross-link sentence to troubleshooting if missing; no annex body rewrites"))

  (constraints
    (forbidden_edits
      SKILL.md
      README.md
      OVERVIEW.md
      references/install.md
      references/scan-checklist.md
      references/scan-report.schema.json
      references/annexes/*.md except optional one-line INDEX cross-link
      references/research/
      AGENTS.md
      CONTEXT.md
      .cursor/
      assets/
      tests/fixtures/*.json
      tests/fixtures/dogfood-notes.md
      scripts/validate-package.py
      Planner/
      install-bundle/
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/)
    (publishable_root "cursor-landing/cursor-landing/")
    (max_new_troubleshooting_sections "Prefer one consolidated ## Other tools (scan only) section over duplicating annex tables"))

  (proof
    (manual
      "Select-String -Path references/troubleshooting.md -Pattern 'cursor-landing/cursor-landing|nested' → present (nested-folder mistake)"
      "Select-String -Path references/troubleshooting.md -Pattern 'factory|~/.cursor/skills/cursor-landing|project-local|\\.cursor/skills' → present (factory vs global vs project install)"
      "Select-String -Path references/troubleshooting.md -Pattern 'Kiro|Augment Intent|Amp|scan only|scan-only' → present for all three hosts"
      "Select-String -Path references/troubleshooting.md -Pattern 'verify locally|Verify locally' → present near host coverage"
      "Select-String -Path references/troubleshooting.md -Pattern 'annexes/kiro|annexes/augment-intent|annexes/amp|annexes/INDEX' → link-out present"
      "Select-String -Path references/troubleshooting.md -Pattern 'token|api[_-]?key|password|secret' -CaseSensitive:$false → no literal secrets")
    (command
      "powershell -ExecutionPolicy Bypass -File scripts\\build-install-bundle.ps1")
    (post_build
      "Select-String -Path cursor-landing/cursor-landing/references/troubleshooting.md -Pattern 'Kiro|Augment Intent|Amp' → present")
    (record_in "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md on review pass")
    (pass_criteria
      "ro-4 PHASE-MAP satisfied; factory + publishable troubleshooting.md aligned after rebuild; existing install/smoke sections unchanged in substance."))

  (implementer_checklist
    (step_1 "Read factory troubleshooting.md — note existing nested-folder and factory-repo rows; avoid duplicate headings")
    (step_2 "Add ## Install path mistakes (or strengthen existing tables) — nested .../cursor-landing/cursor-landing/, opened factory clone instead of target app, project .cursor/skills vs global ~/.cursor/skills/cursor-landing/")
    (step_3 "Add ## Other AI tools in your repo (scan only) — subsections or table rows for Amazon Kiro (.kiro/specs, steering), Augment Intent (.augment/settings), Amp Neo (.amp/plugins, @ampcode/cli migration); each: what Phase 0 does, what skill does NOT do, link to annex, verify locally note")
    (step_4 "Optional: one INDEX.md sentence linking troubleshooting for new users")
    (step_5 "Run build-install-bundle.ps1; diff-check publishable troubleshooting.md")
    (step_6 "Run proof Select-String + build; append implementation_handback; set STATUS slice_review_needed"))

  (out_of_scope
    "validate-package.py (slice 5)"
    "install.md smoke edits (slice 3 closed)"
    "README/OVERVIEW (slice 2 closed)"
    "New annex files or HOST-EXTENSION recipe changes"
    "Annex path table rewrites (inspect-only unless typo blocks link)"
    "PROOF-LOG rollup (slice 6)"
    "Committing publishable tree unless user asks")

  (next_action
    (mode slice_planned)
    (write_only "implementation_handback on complete; STATUS slice_review_needed")
    (do_not_write PROOF_LOG PHASE_MAP)))
```

| Field | Value |
|-------|--------|
| Slice | 4 — `troubleshooting-hosts-coverage` |
| Closes | `ro-4-troubleshooting-new-hosts` |
| Depends | slice 1 `passed_closing` |

## Implementation handback (2026-05-24)

**Files edited:** `references/troubleshooting.md` (§ Install path mistakes, § Other AI tools in your repo (scan only)); `references/annexes/INDEX.md` (one-line link to troubleshooting).

**Rebuild:** `scripts/build-install-bundle.ps1` → 38 files in `cursor-landing/cursor-landing/`; publishable `references/troubleshooting.md` matches factory host coverage.

## Review record (2026-05-24)

**Outcome:** `passed_closing` — closes P4 `ro-4-troubleshooting-new-hosts`.

**Proof:** Factory + publishable `references/troubleshooting.md` SHA256-identical after review rebuild; § Install path mistakes + § Other AI tools (scan only) satisfy PHASE-MAP outcome 4; annex links and verify-locally present; Kiro vs Amazon Q called out; install.md § GitHub smoke unchanged; jsonschema exit 0; build 38 files exit 0; scope limited to troubleshooting + INDEX one-liner.

**Reviewer fix:** Corrected nested-row build link from `../install.md` (missing at repo root) to `install.md` (references/install.md); rebuild applied.

**Reviewer note:** Publishable tree still untracked — commit when ready. Next: plan slice 5 `validate-package-script`.
