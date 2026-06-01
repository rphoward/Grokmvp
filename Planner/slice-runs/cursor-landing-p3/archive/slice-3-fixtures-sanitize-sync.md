# NEXT-SLICE — slice 3 fixtures-sanitize-sync (archived 2026-05-24, passed_closing)

**Review:** schema exit 0; `dogfood-notes.md` + P3 README; fictional JSON only; git scope `tests/fixtures/`; closes ro-3.

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p3")
  (slice
    (number 3)
    (name fixtures-sanitize-sync)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name fixtures-sanitize-sync)
    (finish_line "Factory tests/fixtures/ holds a schema-valid sanitized Scan Report example, P3 dogfood notes (no secrets, no repo import), and README that documents the actual P3 dogfood path and proof commands.")
    (distance_closed "Closes P3 ro-3-fixtures-sanitized; defers PROOF-LOG rollup and P3 outcome trace table to slice 4.")
    (required_outcomes (ro-3-fixtures-sanitized))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8"
    "Planner/phase-map/PHASE-MAP.md P3 required_outcomes 3"
    "Planner/slice-runs/cursor-landing-p3/SLICE-LIST.md slice 3"
    "Planner/slice-runs/cursor-landing-p3/archive/slice-2-titan-dogfood.md"
    "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md slice 2 row"
    "references/scan-report.schema.json references/SCAN-REPORT-SCHEMA.md"
    "SKILL.md Phase 0 JSON-first (fixture is maintainer example only)"
    "tests/fixtures/README.md")

  (run_dir_validation
    (dogfood_path "C:\\Projects\\Kbupgrade - Copy (4)")
    (dogfood_read_only true)
    (factory_writes_only tests/fixtures/)
    (no_import_rule "Do not copy Kbupgrade tree or Scan Report from dogfood disk into factory"))

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes maintainer_fixtures_infrastructure)
    (layer_ownership
      (concept
        (name scan_report_fixture)
        (owner infrastructure)
        (path tests/fixtures/scan-report-example.json)
        (must_not_change "Fictional paths only (fictional-app/); no real dogfood paths or secrets; must validate against references/scan-report.schema.json"))
      (concept
        (name dogfood_evidence_notes)
        (owner infrastructure)
        (path tests/fixtures/dogfood-notes.md)
        (must_not_change "Summary of what P3 dogfood proved; cite external path; no API keys, tokens, or full file dumps"))
      (concept
        (name fixtures_readme)
        (owner infrastructure)
        (path tests/fixtures/README.md)
        (must_not_change "Documents sanitized fixture policy, schema command, P3 dogfood path (Kbupgrade), Titan as superseded/planned reference only")))
    (architecture_guardrails
      "Factory-only writes under tests/fixtures/ — zero Phase 2 skill outputs on C:\\Projects\\Kbupgrade - Copy (4) in this slice."
      "scan-report-example.json teaches dual-host Q14 pattern (conversion_plan leaves AGENTS/GEMINI; proposed_mdc_rules with extract_from) using fictional layout — not a dump of the dogfood repo."
      "Do not edit references/scan-report.schema.json unless schema validate fails and the failure is a real schema bug (escalate in implementation_handback; prefer fixing example JSON to match authoritative schema)."
      "CONTEXT glossary-only and AGENTS/GEMINI on dogfood target are slice 2 outcomes — cite in notes, do not re-init dogfood.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect_first
    "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md (slice 2 passed_closing)"
    "Planner/slice-runs/cursor-landing-p3/archive/slice-2-titan-dogfood.md"
    "tests/fixtures/scan-report-example.json vs references/scan-report.schema.json"
    "tests/fixtures/README.md"
    "Optional read-only: Get-ChildItem 'C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules\\*.mdc' -Name (for dogfood-notes filenames only)")

  (inspect
    "tests/fixtures/README.md"
    "tests/fixtures/scan-report-example.json"
    "references/scan-report.schema.json"
    "references/SCAN-REPORT-SCHEMA.md (proposed_mdc_rules shape only)")

  (allowed_changes
    (create_or_edit "tests/fixtures/README.md")
    (create_or_edit "tests/fixtures/scan-report-example.json")
    (create        "tests/fixtures/dogfood-notes.md"))

  (constraints
    (forbidden_edits
      "C:\\Projects\\Kbupgrade - Copy (4)\\"
      "C:\\Project\\cursor-landing\\references\\"
      "C:\\Project\\cursor-landing\\SKILL.md"
      "C:\\Project\\cursor-landing\\README.md"
      "C:\\Project\\cursor-landing\\OVERVIEW.md"
      "C:\\Project\\cursor-landing\\assets\\"
      "C:\\Project\\cursor-landing\\install-bundle\\"
      "C:\\Project\\cursor-landing\\Planner\\"
      "C:\\Project\\cursor-landing\\.cursor\\"
      import_dogfood_tree_into_factory
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/))

  (proof
    (command
      "python -c \"import json,jsonschema; jsonschema.validate(json.load(open('tests/fixtures/scan-report-example.json')), json.load(open('references/scan-report.schema.json')))\""
      "Expect exit code 0 from repo root.")
    (manual
      "Test-Path tests/fixtures/dogfood-notes.md → true"
      "dogfood-notes.md cites C:\\Projects\\Kbupgrade - Copy (4), Q14 dual-host, ≥2 .mdc (record count 3: conduct, safety, kb-pipeline), CONTEXT glossary-only — no secrets"
      "Select-String -Path tests/fixtures/* -Pattern 'sk-[a-zA-Z0-9]{10,}|api[_-]?key|password\\s*=|Bearer\\s+' -SimpleMatch → zero hits (adjust pattern if false positive on docs)"
      "README.md under tests/fixtures/ has P3 subsection: actual dogfood path, link to dogfood-notes.md, schema command, no-import rule"
      "scan-report-example.json uses fictional-app/ paths only; includes proposed_mdc_rules + dual-host conversion_plan note")
    (record_in "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md on review")
    (pass_criteria "ro-3 satisfied; factory git diff limited to tests/fixtures/ for this slice."))

  (implementer_checklist
    (step_1 "Read slice 2 PROOF-LOG + archive; confirm dogfood artifacts still on Kbupgrade path (read-only)")
    (step_2 "Align scan-report-example.json with references/scan-report.schema.json (dual-host teaching example; fictional paths)")
    (step_3 "Create tests/fixtures/dogfood-notes.md — what P3 dogfood proved, paths, rule filenames, Q14 choice; no secrets")
    (step_4 "Update tests/fixtures/README.md — P3 dogfood path (Kbupgrade), P3 proof subsection, link dogfood-notes; Titan path historical only")
    (step_5 "Run schema validate command; append implementation_handback below; set STATUS slice_review_needed"))

  (out_of_scope
    "install-bundle/ sync (P4 or separate maintainer pass)"
    "PROOF-LOG rollup and P3 trace table (slice 4)"
    "references/ or SKILL.md edits unless schema bug proven"
    "Dogfood target writes"
    "publishable tree scaffold")

  (next_action
    (mode slice_planned)
    (write_only "implement tests/fixtures/ then slice_review_needed")
    (do_not_write PROOF_LOG PHASE_MAP dogfood_target_files)))

