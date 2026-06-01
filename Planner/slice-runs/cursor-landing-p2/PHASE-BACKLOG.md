# PHASE-BACKLOG — cursor-landing-p2

Deferrals from [SLICE-LIST.md](SLICE-LIST.md) `optional_deferred_outcomes` and [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) `deferred_phases`. P2 slice 6 finalized this table; `final_closeout` may append `phase_lessons`.

## Deferred phases (from PHASE-MAP)

| order | phase | suggested_run_dir | source |
|-------|-------|-------------------|--------|
| 3 | P3 — Dogfood & fixtures | `Planner/slice-runs/cursor-landing-p3/` | [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) |
| 4 | P4 — Publish & install path | `Planner/slice-runs/cursor-landing-p4/` | same |

## Carried from P1 closeout

| item_id | description | phase | reason |
|---------|-------------|-------|--------|
| titan-dogfood-2-mdc | ≥2 `.mdc` on Titan fixture | P3 | P1 deferral |
| validate-package-py | `scripts/validate-package.py` | P4 | P1 deferral |
| publishable-tree-scaffold | `cursor-landing/cursor-landing/` | P4 | Not P2 scope |

## phase_lessons

P2 closeout: factory maintainer docs benefit from explicit Planner deferral in root AGENTS.md — keeps skill-factory guardrails separate from routed Planner run state.
