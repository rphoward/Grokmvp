# SLICE-LIST — cursor-landing-p1

Phase **P1 — Research integration**. Authority: [PHASE-MAP.md](../../phase-map/PHASE-MAP.md), [SPEC-SEED](../../intake/SPEC-SEED-cursor-landing.md) §7 layer mapping.

```lisp
(extraction_slice_list
  (run_dir "Planner/slice-runs/cursor-landing-p1")
  (phase "P1 — Research integration")
  (project_shape multi_phase)
  (source_packet "Planner/intake/SPEC-SEED-cursor-landing.md")
  (prior_closeout none)

  (goal
    (finish_line "Close P1: scan JSON schema + human spec, JSON-first Phase 0, Phase 2 multi-mdc, Codex PLANS handoff, forensics links, checklist-only hosts.")
    (done_proof "Six slices in PROOF-LOG with passed_closing or passed_with_debt; PHASE-MAP outcomes 1–7 satisfied; Titan ≥2 .mdc proof explicitly deferred to P3.")
    (slice_count 6)
    (required_outcomes
      (ro-1-scan-report-json-and-spec)
      (ro-2-phase0-json-first)
      (ro-3-skill-phase2-multi-mdc)
      (ro-4-codex-plans-handoff)
      (ro-5-forensics-checklist-hosts)
      (ro-7-maintainer-proof-note))
    (optional_deferred_outcomes
      (titan-dogfood-≥2-mdc "P3 entry; not P1 closeout gate")
      (validate-package-py "P4 after Titan"))
    (non_negotiable_user_intent
      "Skill-only factory; CONTEXT glossary on targets; MDC conduct+safety minimum; no src/ lib/ apps/; no MCP auto-merge; no capex3 product work."))

  (constraints
    (layer_mapping "SPEC-SEED §7 — references/ domain, SKILL.md application, assets/ scripts/ infrastructure, README OVERVIEW presentation")
    (forbidden_edits src lib apps domain application)
    (forbidden_planner_adopted "Planner/adopted/capex3/ except explicit reference fix")
    (dogfood_rule "≥2 .mdc on fixture: deferred to P3 Titan run; P1 slices use schema validate + link pass only")
    (proof_style "manual; record in PROOF-LOG.md per slice"))

  (slices
    (slice
      (number 1)
      (name scan-report-json-and-spec)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "references/scan-report.schema.json"
        "references/SCAN-REPORT-SCHEMA.md"
        "tests/fixtures/ (example JSON if added)")
      (done "Schema validates example; legacy_host_signals field; human spec § proposed_mdc_rules with activation + rationale")
      (required_outcomes (ro-1-scan-report-json-and-spec)))

    (slice
      (number 2)
      (name phase0-json-first)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect "SKILL.md" "references/scan-checklist.md")
      (done "Phase 0 JSON-first emit + checklist legacy_host_signals; PROOF-LOG slice 2")
      (required_outcomes (ro-2-phase0-json-first)))

    (slice
      (number 3)
      (name phase2-multi-mdc)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect
        "SKILL.md"
        "references/MDC-RULES-FORMAT.md"
        "references/question-bank.md"
        "assets/conduct.template.mdc"
        "assets/safety.template.mdc"
        "references/annexes/cursor.md")
      (done "Phase 2 writes conduct + safety minimum; Q13 documented; templates and format aligned")
      (required_outcomes (ro-3-skill-phase2-multi-mdc)))

    (slice
      (number 4)
      (name codex-plans-handoff)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "references/annexes/codex.md"
        "SKILL.md"
        "assets/ or docs emergency handoff references")
      (done "Codex PLANS.md excerpt pattern documented for emergency handoff (Cline memory-bank parity intent)")
      (required_outcomes (ro-4-codex-plans-handoff)))

    (slice
      (number 5)
      (name forensics-checklist-hosts)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "references/annexes/*.md"
        "references/scan-checklist.md"
        "references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md")
      (done "Annexes link forensics without path dumps in SKILL; Aider Continue Amazon Q checklist-only")
      (required_outcomes (ro-5-forensics-checklist-hosts)))

    (slice
      (number 6)
      (name p1-proof-and-closeout-prep)
      (slice_type standard)
      (status passed_closing)
      (depends 1 2 3 4 5)
      (inspect "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md" "references/ links")
      (done "PROOF-LOG complete for slices 1–5; link pass noted; Titan dogfood explicitly deferred to P3 in list constraints")
      (required_outcomes (ro-7-maintainer-proof-note)))

  (next_action
    (mode complete)
    (active_slice none)
    (all_slices_passed true)
    (phase_closeout 2026-05-22)
    (do_not_write PHASE_MAP)))
```

| # | Slice | Closes |
|---|--------|--------|
| 1 | scan-report-json-and-spec | PHASE-MAP ro-1 |
| 2 | phase0-json-first | ro-2 |
| 3 | phase2-multi-mdc | ro-3 ✓ |
| 4 | codex-plans-handoff | ro-4 ✓ |
| 5 | forensics-checklist-hosts | ro-5, ro-6 |
| 6 | p1-proof-and-closeout-prep | ro-7 + P1 proof rollup |
