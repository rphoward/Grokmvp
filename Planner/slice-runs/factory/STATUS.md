# Run status — factory (default)

Default factory run after clone. Grill the intake seed, then plan slices.

```lisp
(run_status
  (run_dir            "Planner/slice-runs/factory")
  (status_path        "Planner/slice-runs/factory/STATUS.md")
  (current_mode       "needs_slice_list")
  (active_slice_file  none)
  (next_action        "Grill Planner/intake/SPEC-SEED.stub.md; then say single_phase_project or create slice list from seed.")
  (project_shape      "unknown")
  (notes              "Zero-setup default run. P1 proof archived: docs/references/grokmvp-phase1-proof/."))
```
