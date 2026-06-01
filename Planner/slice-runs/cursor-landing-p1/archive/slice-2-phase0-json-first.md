# NEXT-SLICE — slice 2 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p1")
  (slice
    (number 2)
    (name phase0-json-first)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name phase0-json-first)
    (finish_line "Phase 0 instructions require a machine JSON Scan Report block before human summary bullets; checklist uses legacy_host_signals and schema path.")
    (distance_closed "Closes P1 ro-2; agents can emit slice-1 schema in the prescribed order.")
    (required_outcomes (ro-2-phase0-json-first))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md"
    "Planner/phase-map/PHASE-MAP.md"
    "references/SCAN-REPORT-SCHEMA.md"
    "references/scan-report.schema.json"
    "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "phase0_scan_workflow — SKILL Phase 0 emit order; checklist Scan Report shape")
    (layer_ownership
      (concept
        (name phase0_emit_order)
        (owner application)
        (must_not_change "Phase 1–3 workflow; Phase 2 write rules; scan-report.schema.json field definitions"))
      (concept
        (name scan_checklist_report_shape)
        (owner domain)
        (must_not_change "Annex detection paths; slice-1 schema required properties")))
    (architecture_guardrails
      "Phase 0 remains read-only on target repos; chat-first; no repo writes."
      "JSON block must reference references/scan-report.schema.json and use legacy_host_signals not primary_host_inference."
      "Human bullets remain authoritative for wording; JSON is machine-first companion per SCAN-REPORT-SCHEMA.md.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "SKILL.md § Phase 0"
    "references/scan-checklist.md § Scan Report shape and § Health"
    "references/SCAN-REPORT-SCHEMA.md (emit order cross-check)"
    "references/scan-report.schema.json"
    "CONTEXT.md § Scan Report JSON (read only — still says schema to add)")

  (allowed_changes
    (edit "SKILL.md")
    (edit "references/scan-checklist.md"))

  (constraints
    (forbidden_edits
      references/scan-report.schema.json
      references/SCAN-REPORT-SCHEMA.md
      assets/
      tests/fixtures/
      Planner/
      src/ lib/ apps/ domain/ application/)
    (emit_order_rule
      "Phase 0 output order: (1) fenced ```json block with schema_version 2.0, valid against scan-report.schema.json; (2) human summary per SCAN-REPORT-SCHEMA.md sections.")
    (field_name_rule
      "Checklist and SKILL must say legacy_host_signals; do not reintroduce primary_host_inference in Phase 0 instructions.")
    (json_block_rule
      "Instruct agent to validate JSON mentally or with schema; optional cite tests/fixtures/scan-report-example.json as shape reference only — do not require writing fixture in target repos."))

  (proof
    (manual
      "rg -n \"json|JSON|legacy_host_signals|scan-report.schema\" SKILL.md references/scan-checklist.md"
      "Read SKILL Phase 0: machine JSON before human bullets is explicit.")
    (record_in "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md")
    (pass_criteria
      "SKILL Phase 0 documents JSON-first emit + schema path; checklist Scan Report shape matches; Health line uses legacy_host_signals."))

  (out_of_scope
    "SKILL Phase 2 multi-mdc (slice 3)"
    "Editing scan-report.schema.json or SCAN-REPORT-SCHEMA.md body"
    "Factory CONTEXT.md schema '(to add)' wording (slice 6 or maintainer pass)"
    "Titan dogfood"
    "Renaming forensics research primary_host_inference (slice 5)")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths above; STATUS on review; PROOF-LOG on review")
    (do_not_write PHASE_MAP SLICE_LIST_restructure later_slices)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **SKILL.md § Phase 0** | Add emit order: JSON block first (fenced `json`, `schema_version` `"2.0"`, validate against [scan-report.schema.json](../../references/scan-report.schema.json)), then human summary per [SCAN-REPORT-SCHEMA.md](../../references/SCAN-REPORT-SCHEMA.md). Keep chat-only / no target writes. |
| **scan-checklist.md** | § Scan Report shape: JSON-first + link schema; field list uses `legacy_host_signals`; optional pointer to factory example fixture for maintainers only. |
| **scan-checklist.md § Health** | Rename “Primary host inference” → legacy host signals (research §2.1). |
| **Do not** | Change schema file, human spec, Phase 2 table, or assets. |

**After implement:** fresh session **review the active slice** → `passed_closing` in PROOF-LOG → STATUS `needs_next_slice_plan` for slice 3.
