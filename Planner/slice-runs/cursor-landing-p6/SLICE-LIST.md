# SLICE-LIST — cursor-landing-p6

Phase **P6 — Idempotent Phase 2 (re-init safe)**.

**Authority:** [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) P6 · [HANDOFF-idempotent-phase2-planner-seed.md](../../intake/HANDOFF-idempotent-phase2-planner-seed.md) · P5 closeout unchanged · [dual-publish architecture](../../../.cursor/plans/dual-publish-architecture.md) (Lisp ship only).

```lisp
(extraction_slice_list
  (run_dir "Planner/slice-runs/cursor-landing-p6")
  (phase "P6 — Idempotent Phase 2 (re-init safe)")
  (project_shape multi_phase)
  (source_packet "Planner/intake/HANDOFF-idempotent-phase2-planner-seed.md")
  (prior_closeout "Planner/slice-runs/cursor-landing-p5/STATUS.md — final_closeout 2026-05-26; project_complete for P1–P5")

  (goal
    (finish_line "Re-running /cursor-landing Phase 2 on an already-inited target does not duplicate Cursor Landing baseline in .cursorindexingignore or dual-host .cursorignore template paths; first-time init unchanged; trim cap 8 + skip_if path_already_present preserved; validators exit 0; push cursor-landing-v3.")
    (done_proof "Three slices passed_closing in PROOF-LOG; PHASE-MAP P6 outcomes satisfied; manual double-init scenario recorded; check-parens + validate-lisp-bundle exit 0.")
    (slice_count 3)
    (required_outcomes
      (ro-1-ignore-marked-blocks-skill-templates)
      (ro-2-merge-troubleshooting-closeout)
      (ro-3-proof-double-init-v3-push))
    (non_negotiable_user_intent
      "Edits only github-publish-lisp/cursor-landing-skill/** and lisp verify scripts when REQUIRED_* unchanged; no factory root SKILL.md; no github-publish/; no P5 closeout rewrite; pseudo-Lisp spine; preserve append-only spirit for user lines outside managed blocks."))

  (constraints
    (layer_mapping "Same as P5: application = .../SKILL.md; domain = .../references/; infrastructure = .../assets/; presentation = README OVERVIEW install troubleshooting")
    (forbidden_edits
      "SKILL.md at factory root"
      "references/scan-report.schema.json at factory root"
      "github-publish/**"
      "cursor-landing/cursor-landing/**"
      "Planner/slice-runs/cursor-landing-p5/** STATUS closeout_validation"
      "delete user .cursorindexingignore lines without confirmation")
    (out_of_scope_unless_user_expands
      "factory markdown publish tree"
      "JSON schema github-publish/"
      "automated repo scanner"
      "SDK index resync API"
      "cheap .mdc dedup beyond Q6 replace/merge"))
    (proof_style "per slice: check-parens.py; closeout: validate-lisp-bundle.py exit 0; PROOF-LOG manual double-init scenario"))

  (slices
    (slice
      (number 1)
      (name ignore-marked-blocks-idempotency)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (reviewed 2026-05-26)
      (inspect
        "github-publish-lisp/cursor-landing-skill/SKILL.md"
        "github-publish-lisp/cursor-landing-skill/assets/cursorindexingignore.baseline.template"
        "github-publish-lisp/cursor-landing-skill/assets/cursorignore.dual-host.template")
      (done
        "Stable begin/end markers in both ignore templates; SKILL (indexing_ignore) and phase_2_route cursorignore use replace_managed_block_or_skip when marker present, else first-time write; step_1 no longer blind append of full baseline on re-init; step_2 trim append unchanged (cap 8, skip_if path_already_present); first-time init behavior equivalent to P5.")
      (proof
        "check-parens exit 0; grep SKILL for managed_block or replace_section; template files contain marker pair comments"))

    (slice
      (number 2)
      (name merge-troubleshooting-reinit-note)
      (slice_type standard)
      (status passed_closing)
      (reviewed 2026-05-26)
      (depends slice_1)
      (inspect
        "github-publish-lisp/cursor-landing-skill/references/MERGE-TO-RULES.md"
        "github-publish-lisp/cursor-landing-skill/references/troubleshooting.md"
        "github-publish-lisp/cursor-landing-skill/SKILL.md phase_3 closeout")
      (done
        "MERGE documents re-init idempotency for .cursorindexingignore and .cursorignore (marked blocks + append-if-missing); troubleshooting one plain line: safe to re-run, what duplicates would mean if markers removed; Phase 3 closeout bullet when ignore files updated: re-run safe.")
      (proof
        "check-parens exit 0; links resolve; no ignore teaching added to conduct templates"))

    (slice
      (number 3)
      (name proof-double-init-v3-push)
      (slice_type standard)
      (status passed_closing)
      (reviewed 2026-05-26)
      (depends slice_2)
      (inspect
        "Planner/slice-runs/cursor-landing-p6/PROOF-LOG.md"
        "github-publish-lisp/cursor-landing-skill/")
      (done
        "PROOF-LOG describes manual scenario: fixture or dogfood repo, Phase 2 twice same Q14 keep_both path, second run no duplicate baseline globs or dual-host paths in ignore files; validate-lisp-bundle exit 0; git push cursor-landing-skill → cursor-landing-v3.")
      (proof
        "validate-lisp-bundle.py exit 0; PROOF-LOG row passed_closing; GIT-SHIP push recorded")))
```

## Slice summary

| # | Name | Delivers |
|---|------|----------|
| 1 | `ignore-marked-blocks-idempotency` | **passed_closing** — markers + SKILL replace-or-skip |
| 2 | `merge-troubleshooting-reinit-note` | **passed_closing** — MERGE + troubleshooting + Phase 3 closeout |
| 3 | `proof-double-init-v3-push` | **passed_closing** — PROOF-LOG double-init + validators + v3 push |

## Marker sketch (slice 1 implementer)

Use stable comment lines both templates can share conceptually:

```text
# >>> cursor-landing:cursorindexingignore:baseline BEGIN >>>
… template body …
# <<< cursor-landing:cursorindexingignore:baseline END <<<
```

```text
# >>> cursor-landing:cursorignore:dual-host BEGIN >>>
… dual-host paths …
# <<< cursor-landing:cursorignore:dual-host END <<<
```

Phase 2 logic (pseudo-Lisp): if `BEGIN` marker present → replace lines between markers from current template; else create file or append managed block once. Trim paths: keep `skip_if path_already_present` (append-if-missing **B**).
