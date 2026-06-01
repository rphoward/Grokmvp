# NEXT-SLICE — slice 1 (archived 2026-05-24, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (slice
    (number 1)
    (name publishable-tree-scaffold)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name publishable-tree-scaffold)
    (finish_line "cursor-landing/cursor-landing/ is the sole build output; factory scripts populate it with install-bundle files only; BUNDLE-MANIFEST.md lives at publishable root; sync reads publishable path; flat ~/.cursor/skills/cursor-landing/ documented in manifest.")
    (distance_closed "Closes P4 ro-1-publishable-tree-scaffold before install-readme-publish-align (slice 2).")
    (required_outcomes (ro-1-publishable-tree-scaffold))
    (optional_deferred_outcomes ()))

  (review
    (date 2026-05-24)
    (outcome passed_closing)
    (proof
      "build-install-bundle.ps1 → 38 files; SKILL.md + BUNDLE-MANIFEST.md; no Planner/.cursor under publishable; jsonschema exit 0 on publishable paths; scripts target cursor-landing/cursor-landing/ only; install-bundle/DEPRECATED.md added")
    (reviewer_note
      "Sync script still invokes build-install-bundle.ps1 by filename (expected). Factory references/install.md still cites legacy install-bundle/ — slice 2. Publishable tree untracked until commit.")))
```

**Review:** `passed_closing` 2026-05-24. Full plan record: see git history or pre-archive `NEXT-SLICE.md` in this run.
