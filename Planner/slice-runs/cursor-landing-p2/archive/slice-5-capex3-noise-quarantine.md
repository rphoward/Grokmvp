# NEXT-SLICE — slice 5 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p2")
  (slice
    (number 5)
    (name capex3-noise-quarantine)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name capex3-noise-quarantine)
    (finish_line "Planner/adopted/README.md and Planner/contracts/archive/README.md clearly quarantine legacy Capex3 material; maintainer intake docs and factory mdc-authoring rule use cursor-landing vocabulary without actionable Capex3 product paths.")
    (distance_closed "Closes P2 ro-5; slice 1 removed capex3 from .mdc globs — this slice fixes remaining maintainer-facing README/tutorial noise and the mdc-authoring section title flagged in slice 1 PROOF-LOG.")
    (required_outcomes (ro-5-capex3-noise-quarantined))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §2 non-goals, §7 layer map, §8 P2"
    "Planner/phase-map/PHASE-MAP.md P2 required_outcomes 5"
    "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md slice 1"
    "Planner/intake/START-HERE.md"
    "Planner/adopted/README.md"
    "Planner/contracts/archive/README.md"
    "Planner/intake/TUTORIAL-planning-cursor-landing.md"
    "Planner/intake/PLANNER-DIRECTION.md"
    ".cursor/rules/cursor-landing-mdc-authoring.mdc")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "adopted_quarantine_readme; archive_quarantine_readme; planner_intake_tutorial; planner_direction_echo; factory_mdc_authoring")
    (layer_ownership
      (concept
        (name adopted_quarantine_readme)
        (owner presentation)
        (path Planner/adopted/README.md)
        (must_not_change "adopted/capex3/ file bodies; no new product work under adopted/; state reference-only + cursor-landing Planner/contracts/ authority"))
      (concept
        (name archive_quarantine_readme)
        (owner presentation)
        (path Planner/contracts/archive/README.md)
        (must_not_change "archive/*.md bodies unless explicit repair slice; historical-only framing; no rental_capex2 or docs/router-planner-contracts/ as active paths for this repo"))
      (concept
        (name planner_intake_tutorial)
        (owner presentation)
        (path Planner/intake/TUTORIAL-planning-cursor-landing.md)
        (must_not_change "Skill factory scope; START-HERE as human entry; no Brief 1–5 paste queue as primary workflow"))
      (concept
        (name planner_direction_echo)
        (owner presentation)
        (path Planner/intake/PLANNER-DIRECTION.md)
        (must_not_change "Standalone_target + seed authority; router flow; out-of-scope adopted/capex3 — edit only if inspect finds actionable Capex3 paths"))
      (concept
        (name factory_mdc_authoring)
        (owner infrastructure)
        (path .cursor/rules/cursor-landing-mdc-authoring.mdc)
        (must_not_change "Factory vs target table; frontmatter rules; rename split-rules heading only — no new globs or always-on rules"))
    (architecture_guardrails
      "Planner/adopted/capex3/ and Planner/contracts/archive/ are reference-only — README quarantine only, not product slices."
      "Active planner contracts for cursor-landing: Planner/contracts/ (filled project_layer_mapping for cursor-landing slug)."
      "No docs/router-planner-contracts/ or C:\\Project\\capex3 paths as actionable maintainer instructions in touched files."
      "TUTORIAL aligns with START-HERE unified planner (one mode per turn) — demote Brief paste workflow."
      "User-facing skill docs (references/, README, OVERVIEW, SKILL) out of scope — capex3 avoid vocabulary in conduct/doc-style is OK.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "Planner/adopted/README.md"
    "Planner/contracts/archive/README.md"
    "Planner/intake/TUTORIAL-planning-cursor-landing.md"
    "Planner/intake/PLANNER-DIRECTION.md"
    ".cursor/rules/cursor-landing-mdc-authoring.mdc"
    "Planner/intake/START-HERE.md"
    "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md slice 1 note"
    ".cursor/MDC-REWRITE-HANDOFF.md § What Capex3 rules got wrong (read-only context)")

  (allowed_changes
    (edit "Planner/adopted/README.md")
    (edit "Planner/contracts/archive/README.md")
    (edit "Planner/intake/TUTORIAL-planning-cursor-landing.md")
    (edit "Planner/intake/PLANNER-DIRECTION.md")
    (edit ".cursor/rules/cursor-landing-mdc-authoring.mdc"))

  (constraints
    (forbidden_edits
      Planner/adopted/capex3/
      Planner/contracts/archive/*.md
      Planner/contracts/codex-router-planner-unified.md
      Planner/slice-runs/
      Planner/phase-map/
      Planner/router-state.md
      Planner/AGENTS.md
      Planner/context-index.md
      SKILL.md
      references/
      assets/conduct.template.mdc
      assets/safety.template.mdc
      README.md
      OVERVIEW.md
      AGENTS.md
      CONTEXT.md
      docs/
      .cursor/MDC-REWRITE-HANDOFF.md
      .cursor/rules/cursor-landing-*.mdc
      tests/
      src/ lib/ apps/ domain/ application/)
    (mdc_authoring_only
      "Edit cursor-landing-mdc-authoring.mdc only among .cursor/rules/ files; rename § Split rules heading to factory-neutral wording; do not touch other six rules.")
    (adopted_readme_edits
      "Rewrite for cursor-landing factory: adopted/ is insurance/reference-only; active contracts live in Planner/contracts/; adopted/capex3/ is frozen backup — do not edit during normal work; remove docs/router-planner-contracts/ and capex3 FILL_* walkthrough as actionable steps; keep one short table of what lives in adopted/capex3/ without inviting edits.")
    (archive_readme_edits
      "Rewrite title/body: historical archive for pre-v4 / Capex3 migration artifacts — not active router for cursor-landing; active contracts = Planner/contracts/README.md + codex-router-planner-unified.md; remove rental_capex2 paths and 'active for capex3 routed work' framing.")
    (tutorial_edits
      "Replace Brief 0–5 paste workflow (Phase C/D/E/F) with START-HERE-aligned steps: grill seed → router-state → create phase map → approve → create slice list → plan/implement/review per STATUS; keep mistakes table row warning against adopted/; demote PLANNER-AGENT-BRIEF to optional shorthand; link START-HERE prominently.")
    (direction_edits
      "Minimal: only if inspect finds actionable Capex3 paths (e.g. strengthen adopted/ reference-only one-liner); do not restructure router flow.")
    (mdc_heading_edits
      "Change 'Split rules like the capex3 handoff pattern' to neutral multi-mdc wording (e.g. 'Split rules (multi-mdc pattern)' with conduct + safety + globs example)."))

  (proof
    (manual
      "Select-String adopted/README.md 'reference-only|reference only|do not edit' → quarantine stated"
      "Select-String adopted/README.md 'docs/router-planner-contracts|docs\\\\router-planner-contracts' → zero matches"
      "Select-String archive/README.md 'historical|archive|not active' → quarantine stated"
      "Select-String archive/README.md 'rental_capex2|active router.*capex3' → zero actionable framing"
      "Select-String TUTORIAL-planning-cursor-landing.md 'Brief [0-9]' → zero primary-workflow Brief paste instructions (anti-Brief OK)"
      "Select-String TUTORIAL-planning-cursor-landing.md 'START-HERE' → unified entry linked"
      "Select-String mdc-authoring.mdc 'capex3' → zero matches"
      "Select-String mdc-authoring.mdc 'multi-mdc|split rules' → neutral heading present"
      "grep -i capex3 Planner/adopted/README.md Planner/contracts/archive/README.md Planner/intake/TUTORIAL-planning-cursor-landing.md Planner/intake/PLANNER-DIRECTION.md .cursor/rules/cursor-landing-mdc-authoring.mdc → only quarantine/warning context, no actionable product paths")
    (record_in "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md")
    (pass_criteria
      "Adopted + archive READMEs quarantine legacy material; tutorial matches START-HERE planner modes; mdc-authoring has no capex3 in heading; no actionable capex3 product paths in touched files; scope limited to allowed_changes."))

  (out_of_scope
    "Editing Planner/adopted/capex3/ file bodies"
    "Editing Planner/contracts/archive/*.md contract bodies"
    "Other .cursor/rules/*.mdc (slice 1 closed)"
    "Handoff docs (slice 4 closed)"
    "Install docs (slice 3 closed)"
    "P2 closeout rollup (slice 6)"
    "Titan dogfood (P3)")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths above; STATUS on review; PROOF-LOG on review")
    (do_not_write PHASE_MAP SLICE_LIST_restructure later_slices)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **Planner/adopted/README.md** | Cursor-landing quarantine: reference-only; `Planner/contracts/` is active; `adopted/capex3/` frozen backup; remove `docs/router-planner-contracts/` and capex3 fill walkthrough as steps agents should run here. |
| **Planner/contracts/archive/README.md** | Historical archive only — not active router for this repo; point active work to `Planner/contracts/`; drop rental_capex2 / capex3-active wording. |
| **TUTORIAL-planning-cursor-landing.md** | Align phases with [START-HERE.md](Planner/intake/START-HERE.md) (one mode per turn); remove Brief 0–5 as primary workflow; keep “don’t plan from adopted/” warning. |
| **PLANNER-DIRECTION.md** | Minimal touch only if actionable Capex3 paths remain after inspect. |
| **cursor-landing-mdc-authoring.mdc** | Rename split-rules § to factory-neutral multi-mdc wording; no `capex3` in file. |
| **Do not** | Edit `adopted/capex3/`, archive contract bodies, other rules, SKILL, references, or run files except STATUS on implement/review. |

**After implement:** fresh session → **review the active slice** → `passed_closing` in PROOF-LOG → STATUS `needs_next_slice_plan` for slice 6.
