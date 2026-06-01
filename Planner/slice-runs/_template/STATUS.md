# Run status (`_template`)

Minimal portable `run_status` stub. Copy this folder to a new
`Planner/slice-runs/<run-name>/` and point `Planner/router-state.md` at it.

```lisp
(run_status
  (run_dir            "Planner/slice-runs/_template")
  (status_path        "Planner/slice-runs/_template/STATUS.md")
  (current_mode       "RUN_TEMPLATE_NOT_STARTED")
  (active_slice_file  "REPLACE_WITH_SLICE_OR_NONE")
  (next_action        "INIT_RUN_FROM_TEMPLATE")
  (project_shape      "unknown")
  (notes              "Fill current_mode, active_slice_file, next_action per Planner/contracts/codex-router-planner-unified.md"))
```
