# NEXT-SLICE — slice 6 (archived 2026-05-22, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p2")
  (slice
    (number 6)
    (name p2-proof-and-closeout-prep)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name p2-proof-and-closeout-prep)
    (finish_line "P2 maintainer proof rollup in PROOF-LOG traces PHASE-MAP outcomes 1–6 to slices 1–5; link pass recorded; P3/P4 deferrals finalized in PHASE-BACKLOG; fixtures README carries P2 proof subsection; ready for final_closeout.")
    (distance_closed "Closes ro-6; last implementation slice before final_closeout. Does not run Titan dogfood, publish scaffold, or re-edit slices 1–5 product files.")
    (required_outcomes (ro-6-maintainer-proof-note))
    (optional_deferred_outcomes
      (publishable-tree-scaffold "P4 — document in PHASE-BACKLOG; not created here")
      (titan-dogfood-≥2-mdc "P3 — document deferral in rollup; not re-run in this slice")
      (validate-package-py "P4 after Titan")))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §8 P2"
    "Planner/phase-map/PHASE-MAP.md P2 required_outcomes 1–6"
    "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md rows 1–5"
    "Planner/slice-runs/cursor-landing-p2/PHASE-BACKLOG.md"
    "Planner/slice-runs/cursor-landing-p1/PROOF-LOG.md § P1 closeout proof (pattern)"
    "tests/fixtures/README.md § P1 maintainer proof (pattern)"
    "AGENTS.md proof command")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "p2_proof_log_rollup; phase_backlog_finalize; p2_fixtures_proof_note; maintainer_link_pass")
    (layer_ownership
      (concept
        (name p2_proof_log_rollup)
        (owner presentation)
        (path Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md)
        (must_not_change "Rows 1–5 proof text; add § P2 closeout proof trace table + re-run commands + deferrals; slice 6 table row added on review only"))
      (concept
        (name phase_backlog_finalize)
        (owner presentation)
        (path Planner/slice-runs/cursor-landing-p2/PHASE-BACKLOG.md)
        (must_not_change "P3/P4 deferred phases from PHASE-MAP; carry P1 deferrals; remove draft framing; no new product scope"))
      (concept
        (name p2_fixtures_proof_note)
        (owner infrastructure)
        (path tests/fixtures/README.md)
        (must_not_change "Add P2 subsection mirroring P1; schema command + link pass scope + P2 rollup link; Titan remains P3"))
      (concept
        (name maintainer_link_pass)
        (owner presentation)
        (path README.md)
        (must_not_change "Verify-only unless broken relative href; fix README links only if pass finds breakage; no copy/tone edits"))
    (architecture_guardrails
      "Closeout prep only — no SKILL, references product bodies, .cursor/rules, or adopted/capex3 edits."
      "PROOF-LOG rows 1–5 already passed_closing — rollup traces them; do not rewrite slice proof rows."
      "Link pass documents scope and result in PROOF-LOG § P2 closeout proof; references/ read-only unless README fix requires no reference edit."
      "PHASE-BACKLOG finalizes deferrals already named in SLICE-LIST optional_deferred_outcomes and PHASE-MAP deferred_phases."
      "final_closeout (separate mode) writes STATUS closeout_validation — not this slice.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md"
    "Planner/slice-runs/cursor-landing-p2/PHASE-BACKLOG.md"
    "Planner/phase-map/PHASE-MAP.md P2 required_outcomes 1–6"
    "Planner/slice-runs/cursor-landing-p2/SLICE-LIST.md"
    "tests/fixtures/README.md"
    "AGENTS.md"
    "README.md"
    "OVERVIEW.md"
    "CONTEXT.md"
    "references/install.md"
    "references/troubleshooting.md"
    "references/annexes/INDEX.md")

  (allowed_changes
    (edit "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md")
    (edit "Planner/slice-runs/cursor-landing-p2/PHASE-BACKLOG.md")
    (edit "tests/fixtures/README.md")
    (edit "README.md" "relative link targets only if link pass finds broken href"))

  (constraints
    (forbidden_edits
      SKILL.md
      references/
      assets/
      .cursor/rules/
      Planner/adopted/
      Planner/contracts/
      Planner/phase-map/
      Planner/router-state.md
      Planner/AGENTS.md
      Planner/context-index.md
      AGENTS.md
      CONTEXT.md
      OVERVIEW.md
      docs/
      src/ lib/ apps/ domain/ application/)
    (proof_log_edits
      "Append ## P2 closeout proof (maintainer) with outcome 1–6 → slice → evidence table; ### Re-run commands; ### Deferred to later factory phases. Do not add slice 6 table row until review.")
    (phase_backlog_edits
      "Drop (draft) title; confirm P3/P4 run dirs; table carried P1 deferrals; optional phase_lessons one line max if closeout note warrants.")
    (fixtures_readme_edits
      "Add ## P2 maintainer proof (factory — not Titan) after P1 section: schema command, P2 link pass scope (include AGENTS.md), rollup link to P2 PROOF-LOG § P2 closeout proof, Titan/P4 deferrals echo.")
    (link_pass_scope
      "Relative href verify: README, OVERVIEW, CONTEXT, AGENTS.md, references/install.md, references/troubleshooting.md, references/annexes/INDEX.md — read-only except README broken-target fix.")
    (run_state_on_implement
      "Update STATUS.md to slice_review_needed only among Planner/slice-runs/ files besides allowed_changes."))

  (proof
    (manual
      "PROOF-LOG rows 1–5 status passed_closing"
      "PROOF-LOG § P2 closeout proof table maps outcomes 1–6 to slices 1–5"
      "python schema validate → exit 0"
      "Link pass recorded in PROOF-LOG re-run table; broken href count zero or README-only fixes listed"
      "grep '(to add)' CONTEXT.md → zero (read-only verify)"
      "PHASE-BACKLOG: P3 + P4 deferred phases present; no (draft) in title"
      "tests/fixtures/README.md has P2 maintainer proof subsection")
    (record_in "Planner/slice-runs/cursor-landing-p2/PROOF-LOG.md slice 6 row on review")
    (pass_criteria
      "P2 outcomes 1–6 traced to slices 1–5 in PROOF-LOG; link pass documented; P3/P4 deferrals in PHASE-BACKLOG; fixtures README P2 subsection; scope limited to allowed_changes; ready for final_closeout after review."))

  (out_of_scope
    "final_closeout and STATUS closeout_validation block (next session after slice 6 review)"
    "PHASE-MAP header refresh (final_closeout or user slice)"
    "router-state.md active_phase update"
    "Titan dogfood (P3)"
    "Publishable tree scaffold (P4)"
    "Re-implementing slices 1–5")

  (next_action
    (mode implement_slice)
    (write_only "allowed_changes paths + STATUS on implement/review; PROOF-LOG slice 6 row on review")
    (do_not_write closeout_validation PHASE_MAP_router_state)))
