# NEXT-SLICE — slice 3 (archived 2026-05-26, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p5")
  (slice
    (number 3)
    (name q14-question-bank-dual-host)
    (slice_type standard))
  (slice_type standard)

  (review
    (date 2026-05-26)
    (outcome passed_closing)
    (proof
      "check-parens exit 0; Q14 plain keep_both/cursor_only + sub-ask; MERGE § Grill Q14 table; SKILL cursor_only_when + dual_host_when + indexing_ignore preserved; template keep_both-only comments; ro-3 closed; no forbidden paths")
    (reviewer_note
      "validate-lisp-bundle deferred slice 5. Nested lisp ship tree still uncommitted in factory — GIT-SHIP.md before push."))

  (goal
    (name q14-question-bank-dual-host)
    (finish_line "Lisp grill Q14 plain English; keep-both vs Cursor-only .cursorignore policy in question-bank, MERGE, SKILL; template verify.")
    (distance_closed "Closes ro-3-q14-dual-host-cursorignore. Defers Phase 3 closeout to slice 4.")
    (required_outcomes (ro-3-q14-dual-host-cursorignore)))

  (implementation_handback
    (completed 2026-05-26)
    (proof python github-publish-lisp/check-parens.py exit 0)
    (files_edited
      github-publish-lisp/cursor-landing-skill/references/question-bank.md
      github-publish-lisp/cursor-landing-skill/references/MERGE-TO-RULES.md
      github-publish-lisp/cursor-landing-skill/SKILL.md
      github-publish-lisp/cursor-landing-skill/assets/cursorignore.dual-host.template)))
```

Full planning packet preserved in git history at archive time from root `NEXT-SLICE.md` 2026-05-26.
