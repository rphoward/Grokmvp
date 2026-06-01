# NEXT-SLICE — slice 2 (archived 2026-05-26, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p5")
  (slice
    (number 2)
    (name scan-trim-indexing-noise)
    (slice_type standard))
  (slice_type standard)

  (review
    (date 2026-05-26)
    (outcome passed_closing)
    (proof
      "check-parens exit 0; manual Select-String checks OK; SLICE-LIST done clause satisfied; ro-1 read + ro-2 trim discipline; no forbidden factory paths")
    (reviewer_note
      "Nested skill repo still uncommitted (expected — gitignored in factory). Commit baseline template + slice 1–2 edits before push per GIT-SHIP.md."))

  (goal
    (name scan-trim-indexing-noise)
    (finish_line "Lisp product Phase 0 scan discipline: no baseline ignore globs inside (scan_report …); trim_candidates carry at most 8 indexing_noise rows with append_indexing_ignore; example documents the pattern; Phase 2 appends those paths to target .cursorindexingignore then read that file once at target root (completes ro-1 index nudge).")
    (distance_closed "Closes ro-2-scan-trim-indexing-noise and completes ro-1-baseline-cursorindexingignore (post-append read). Defers Q14 .cursorignore to slice 3.")
    (required_outcomes (ro-1-baseline-cursorindexingignore ro-2-scan-trim-indexing-noise))
    (optional_deferred_outcomes
      (optional-path-read "One targeted read under a scan-appended path — skip unless dogfood validation needs it; see SPEC-ADDENDUM § Post-init index refresh")))

  (implementation_handback
    (completed 2026-05-26)
    (proof python github-publish-lisp/check-parens.py exit 0)
    (files_edited
      github-publish-lisp/cursor-landing-skill/references/SCAN-REPORT-SCHEMA.md
      github-publish-lisp/cursor-landing-skill/references/scan-checklist.md
      github-publish-lisp/cursor-landing-skill/references/examples/scan-report-example.md
      github-publish-lisp/cursor-landing-skill/SKILL.md)))
```

Full planning packet (architecture, constraints, checklist) preserved in git history at archive time from root `NEXT-SLICE.md` 2026-05-26.
