# NEXT-SLICE — slice 1 (archived 2026-05-26, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p6")
  (slice
    (number 1)
    (name ignore-marked-blocks-idempotency)
    (slice_type standard))
  (slice_type standard)

  (review
    (date 2026-05-26)
    (outcome passed_closing)
    (proof
      "check-parens exit 0; SKILL replace_managed_block + BEGIN markers; templates have marker pairs; no append_template_lines_only; step_2 cap 8 skip_if unchanged; v3 repo diff only SKILL.md + two assets templates; MERGE/troubleshooting untouched")
    (reviewer_note
      "ro-1 closed. MERGE + troubleshooting + double-init PROOF-LOG → slice 2–3."))

  (goal
    (name ignore-marked-blocks-idempotency)
    (finish_line "Re-init Phase 2 does not duplicate baseline .cursorindexingignore or dual-host .cursorignore template blocks; first-time init unchanged; trim cap 8 + skip_if path_already_present preserved.")
    (distance_closed "Closes P6 ro-1-ignore-marked-blocks-skill-templates.")
    (required_outcomes (ro-1-ignore-marked-blocks-skill-templates))
    (optional_deferred_outcomes ()))

  (implementation_handback
    (completed 2026-05-26)
    (files_edited
      github-publish-lisp/cursor-landing-skill/SKILL.md
      github-publish-lisp/cursor-landing-skill/assets/cursorindexingignore.baseline.template
      github-publish-lisp/cursor-landing-skill/assets/cursorignore.dual-host.template)
    (proof python github-publish-lisp/check-parens.py exit 0)))
```

## Implementation handback (2026-05-26)

| Action | Path |
|--------|------|
| Edited | `github-publish-lisp/cursor-landing-skill/SKILL.md` — managed-block replace-or-skip for baseline + dual-host |
| Edited | Both `assets/*.template` — BEGIN/END marker pairs |

**Deferred:** MERGE/troubleshooting (slice 2); double-init PROOF-LOG + v3 push (slice 3).
