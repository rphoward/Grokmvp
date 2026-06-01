# NEXT-SLICE — slice 2 (archived 2026-05-26, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p6")
  (slice
    (number 2)
    (name merge-troubleshooting-reinit-note)
    (slice_type standard))
  (slice_type standard)

  (review
    (date 2026-05-26)
    (outcome passed_closing)
    (proof
      "check-parens exit 0; MERGE Q14 + Phase 2 indexing + Phase 2 .cursorignore + Phase 3 bullet 7 + verify rows; troubleshooting Running init again; SKILL phase_3_closeout_chat re_run_safe_when only; indexing_ignore blocks unchanged; conduct/safety templates no new ignore teaching")
    (reviewer_note
      "ro-2 closed. question-bank Q14 append-only wording + MDC-RULES-FORMAT baseline paragraph still stale — out of slice 2 scope; consider slice 3 or backlog. Ship tree gitignored in factory; commit in cursor-landing-v3 repo per GIT-SHIP."))

  (goal
    (name merge-troubleshooting-reinit-note)
    (finish_line "MERGE and troubleshooting document P6 re-init idempotency; Phase 3 closeout mentions safe re-run when ignore files were written.")
    (distance_closed "Closes P6 ro-2-merge-troubleshooting-closeout.")
    (required_outcomes (ro-2-merge-troubleshooting-closeout))))

  (implementation_handback
    (completed 2026-05-26)
    (files_edited
      github-publish-lisp/cursor-landing-skill/references/MERGE-TO-RULES.md
      github-publish-lisp/cursor-landing-skill/references/troubleshooting.md
      github-publish-lisp/cursor-landing-skill/SKILL.md phase_3_closeout_chat only)))
```

## Implementation handback (2026-05-26)

| Action | Path |
|--------|------|
| Edited | `references/MERGE-TO-RULES.md` — Q14, Phase 2 indexing/`.cursorignore`, Phase 3 closeout bullet 7, verify rows |
| Edited | `references/troubleshooting.md` — “Running init again” under Indexing and ignore files |
| Edited | `SKILL.md` — `phase_3_closeout_chat` `re_run_safe_when` gate only |

**Proof:** `check-parens.py` exit 0.
