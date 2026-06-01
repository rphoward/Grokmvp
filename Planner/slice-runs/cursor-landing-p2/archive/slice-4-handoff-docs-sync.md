# NEXT-SLICE — slice 4 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p2")
  (slice
    (number 4)
    (name handoff-docs-sync)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name handoff-docs-sync)
    (finish_line "references/EMERGENCY-HANDOFF-FORMAT.md, assets/EMERGENCY-HANDOFF.template.md, and docs/SESSION-HANDOFF.md agree with P1 Codex PLANS + Cline memory-bank parity; factory maintainer handoff paths documented separately from target-repo docs/EMERGENCY-HANDOFF.md.")
    (distance_closed "Closes P2 ro-4; P1 slice 4 already wired PLANS/memory-bank into format, template, SKILL Phase 0e, and codex annex — this slice refreshes stale factory SESSION-HANDOFF and confirms install-bundle handoff docs stay aligned.")
    (required_outcomes (ro-4-handoff-docs-current))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §3 emergency handoff"
    "Planner/phase-map/PHASE-MAP.md P2 required_outcomes 4"
    "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md slice 4"
    "Planner/slice-runs/cursor-landing-p1/archive/slice-4-codex-plans-handoff.md"
    "references/EMERGENCY-HANDOFF-FORMAT.md"
    "assets/EMERGENCY-HANDOFF.template.md"
    "docs/SESSION-HANDOFF.md"
    "SKILL.md Phase 0e"
    "references/annexes/codex.md"
    "references/annexes/cline.md")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "emergency_handoff_format; emergency_handoff_template; factory_session_handoff")
    (layer_ownership
      (concept
        (name emergency_handoff_format)
        (owner domain)
        (path references/EMERGENCY-HANDOFF-FORMAT.md)
        (must_not_change "Target-repo path docs/EMERGENCY-HANDOFF.md; §1–§7 section list; git best-effort table; Cline + Codex PLANS §3 parity from P1; no run-state in CONTEXT/AGENTS/rules"))
      (concept
        (name emergency_handoff_template)
        (owner infrastructure)
        (path assets/EMERGENCY-HANDOFF.template.md)
        (must_not_change "Section headings Branch through Resume prompt; HTML comment for Cline/Codex excerpt; written into target repos only"))
      (concept
        (name factory_session_handoff)
        (owner presentation)
        (path docs/SESSION-HANDOFF.md)
        (must_not_change "Factory-only — not install bundle; distinct from skill emergency output; may point at Planner router-state and .cursor/MDC-REWRITE-HANDOFF.md"))
      (concept
        (name skill_phase_0e_emergency)
        (owner application)
        (path SKILL.md)
        (must_not_change "Phase 0e step order; disable-model-invocation; inspect-only unless direct contradiction with format/template")))
    (architecture_guardrails
      "PLANS.md and Cline memory-bank excerpts stay in target docs/EMERGENCY-HANDOFF.md §3 only — never CONTEXT, AGENTS, or always-on .mdc (P1 closed)."
      "EMERGENCY-HANDOFF-FORMAT + template are install-bundle authority for target repos; do not embed factory Planner run state in them."
      "docs/SESSION-HANDOFF.md is factory maintainer transient state — document handoff path table there; do not copy SESSION content into references/ install bundle."
      "SKILL.md Phase 0e already matches P1 — edit only on proven drift; prefer format/template fixes."
      "No capex3 paths in maintainer-facing handoff docs.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "references/EMERGENCY-HANDOFF-FORMAT.md"
    "assets/EMERGENCY-HANDOFF.template.md"
    "docs/SESSION-HANDOFF.md"
    "SKILL.md Phase 0e"
    "references/annexes/codex.md § PLANS.md"
    "references/annexes/cline.md § Memory Bank"
    ".cursor/MDC-REWRITE-HANDOFF.md"
    "CONTEXT.md Emergency handoff row")

  (allowed_changes
    (edit "references/EMERGENCY-HANDOFF-FORMAT.md")
    (edit "assets/EMERGENCY-HANDOFF.template.md")
    (edit "docs/SESSION-HANDOFF.md"))

  (constraints
    (forbidden_edits
      SKILL.md
      references/annexes/
      references/scan-checklist.md
      references/scan-report.schema.json
      references/SCAN-REPORT-SCHEMA.md
      references/install.md
      references/skill-authoring.md
      README.md
      OVERVIEW.md
      AGENTS.md
      CONTEXT.md
      .cursor/
      Planner/
      assets/conduct.template.mdc
      assets/safety.template.mdc
      tests/
      docs/PRD-cursor-landing-v1.md
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/)
    (p1_parity_baseline
      "P1 slice 4 passed: SKILL Phase 0e step 4 (Cline + Codex PLANS); EMERGENCY-HANDOFF-FORMAT §3 dual bullets; template HTML comment; codex annex PLANS § — do not re-edit annexes or SKILL unless inspect finds contradiction.")
    (session_handoff_edits
      "Replace stale 2026-05-20 session snapshot with durable factory handoff guide: purpose (transient, delete after pickup); table of handoff paths (target docs/EMERGENCY-HANDOFF.md vs factory docs/SESSION-HANDOFF.md vs .cursor/MDC-REWRITE-HANDOFF.md vs Planner router-state+STATUS); read order for maintainer sessions; link install bundle handoff docs (format, template, SKILL Phase 0e read-only); current P2 run pointer without copying full run-state into CONTEXT.")
    (format_md_edits
      "Minimal: confirm §3 Cline + Codex PLANS parity text matches template comment and SKILL Phase 0e; fix cross-links if broken; optional one-line pointer that format applies to target repos (factory SESSION is separate — name path only if needed for maintainer clarity without bloating user-facing prose).")
    (template_edits
      "Minimal: ensure comment references EMERGENCY-HANDOFF-FORMAT §3; section list unchanged; resume prompt block unchanged in shape.")
    (skill_read_only
      "Verify Phase 0e step 4 lists Cline memory-bank + Codex PLANS with ~40-line cap and never-promote rule; if drift, fix format/template first — SKILL edit only if format cannot absorb fix."))

  (proof
    (manual
      "Select-String EMERGENCY-HANDOFF-FORMAT.md 'memory-bank|PLANS.md' → Cline + Codex in §3"
      "Select-String EMERGENCY-HANDOFF.template.md 'memory-bank|PLANS' → excerpt hint present"
      "Select-String SKILL.md 'PLANS.md|memory-bank' → Phase 0e parity (read-only verify)"
      "Select-String SESSION-HANDOFF.md 'EMERGENCY-HANDOFF|SESSION-HANDOFF|MDC-REWRITE|router-state' → factory handoff paths documented"
      "Select-String SESSION-HANDOFF.md 'Brief 1|PLANNER-AGENT-BRIEF' → zero stale Brief workflow"
      "Relative link pass: format→template, template comment→format §3, SESSION→format+template+SKILL+Planner paths"
      "grep -i capex3 references/EMERGENCY-HANDOFF-FORMAT.md assets/EMERGENCY-HANDOFF.template.md docs/SESSION-HANDOFF.md → zero actionable paths")
    (record_in "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md")
    (pass_criteria
      "Format + template + SKILL Phase 0e agree on Cline/Codex excerpt parity; SESSION-HANDOFF documents factory vs target handoff paths; no stale Brief workflow; no capex3 leaks; scope limited to allowed_changes."))

  (out_of_scope
    "SKILL.md edits unless inspect proves contradiction"
    "Annex body edits (codex/cline closed in P1)"
    "Install doc alignment (slice 3 closed)"
    "capex3 quarantine (slice 5)"
    "P2 closeout rollup (slice 6)"
    "Titan dogfood (P3)")

  (implementation_handback
    (completed 2026-05-22)
    (files_edited
      docs/SESSION-HANDOFF.md
      references/EMERGENCY-HANDOFF-FORMAT.md
      assets/EMERGENCY-HANDOFF.template.md)
    (files_verified_read_only SKILL.md Phase 0e)
    (proof_run "Select-String parity checks — Cline/Codex in format §3, template comment, SKILL 0e; SESSION path table; zero capex3 in touched files")
    (skill_edits none))

  (next_action
    (mode slice_review_needed)
    (write_only "PROOF-LOG on passed review; STATUS needs_next_slice_plan")
    (do_not_write PHASE_MAP SLICE_LIST_restructure later_slices)))
```

## Review record (2026-05-22)

**Outcome:** `passed_closing` — closes P2 `ro-4-handoff-docs-current`.

**Proof:** Cline + Codex in format §3; template comment + ~40-line cap; SKILL Phase 0e step 4 read-only match; SESSION path table + maintainer read order; anti-Brief guidance only (no stale Brief workflow); zero capex3 in touched files; format→template and SESSION relative links resolve; schema validate exit 0; scope limited to three allowed product paths (+ run files on review).

**After review:** STATUS `needs_next_slice_plan` for slice 5 `capex3-noise-quarantine`.
