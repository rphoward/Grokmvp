# SLICE-LIST — cursor-landing-p2

Phase **P2 — Maintainer ergonomics**. Authority: [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) deferred order 2, [SPEC-SEED](../../intake/SPEC-SEED-cursor-landing.md) §7–§8.

```lisp
(extraction_slice_list
  (run_dir "Planner/slice-runs/cursor-landing-p2")
  (phase "P2 — Maintainer ergonomics")
  (project_shape multi_phase)
  (source_packet "Planner/intake/SPEC-SEED-cursor-landing.md")
  (prior_closeout "Planner/slice-runs/cursor-landing-p1/STATUS.md — final_closeout 2026-05-22; phase_sealed")

  (goal
    (finish_line "Close P2: factory maintainer paths ergonomic — .cursor/rules, CONTEXT/AGENTS, install/handoff docs aligned; capex3/adopted noise quarantined.")
    (done_proof "Five implementation slices + closeout prep in PROOF-LOG with passed_closing or passed_with_debt; PHASE-MAP P2 outcomes 1–6 satisfied.")
    (slice_count 6)
    (required_outcomes
      (ro-1-factory-mdc-rules-aligned)
      (ro-2-root-agents-context-aligned)
      (ro-3-install-readme-aligned)
      (ro-4-handoff-docs-current)
      (ro-5-capex3-noise-quarantined)
      (ro-6-maintainer-proof-note))
    (optional_deferred_outcomes
      (publishable-tree-scaffold "P4 — cursor-landing/cursor-landing/ not created in P2")
      (titan-dogfood-≥2-mdc "P3")
      (validate-package-py "P4"))
    (non_negotiable_user_intent
      "Skill-only factory; maintainer .cursor/rules model target-repo pattern; CONTEXT glossary only; no src/ lib/ apps/; Planner/adopted/capex3/ reference-only; no MCP auto-merge."))

  (constraints
    (layer_mapping "SPEC-SEED §7 — references/ domain, SKILL.md application, assets/ scripts/ infrastructure, README OVERVIEW presentation, .cursor/rules/ factory maintainer only")
    (forbidden_edits src lib apps domain application)
    (forbidden_planner_adopted "Planner/adopted/capex3/ — no product slices; quarantine/README only unless explicit reference fix")
    (dogfood_rule "No Titan writes in P2; dogfood remains P3")
    (proof_style "manual link pass + grep for capex3 path leaks; record in PROOF-LOG.md per slice"))

  (slices
    (slice
      (number 1)
      (name factory-mdc-rules-align)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        ".cursor/rules/cursor-landing-*.mdc"
        ".cursor/MDC-REWRITE-HANDOFF.md"
        "references/MDC-RULES-FORMAT.md"
        "SKILL.md Phase 2 section")
      (done "Seven factory rules align with P1 multi-mdc baseline; always-on conduct+safety; no capex3 paths or src/ globs; MDC-REWRITE-HANDOFF current")
      (required_outcomes (ro-1-factory-mdc-rules-aligned)))

    (slice
      (number 2)
      (name root-agents-context)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "AGENTS.md"
        "CONTEXT.md"
        "Planner/AGENTS.md"
        "references/AGENTS-FORMAT.md"
        "references/CONTEXT-FORMAT.md")
      (done "Root AGENTS.md exists: slim guardrails, proof command, defers Planner-routed work to Planner/AGENTS.md; factory CONTEXT P2 labels current; no run-state in CONTEXT")
      (required_outcomes (ro-2-root-agents-context-aligned)))

    (slice
      (number 3)
      (name install-readme-align)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "references/install.md"
        "references/skill-authoring.md"
        "README.md setup section"
        "OVERVIEW.md")
      (done "Install doc + README setup agree on global ~/.cursor/skills/ path, bundle file list, factory-only exclusions; troubleshooting link resolves")
      (required_outcomes (ro-3-install-readme-aligned)))

    (slice
      (number 4)
      (name handoff-docs-sync)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "assets/EMERGENCY-HANDOFF.template.md"
        "references/EMERGENCY-HANDOFF-FORMAT.md"
        "docs/SESSION-HANDOFF.md"
        "SKILL.md Phase 0e")
      (done "Emergency template/format/SESSION-HANDOFF consistent with P1 Codex PLANS + Cline memory-bank parity; factory maintainer handoff paths documented")
      (required_outcomes (ro-4-handoff-docs-current)))

    (slice
      (number 5)
      (name capex3-noise-quarantine)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect
        "Planner/adopted/README.md"
        "Planner/contracts/archive/README.md"
        "Planner/intake/TUTORIAL-planning-cursor-landing.md"
        "Planner/intake/PLANNER-DIRECTION.md"
        ".cursor/rules/cursor-landing-mdc-authoring.mdc")
      (done "adopted/ and archive READMEs state reference-only; no actionable capex3 paths in maintainer-facing docs; mdc-authoring uses factory-neutral split-rule wording")
      (required_outcomes (ro-5-capex3-noise-quarantined)))

    (slice
      (number 6)
      (name p2-proof-and-closeout-prep)
      (slice_type standard)
      (status passed_closing)
      (depends 1 2 3 4 5)
      (inspect "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md" "references/ and README links")
      (done "PROOF-LOG complete for slices 1–5; P2 outcomes 1–6 trace table; link pass noted; P3/P4 deferrals recorded in PHASE-BACKLOG")
      (required_outcomes (ro-6-maintainer-proof-note)))

  (next_action
    (mode complete)
    (active_slice none)
    (active_slice_file none)
    (all_slices_passed true)
    (closeout final_closeout_passed 2026-05-22)
    (outer_phase_state phase_sealed)
    (next_run_dir "Planner/slice-runs/cursor-landing-p3/")))
```

| # | Slice | Closes |
|---|--------|--------|
| 1 | factory-mdc-rules-align | PHASE-MAP P2 ro-1 |
| 2 | root-agents-context | ro-2 |
| 3 | install-readme-align | ro-3 |
| 4 | handoff-docs-sync | ro-4 |
| 5 | capex3-noise-quarantine | ro-5 |
| 6 | p2-proof-and-closeout-prep | ro-6 + P2 proof rollup |
