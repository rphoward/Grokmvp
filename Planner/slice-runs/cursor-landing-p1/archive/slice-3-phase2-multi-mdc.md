# NEXT-SLICE — slice 3 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p1")
  (slice
    (number 3)
    (name phase2-multi-mdc)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name phase2-multi-mdc)
    (finish_line "Phase 2 documents conduct + safety minimum always-on writes, grill Q13 for rules layout, and aligns SKILL with MDC-RULES-FORMAT + templates + cursor annex.")
    (distance_closed "Closes P1 ro-3; target repos get thin conduct.mdc + safety.mdc by default; glob rules only from proposed_mdc_rules.")
    (required_outcomes (ro-3-skill-phase2-multi-mdc))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md"
    "Planner/phase-map/PHASE-MAP.md"
    "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md"
    "references/MDC-RULES-FORMAT.md"
    "references/SCAN-REPORT-SCHEMA.md § proposed_mdc_rules")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "phase2_write_workflow — SKILL Phase 2 MDC minimum; mdc_format_and_templates; cursor_annex_inventory")
    (layer_ownership
      (concept
        (name phase2_mdc_write_order)
        (owner application)
        (must_not_change "Phase 0 read-only; Phase 1 grill cap; Phase 3 verify; scan-report.schema.json"))
      (concept
        (name mdc_rules_format_and_grill_q13)
        (owner domain)
        (must_not_change "proposed_mdc_rules field definitions in schema; Phase 0 emit order"))
      (concept
        (name conduct_safety_templates)
        (owner infrastructure)
        (must_not_change "CONTEXT/AGENTS format docs; emergency handoff assets except cross-links")))
    (architecture_guardrails
      "Phase 2 writes on target repos only during /cursor-landing init; factory skill repo edits are documentation/templates."
      "Minimum always-on: conduct.mdc + thin safety.mdc from assets templates unless Q13 chose one combined conduct rule."
      "Additional rules: glob or agent_request only when Scan Report proposed_mdc_rules has evidence; no invented paths."
      "Q6 applies to existing .cursor/rules before overwrite; Q13 when Phase 2 creates or reshapes rules.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "SKILL.md § Phase 1 and § Phase 2"
    "references/MDC-RULES-FORMAT.md"
    "references/question-bank.md Q13"
    "assets/conduct.template.mdc"
    "assets/safety.template.mdc"
    "references/annexes/cursor.md"
    "references/SCAN-REPORT-SCHEMA.md § proposed_mdc_rules (read only)")

  (allowed_changes
    (edit "SKILL.md")
    (edit "references/MDC-RULES-FORMAT.md")
    (edit "references/question-bank.md")
    (edit "assets/conduct.template.mdc")
    (edit "assets/safety.template.mdc")
    (edit "references/annexes/cursor.md"))

  (constraints
    (forbidden_edits
      references/scan-report.schema.json
      references/SCAN-REPORT-SCHEMA.md
      references/scan-checklist.md
      tests/fixtures/
      Planner/
      src/ lib/ apps/ domain/ application/
      factory ".cursor/rules/ except cross-reference in docs")
    (phase2_minimum_rule
      "Document write order: CONTEXT → AGENTS → .cursor/rules/ with conduct + safety always-on from templates; then optional glob/agent_request from proposed_mdc_rules.")
    (q13_rule
      "SKILL Phase 1 or Phase 2 must reference grill Q13 when .cursor/rules will be created or reshaped (mirror Q11/Q12 pattern).")
    (q13_default
      "Several small always-on (conduct + safety) if user skips; one combined conduct only when Q13 answer says so.")
    (template_rule
      "Templates keep alwaysApply true, link CONTEXT.md and AGENTS.md; safety stays thin (destructive, scope, secrets).")
    (annex_rule
      "cursor.md: Phase 2 minimum .mdc pair + migrate .cursorrules content on merge; do not duplicate full MDC-RULES body."))

  (proof
    (manual
      "grep SKILL.md for Q13, conduct, safety, proposed_mdc_rules"
      "Read SKILL Phase 2: minimum two always-on rules documented unless Q13 combined"
      "Read question-bank Q13 row + MDC-RULES-FORMAT default set alignment"
      "Templates: frontmatter alwaysApply true; CONTEXT/AGENTS links present")
    (record_in "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md")
    (pass_criteria
      "SKILL Phase 2 states conduct+safety minimum and proposed_mdc_rules glob policy; Q13 wired like Q11/Q12; MDC-RULES-FORMAT and templates consistent; cursor annex notes Phase 2 .mdc write."))

  (out_of_scope
    "Codex PLANS handoff (slice 4)"
    "Forensics research rename (slice 5)"
    "Checklist-only hosts (slice 5)"
    "Titan dogfood ≥2 .mdc (P3)"
    "Editing scan-report.schema.json or SCAN-REPORT-SCHEMA.md body"
    "Factory CONTEXT.md '(to add)' wording (slice 6)"
    "Writing factory .cursor/rules beyond doc cross-reference")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths above; STATUS on review; PROOF-LOG on review")
    (do_not_write PHASE_MAP SLICE_LIST_restructure later_slices)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **SKILL.md § Phase 2** | Expand Rules row: write order (CONTEXT → AGENTS → rules); **minimum** `conduct.mdc` + `safety.mdc` from templates; glob/agent_request only from `proposed_mdc_rules`; no mega always-on unless Q13 combined. |
| **SKILL.md grill** | Add **Q13** when Phase 2 will create/reshape `.cursor/rules/` (same style as Q11/Q12 lines). |
| **question-bank.md** | Ensure Q13 row ties to Phase 2 minimum set and MDC-RULES-FORMAT § default rule set (light touch if already aligned). |
| **MDC-RULES-FORMAT.md** | Cross-link SKILL Phase 2 write order if drift; keep anti-hallucination and Q13 minimal/thorough table. |
| **assets/*.mdc** | Verify `alwaysApply`, descriptions, CONTEXT/AGENTS links match format doc. |
| **cursor.md** | Add Phase 2 note: prefer `.mdc`, conduct+safety minimum, merge legacy `.cursorrules` per Q6 — scan-only annex stays inventory-focused. |
| **Do not** | Change schema, SCAN-REPORT-SCHEMA body, scan-checklist, Planner product code trees. |

**After implement:** fresh session **review the active slice** → `passed_closing` in PROOF-LOG → STATUS `needs_next_slice_plan` for slice 4.
