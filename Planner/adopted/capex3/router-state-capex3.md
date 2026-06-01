# Router state (portable stub)

This file is the **active-run pointer** for the `Planner/` kit. Planner-routed
work resolves active state here before reading any per-run `STATUS.md`.

Paste-oriented stub (s-expression shape matches the unified contract’s
`active_run_pointer` intent):

```lisp
(router_state
  (active_run_dir   "Planner/slice-runs/_template")
  (active_status    "Planner/slice-runs/_template/STATUS.md")
  (active_phase     "REPLACE_WITH_PHASE_NAME_OR_UNKNOWN")
  (updated          "REPLACE_WITH_ISO8601_DATE")
  (notes            "Edit fields when you create a real RUN_DIR under Planner/slice-runs/."))
```