```

**Router:** `slice_planned` — fresh session: *implement the active slice*.

**Review:** fresh session — *review the active slice*.

## Slice 3 detail (fixtures-sanitize-sync)

| Requirement | Target |
|-------------|--------|
| Sanitized schema-valid example | `tests/fixtures/scan-report-example.json` — fictional `fictional-app/` layout; `legacy_host_signals`, `proposed_mdc_rules` (incl. `extract_from`), dual-host `conversion_plan` |
| Dogfood notes (no import) | `tests/fixtures/dogfood-notes.md` — cite `C:\Projects\Kbupgrade - Copy (4)`; summarize slice 2 proof (Q14, 3× `.mdc`, CONTEXT glossary-only); no tokens or env values |
| README P3 section | `tests/fixtures/README.md` — Kbupgrade as P3 dogfood path; Titan superseded; schema command; link to notes |
| Schema proof | AGENTS.md python one-liner → exit `0` |
| No factory import | No copy of Kbupgrade tree; no new files outside `tests/fixtures/` |

## implementation_handback

**Date:** 2026-05-24 · **Scope:** `tests/fixtures/` only

| Deliverable | Action |
|-------------|--------|
| `dogfood-notes.md` | Created — Kbupgrade path, Q14, 3× `.mdc` names, CONTEXT glossary-only, no secrets |
| `README.md` | P3 section first; Kbupgrade authoritative; Titan superseded; links dogfood-notes; schema command |
| `scan-report-example.json` | `scan_date` 2026-05-24; added `gemini` host surface for dual-host teaching; fictional paths only |

**Proof run:** schema validate exit `0`. Dogfood `.mdc` on disk (read-only): `conduct.mdc`, `safety.mdc`, `kb-pipeline.mdc`.

**Not touched:** `references/`, `install-bundle/`, dogfood target, `Planner/` (except STATUS handback), factory root skill outputs.

**Review:** fresh session — *review the active slice*.