```

## Implementer checklist

| Task | Detail |
|------|--------|
| **PROOF-LOG.md** | Add **## P2 closeout proof (maintainer)** — table mapping PHASE-MAP P2 outcomes 1–6 → slices 1–5 → evidence (cite existing PROOF-LOG rows); **### Re-run commands** (schema + link pass scope/result); **### Deferred to later factory phases** (P3 Titan, P4 publish/validate). Do **not** add slice 6 table row until review. |
| **PHASE-BACKLOG.md** | Finalize: remove `(draft)`; keep P3/P4 deferred phases table; P1 carried deferrals; align with SLICE-LIST `optional_deferred_outcomes`. |
| **tests/fixtures/README.md** | Add **## P2 maintainer proof** subsection (schema command, P2 link pass file list incl. `AGENTS.md`, pointer to P2 PROOF-LOG rollup, Titan→P3 note). |
| **README.md** | Only if link pass finds broken relative `href` — fix target path; no other edits. |
| **Link pass (verify)** | README, OVERVIEW, CONTEXT, AGENTS.md, `references/install.md`, `references/troubleshooting.md`, `references/annexes/INDEX.md` — record OK or fixes in PROOF-LOG. |
| **Do not** | Edit SKILL, references/, rules, CONTEXT, OVERVIEW, AGENTS, phase-map, router-state, or slice 1–5 product files. |

**After implement:** fresh session → **review the active slice** → slice 6 row in PROOF-LOG → **final_closeout** in a following session.
