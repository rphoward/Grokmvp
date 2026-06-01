# NEXT-SLICE — slice 2 titan-dogfood (archived 2026-05-24, passed_closing)

**Review:** Q14 dual-host — AGENTS.md + GEMINI.md unchanged; CONTEXT + 3× `.mdc` on `C:\Projects\Kbupgrade - Copy (4)` (commit `493f385`).

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p3")
  (slice
    (number 2)
    (name titan-dogfood)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name titan-dogfood)
    (finish_line "Run full /cursor-landing (Phase 0 scan → mini grill → Phase 2 write) on dogfood target with Cursor Agent; durable outputs on target disk only: glossary-only CONTEXT.md, slim AGENTS.md, ≥2 .cursor/rules/*.mdc unless grill Q13 chose one combined conduct rule.")
    (distance_closed "Closes P3 ro-2-titan-dogfood-complete; defers sanitized factory fixtures to slice 3.")
    (required_outcomes (ro-2-titan-dogfood-complete))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §3 dogfood, §12 MDC"
    "Planner/phase-map/PHASE-MAP.md P3 required_outcomes 2"
    "Planner/slice-runs/cursor-landing-p3/SLICE-LIST.md slice 2"
    "SKILL.md Phase 0–2"
    "references/CONTEXT-FORMAT.md references/AGENTS-FORMAT.md references/MDC-RULES-FORMAT.md"
    "assets/conduct.template.mdc assets/safety.template.mdc"
    "tests/fixtures/README.md"
    "CONTEXT.md § Dogfood and proof")

  (run_dir_validation
    (fixture_path "C:\\Projects\\Kbupgrade - Copy (4)")
    (fixture_substitution "Planned Titan path replaced per user 2026-05-23; dogfood run on this repo.")
    (fixture_exists true)
    (pre_dogfood_inventory "User ran /cursor-landing on this path — verify CONTEXT.md, AGENTS.md, .cursor/rules/*.mdc on disk at review")
    (factory_open_in_cursor forbidden_for_phase_2_writes)
    (skill_install "Global ~/.cursor/skills/cursor-landing/ synced 2026-05-23; invoke /cursor-landing in Agent on dogfood target folder"))

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "titan_target_repo_init_outputs; skill_workflow_application")
    (layer_ownership
      (concept
        (name titan_glossary)
        (owner domain)
        (path "C:\\Projects\\Kbupgrade - Copy (4)\\CONTEXT.md")
        (must_not_change "Glossary only per CONTEXT-FORMAT; no proof commands or file trees in CONTEXT"))
      (concept
        (name titan_guardrails)
        (owner application)
        (path "C:\\Projects\\Kbupgrade - Copy (4)\\AGENTS.md")
        (must_not_change "Slim guardrails per AGENTS-FORMAT; read order CONTEXT → AGENTS → rules; proof command from grill Q3"))
      (concept
        (name titan_cursor_rules)
        (owner presentation)
        (path "C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules\\")
        (must_not_change "Default conduct + safety always-on from assets templates unless Q13 one combined; additional rules only from scan proposed_mdc_rules with evidence"))
      (concept
        (name skill_execution)
        (owner application)
        (path SKILL.md)
        (must_not_change "Factory SKILL.md read-only; execute workflow on dogfood target only")))
    (architecture_guardrails
      "All Phase 2 writes on dogfood target path only — zero skill init outputs at factory root C:\\Project\\cursor-landing unless user explicitly requests self-migration."
      "CONTEXT glossary-only; AGENTS slim; rules link CONTEXT — no run-state promotion from memory-bank or PLANS.md."
      "≥2 .mdc files on dogfood target unless Q13 one combined conduct (then 1 always-on acceptable)."
      "MCP inventory only — no merge into target .cursor/mcp.json unless user explicitly requests (Q12)."
      "Scan Report in chat only at Phase 0 — do not write AGENT-INIT-SCAN.md to target unless user asks at Phase 1.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect_first
    "C:\\Projects\\Kbupgrade - Copy (4) (repo root — inspect CONTEXT.md, AGENTS.md, .cursor/rules/)"
    "SKILL.md Phase 0, Phase 1, Phase 2, Rules minimum"
    "references/question-bank.md Q6 Q11 Q12 Q13"
    "git -C C:\\Project\\cursor-landing status (baseline before dogfood)")

  (inspect
    "C:\\Projects\\Kbupgrade - Copy (4)\\CONTEXT.md"
    "C:\\Projects\\Kbupgrade - Copy (4)\\AGENTS.md"
    "C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules\\"
    "SKILL.md")

  (allowed_changes
    (create_or_edit "C:\\Projects\\Kbupgrade - Copy (4)\\CONTEXT.md")
    (create_or_edit "C:\\Projects\\Kbupgrade - Copy (4)\\AGENTS.md")
    (create_or_edit "C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules\\*.mdc")
    (create_dir  "C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules")
    (chat_only   "Scan Report JSON + human summary per SCAN-REPORT-SCHEMA"))

  (constraints
    (forbidden_edits
      "C:\\Project\\cursor-landing\\CONTEXT.md"
      "C:\\Project\\cursor-landing\\AGENTS.md"
      "C:\\Project\\cursor-landing\\.cursor\\"
      "C:\\Project\\cursor-landing\\references\\"
      "C:\\Project\\cursor-landing\\README.md"
      "C:\\Project\\cursor-landing\\OVERVIEW.md"
      "C:\\Project\\cursor-landing\\SKILL.md"
      "C:\\Project\\cursor-landing\\assets\\"
      "C:\\Project\\cursor-landing\\tests\\"
      "C:\\Project\\cursor-landing\\Planner\\"
      "C:\\Project\\cursor-landing\\docs\\EMERGENCY-HANDOFF.md"
      import_dogfood_tree_into_factory
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/)
    (dogfood_rule "Writes only on C:\\Projects\\Kbupgrade - Copy (4); factory tests/fixtures/ is slice 3")
    (q13_default "conduct.template.mdc + safety.template.mdc → 2 always-on .mdc unless user chose one combined at grill")
    (emergency_mode forbidden "Use /cursor-landing initializer only — not emergency"))

  (proof
    (manual
      "(Get-ChildItem 'C:\\Projects\\Kbupgrade - Copy (4)\\.cursor\\rules\\*.mdc').Count → ≥2 OR Q13 one-combined documented in implementation_handback"
      "Test-Path 'C:\\Projects\\Kbupgrade - Copy (4)\\CONTEXT.md' '...\\AGENTS.md' → true"
      "Select-String on target CONTEXT.md -Pattern 'proof command|npm test|pytest' → zero in glossary body (proof belongs in AGENTS)"
      "Select-String on target AGENTS.md 'CONTEXT.md' → read order present"
      "git -C C:\\Project\\cursor-landing status --short → no new CONTEXT/AGENTS/.cursor at factory root from this slice"
      "python schema validate from factory root → exit 0 (unchanged fixture)")
    (record_in "Planner/slice-runs/cursor-landing-p3/PROOF-LOG.md on review")
    (pass_criteria
      "Full initializer run on dogfood target; ro-2 satisfied; factory git clean of skill Phase 2 outputs; Q13 choice recorded if 1 .mdc."))

  (implementer_checklist
    (step_1 "Install skill to ~/.cursor/skills/cursor-landing/ per references/install.md if not already")
    (step_2 "File → Open Folder → C:\\Projects\\Kbupgrade - Copy (4)")
    (step_3 "Agent chat: /cursor-landing — complete Phase 0 (JSON + summary in chat only)")
    (step_4 "Mini grill ≤5; Q6 first only if existing agent files; Q13 when shaping .cursor/rules")
    (step_5 "Phase 2 write order on target: CONTEXT → AGENTS → .cursor/rules → optional CLAUDE.md bridge if scan found Claude files")
    (step_6 "Run proof commands; append implementation_handback to this file; set STATUS slice_review_needed"))

  (out_of_scope
    "tests/fixtures/ dogfood-notes (slice 3)"
    "PROOF-LOG rollup (slice 4)"
    "Factory doc edits"
    "publishable tree P4"
    "validate-package.py")

  (next_action
    (mode slice_planned)
    (write_only "verify dogfood outputs on target path; then slice_review_needed")
    (do_not_write PROOF_LOG PHASE_MAP factory_phase_2_outputs)))
```

**Dogfood target:** `C:\Projects\Kbupgrade - Copy (4)` (substituted for planned Titan path). User already ran `/cursor-landing` here — review verifies outputs on disk.

**Review:** fresh session — *review the active slice*.

## Slice 2 detail (titan-dogfood)

| Requirement | Proof |
|-------------|--------|
| Full init on dogfood target | Scan + grill + Phase 2 complete (already run — verify artifacts) |
| CONTEXT glossary-only | No proof commands or architecture essay in CONTEXT |
| AGENTS slim + proof | Matches AGENTS-FORMAT |
| ≥2 `.mdc` (or Q13 = 1 combined) | Count under `C:\Projects\Kbupgrade - Copy (4)\.cursor\rules\` |
| No factory Phase 2 outputs | `git status` at factory root |
