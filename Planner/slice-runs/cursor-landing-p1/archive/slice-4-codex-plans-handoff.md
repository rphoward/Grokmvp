# NEXT-SLICE — slice 4 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p1")
  (slice
    (number 4)
    (name codex-plans-handoff)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name codex-plans-handoff)
    (finish_line "Codex PLANS.md run-state is documented for emergency handoff with Cline memory-bank parity: annex path, SKILL Phase 0e steps, EMERGENCY-HANDOFF-FORMAT §3, and template hint.")
    (distance_closed "Closes P1 ro-4; agents excerpt PLANS.md into docs/EMERGENCY-HANDOFF.md when scan finds it — never into CONTEXT or always-on rules.")
    (required_outcomes (ro-4-codex-plans-handoff))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md"
    "Planner/phase-map/PHASE-MAP.md"
    "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md"
    "references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md §8"
    "references/annexes/cline.md § Memory Bank")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "codex_annex_emergency_source; emergency_handoff_format; skill_phase_0e_emergency")
    (layer_ownership
      (concept
        (name codex_plans_handoff_pattern)
        (owner domain)
        (must_not_change "scan-report.schema.json; SCAN-REPORT-SCHEMA body; Phase 2 MDC minimum from slice 3"))
      (concept
        (name emergency_phase_0e_workflow)
        (owner application)
        (must_not_change "Phase 0 read-only scan order; Phase 1 grill cap; Phase 2 init writes; Q11/Q12/Q13 wiring"))
      (concept
        (name emergency_handoff_template_assets)
        (owner infrastructure)
        (must_not_change "conduct/safety templates; CONTEXT/AGENTS format bodies except cross-links")))
    (architecture_guardrails
      "PLANS.md is run-state: excerpt into docs/EMERGENCY-HANDOFF.md only (mirror Cline activeContext/progress)."
      "Do not promote PLANS.md into CONTEXT.md, AGENTS.md, or always-on .mdc."
      "Emergency mode does not rewrite full AGENTS for handoff; git best-effort unchanged."
      "Factory edits are reference docs + SKILL emergency section + handoff format/template only.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "references/annexes/codex.md § Emergency handoff"
    "SKILL.md § Emergency — Phase 0e"
    "references/EMERGENCY-HANDOFF-FORMAT.md §3 Current task"
    "assets/EMERGENCY-HANDOFF.template.md"
    "references/scan-checklist.md line Codex PLANS.md (read only — align wording, do not restructure checklist)"
    "references/annexes/cline.md § Memory Bank (parity reference only)")

  (allowed_changes
    (edit "references/annexes/codex.md")
    (edit "SKILL.md")
    (edit "references/EMERGENCY-HANDOFF-FORMAT.md")
    (edit "assets/EMERGENCY-HANDOFF.template.md"))

  (constraints
    (forbidden_edits
      references/scan-report.schema.json
      references/SCAN-REPORT-SCHEMA.md
      references/scan-checklist.md
      references/MDC-RULES-FORMAT.md
      references/question-bank.md
      assets/conduct.template.mdc
      assets/safety.template.mdc
      tests/fixtures/
      Planner/
      src/ lib/ apps/ domain/ application/
      factory ".cursor/rules/"
      references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md
      references/research/AGENT-FORENSICS-RESEARCH-PROMPT.md)
    (plans_excerpt_rule
      "When repo root or scan inventory includes PLANS.md: read file if present; excerpt relevant sections into EMERGENCY-HANDOFF §3 Current task (or labeled subsection); cap length (~40 lines); say unknown if missing.")
    (parity_rule
      "Mirror Cline memory-bank pattern: scan flags run-state; emergency captures; grill Q11 unchanged; no new grill question for PLANS unless already in bank.")
    (skill_emergency_rule
      "SKILL Phase 0e step list adds Codex PLANS bullet after Cline cross-ref or in emergency block — same prominence as memory-bank note in EMERGENCY-HANDOFF-FORMAT.")
    (annex_rule
      "codex.md: document typical PLANS.md path(s), run-state role, excerpt targets (task, blockers, next steps); link EMERGENCY-HANDOFF-FORMAT; do not paste full forensics §8.")
    (template_rule
      "Optional HTML comment or one-line hint under Current task in template — no new mandatory sections that break existing handoffs."))

  (proof
    (manual
      "grep -E 'PLANS|Codex' SKILL.md references/annexes/codex.md references/EMERGENCY-HANDOFF-FORMAT.md"
      "Read codex annex: PLANS.md path + emergency excerpt instruction + not CONTEXT/AGENTS"
      "Read EMERGENCY-HANDOFF-FORMAT §3: Cline + Codex PLANS parity"
      "Template: handoff still has Branch through Resume prompt; Codex hint present if added")
    (record_in "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md")
    (pass_criteria
      "SKILL emergency references PLANS.md when scanned; codex annex documents excerpt pattern; EMERGENCY-HANDOFF-FORMAT §3 names Codex PLANS like Cline memory-bank; no PLANS promotion to CONTEXT/AGENTS/rules; no forbidden edits."))

  (out_of_scope
    "Forensics research file renames or body edits (slice 5)"
    "Checklist host rows beyond read-only alignment check (slice 5)"
    "scan-report.schema.json / SCAN-REPORT-SCHEMA.md"
    "Phase 2 MDC / Q13 (slice 3 closed)"
    "Titan dogfood (P3)"
    "Factory CONTEXT.md '(to add)' (slice 6)"
    "New grill question for PLANS"
    "Editing cline.md unless one cross-link sentence")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths above; STATUS on review; PROOF-LOG on review")
    (do_not_write PHASE_MAP SLICE_LIST_restructure later_slices)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **codex.md** | Expand § Emergency handoff: `PLANS.md` location(s), run-state role, what to excerpt into `docs/EMERGENCY-HANDOFF.md` §3, explicit **do not** copy into CONTEXT/AGENTS/`.mdc`. |
| **EMERGENCY-HANDOFF-FORMAT.md** | §3 Current task: add Codex `PLANS.md` bullet parallel to Cline `memory-bank/` (excerpt if present; not in CONTEXT/rules). |
| **SKILL.md § Emergency** | After scan/git steps: when scan found `PLANS.md`, excerpt per format doc; never promote to persistent agent files. |
| **EMERGENCY-HANDOFF.template.md** | Optional one-line comment under `## Current task` pointing Codex users at PLANS excerpt — keep section list stable. |
| **Parity** | Match Cline intent from [cline.md](../../../references/annexes/cline.md) and forensics §8 table (read only). |
| **Do not** | Edit schema, SCAN-REPORT-SCHEMA, scan-checklist body, MDC templates, research markdown, Planner beyond run files on review. |

**After implement:** fresh session **review the active slice** → `passed_closing` in PROOF-LOG → STATUS `needs_next_slice_plan` for slice 5.
