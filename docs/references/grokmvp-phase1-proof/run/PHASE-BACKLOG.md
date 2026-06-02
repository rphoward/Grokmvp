# Phase backlog — grokmvp-phase1 (optional, post-P1)

Non-blocking items recorded at **final_closeout** 2026-06-02. Not required for P1 `project_complete`.

```lisp
(phase_backlog
  (run_dir     "Planner/slice-runs/grokmvp-phase1")
  (closed      "2026-06-02")
  (phase       "P1 single_phase factory")

  (items
    (item
      (id              slice-1-gitignore-debt)
      (classification  follow_up)
      (source          PROOF-LOG entry 1 passed_with_debt)
      (suggested_run   "new slice in grokmvp-phase2 or ad-hoc fix")
      (reason          "Whitelist !assets/.gitkeep in root .gitignore so assets/ is VCS-visible"))
    (item
      (id              optional-smoke-tests)
      (classification  optional)
      (source          SLICE-LIST deferred footer; seed §5)
      (suggested_run   "grokmvp-phase2 or user-requested slice")
      (reason          "Minimal smoke test harness under tests/"))
    (item
      (id              arch-stub-research)
      (classification  optional)
      (source          seed §5; SLICE-LIST deferred footer)
      (suggested_run   "future research slice")
      (reason          "Architecture stub promotion research; no stub selection in P1")))

  (phase_lessons
    "single_phase closeout: sync orientation docs per support_doc_sync when_single_phase_before_complete in unified contract.")))
```
