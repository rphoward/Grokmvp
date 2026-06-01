# NEXT-SLICE — slice 5 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p1")
  (slice
    (number 5)
    (name forensics-checklist-hosts)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name forensics-checklist-hosts)
    (finish_line "Host annexes link selective forensics research; checklist documents Aider, Continue, and Amazon Q as checklist-only; research uses legacy_host_signals naming; SKILL does not accumulate path dumps.")
    (distance_closed "Closes P1 ro-5 and ro-6; defers new annexes for checklist-only hosts unless a fixture later demands them.")
    (required_outcomes (ro-5-forensics-checklist-hosts ro-6-checklist-only-hosts))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md"
    "Planner/phase-map/PHASE-MAP.md"
    "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md"
    "references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md"
    "references/annexes/INDEX.md"
    "references/scan-checklist.md"
    "references/HOST-EXTENSION.md")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "host_annex_forensics_links; scan_checklist_checklist_only_hosts; forensics_research_legacy_host_signals_rename; skill_phase0_annex_indirection")
    (layer_ownership
      (concept
        (name selective_forensics_by_host)
        (owner domain)
        (must_not_change "scan-report.schema.json; SCAN-REPORT-SCHEMA.md body; per-annex path tables already reviewed May 2026"))
      (concept
        (name checklist_only_host_policy)
        (owner domain)
        (must_not_change "Phase 0 JSON-first emit order; legacy_host_signals in SKILL/schema; emergency handoff from slices 4"))
      (concept
        (name skill_scan_reference_indirection)
        (owner application)
        (must_not_change "Phase 1 grill cap; Phase 2 MDC minimum; Q11/Q12/Q13; Phase 0e run-state excerpts")))
    (architecture_guardrails
      "Link AGENT-FORENSICS-RESEARCH-RESULTS.md from annexes/INDEX/HOST-EXTENSION — do not paste research matrix or signal YAML into SKILL.md."
      "Aider, Continue, Amazon Q stay checklist-only — no new annex files in this slice."
      "Rename primary_host_inference → legacy_host_signals in research docs only; schema/SKILL already use legacy_host_signals."
      "Annex path tables remain authoritative for Scan Report inventory; forensics link is selective cross-reference.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "references/annexes/*.md (each ends with or gains Forensics reference)"
    "references/annexes/INDEX.md"
    "references/scan-checklist.md § Agent surfaces + Run-state"
    "references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md §1–§2 §6 §9"
    "references/research/AGENT-FORENSICS-RESEARCH-PROMPT.md (signal id naming)"
    "SKILL.md § Phase 0 (read only — confirm no path-table bloat before optional one-line pointer)"
    "references/HOST-EXTENSION.md")

  (allowed_changes
    (edit "references/annexes/cursor.md")
    (edit "references/annexes/codex.md")
    (edit "references/annexes/claude.md")
    (edit "references/annexes/gemini.md")
    (edit "references/annexes/copilot.md")
    (edit "references/annexes/cline.md")
    (edit "references/annexes/windsurf.md")
    (edit "references/annexes/kiro.md")
    (edit "references/annexes/augment-intent.md")
    (edit "references/annexes/amp.md")
    (edit "references/annexes/mcp.md")
    (edit "references/annexes/INDEX.md")
    (edit "references/scan-checklist.md")
    (edit "references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md")
    (edit "references/research/AGENT-FORENSICS-RESEARCH-PROMPT.md")
    (edit "references/HOST-EXTENSION.md")
    (edit_optional "SKILL.md"))

  (constraints
    (forbidden_edits
      references/scan-report.schema.json
      references/SCAN-REPORT-SCHEMA.md
      references/MDC-RULES-FORMAT.md
      references/question-bank.md
      references/EMERGENCY-HANDOFF-FORMAT.md
      assets/conduct.template.mdc
      assets/safety.template.mdc
      assets/EMERGENCY-HANDOFF.template.md
      tests/fixtures/
      Planner/
      src/ lib/ apps/ domain/ application/
      factory ".cursor/rules/"
      new_annex_files "references/annexes/aider.md references/annexes/continue.md references/annexes/amazon-q.md")
    (annex_forensics_rule
      "Each host annex (11 files): add short ## Forensics reference linking ../research/AGENT-FORENSICS-RESEARCH-RESULTS.md §1 matrix + §2 signal_id rows for that host; ~3–6 lines; paths stay in annex body above.")
    (index_rule
      "INDEX.md: checklist-only hosts subsection (Aider, Continue, Amazon Q) with paths + link to research; no new annex rows for those three.")
    (checklist_rule
      "scan-checklist.md: tag Continue and Aider bullets checklist-only (no annex); add Amazon Q Developer bullet (rare/internal paths — checklist-only; distinct from Kiro per kiro.md); optional one-line link to research §1–§2.")
    (research_rename_rule
      "AGENT-FORENSICS-RESEARCH-RESULTS.md: replace primary_host_inference with legacy_host_signals in §2.1 heading, §6 emit list, §9 gaps table; add Amazon Q checklist-only note in §1 or checklist-only subsection; do not rewrite whole research corpus.")
    (research_prompt_rule
      "AGENT-FORENSICS-RESEARCH-PROMPT.md: align signal id / field names to legacy_host_signals where still primary_host_inference.")
    (skill_rule
      "SKILL.md edit only if needed: at most one sentence under Phase 0 that scan paths live in checklist + annexes and forensics is linked not pasted; no host path tables added to SKILL.")
    (host_extension_rule
      "HOST-EXTENSION.md: optional one sentence that new hosts may add forensics matrix row later — link research, no path dump in SKILL."))

  (proof
    (manual
      "grep -l 'AGENT-FORENSICS-RESEARCH-RESULTS' references/annexes/*.md | wc -l  (expect 11 host annex files)"
      "grep -E 'checklist-only|Amazon Q' references/scan-checklist.md references/annexes/INDEX.md"
      "grep primary_host_inference references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md  (expect zero or only historical note)"
      "grep legacy_host_signals references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md"
      "Read SKILL.md Phase 0 — no new multi-line path inventory"
      "git diff --name-only — no forbidden paths")
    (record_in "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md")
    (pass_criteria
      "All 11 host annexes link forensics; INDEX lists checklist-only hosts; checklist has Aider/Continue/Amazon Q with checklist-only policy; research uses legacy_host_signals in §2.1/§6/§9; no new annex files; no forbidden edits; SKILL not bloated with path dumps."))

  (out_of_scope
    "New annexes for Aider, Continue, Amazon Q (unless user explicitly requests mid-slice)"
    "scan-report.schema.json / SCAN-REPORT-SCHEMA.md edits"
    "Phase 2 MDC / Q13 / emergency handoff (slices 3–4 closed)"
    "Titan dogfood (P3)"
    "Factory CONTEXT.md '(to add)' (slice 6)"
    "P1 closeout rollup (slice 6)"
    "Full forensics research rewrite or Harnesses synthesis ingest"
    "Editing references/research/Harnesses_*.md")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths above; STATUS on review; PROOF-LOG on review")
    (do_not_write PHASE_MAP SLICE_LIST_restructure later_slices)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **Annexes (×11)** | Append **## Forensics reference** (or equivalent): link [AGENT-FORENSICS-RESEARCH-RESULTS.md](../../../references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md) §1–§2 for that host; keep path tables in annex only. |
| **INDEX.md** | Add **Checklist-only hosts** table: Aider, Continue, Amazon Q — paths, “no annex”, link research + checklist. |
| **scan-checklist.md** | Mark Continue/Aider as checklist-only; add Amazon Q line (rare; not Kiro). |
| **Research RESULTS** | `legacy_host_signals` rename in §2.1, §6, §9; Amazon Q checklist-only note; minimal diff. |
| **Research PROMPT** | Align `primary_host_inference` → `legacy_host_signals` in YAML/examples. |
| **HOST-EXTENSION** | Optional: forensics row step links research (no SKILL paste). |
| **SKILL.md** | Optional single Phase 0 sentence — indirection only if Phase 0 lacks it. |
| **Do not** | New annex files, schema edits, MDC/emergency templates, factory `.cursor/rules/`. |

**After implement:** fresh session **review the active slice** → `passed_closing` in PROOF-LOG → STATUS `needs_next_slice_plan` for slice 6.
