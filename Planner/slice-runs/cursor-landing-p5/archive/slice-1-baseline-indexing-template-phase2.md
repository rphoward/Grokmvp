# NEXT-SLICE — slice 1 (archived 2026-05-26, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p5")
  (slice
    (number 1)
    (name baseline-indexing-template-phase2)
    (slice_type standard))
  (slice_type standard)

  (review
    (date 2026-05-26)
    (outcome passed_closing)
    (proof
      "check-parens exit 0; template + SKILL indexing_ignore; no forbidden paths; ro-1 partial per SLICE-LIST done clause")
    (reviewer_note
      "Trim append + post-append read deferred slice 2. BUNDLE-MANIFEST / lisp_bundle_checks slice 5."))

  (goal
    (name baseline-indexing-template-phase2)
    (finish_line "Lisp bundle has assets/cursorindexingignore.baseline.template and SKILL.md Phase 2 writes target-root .cursorindexingignore append-only from that template; SKILL documents full order write baseline then append trim paths then read once with read deferred to slice 2 after trim append.")
    (distance_closed "Closes ro-1 partial; completes before scan-trim-indexing-noise slice 2.")
    (required_outcomes (ro-1-baseline-cursorindexingignore))
    (optional_deferred_outcomes ()))

  (implementation_handback
    (completed 2026-05-26)
    (files_created
      github-publish-lisp/cursor-landing-skill/assets/cursorindexingignore.baseline.template)
    (files_edited
      github-publish-lisp/cursor-landing-skill/SKILL.md phase_2 indexing_ignore block)
    (proof python github-publish-lisp/check-parens.py exit 0)
    (deferred_slice_2 append_trim_candidates read_once)))
```

## Implementation handback (2026-05-26)

| Action | Path |
|--------|------|
| Created | `github-publish-lisp/cursor-landing-skill/assets/cursorindexingignore.baseline.template` |
| Edited | `github-publish-lisp/cursor-landing-skill/SKILL.md` — `(indexing_ignore …)` under `phase_2_write` |

**Deferred to slice 2:** `trim_candidates` append; one `read` of target-root `.cursorindexingignore` after append.
