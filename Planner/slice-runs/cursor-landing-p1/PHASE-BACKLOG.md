# PHASE-BACKLOG — cursor-landing-p1 (P1 closeout)

Recorded at **final_closeout** (2026-05-22). Items are **optional or explicitly deferred** — not blocking P1 required outcomes.

## Deferred phases (from PHASE-MAP)

| order | phase | suggested_run_dir | source |
|-------|-------|-------------------|--------|
| 2 | P2 — Maintainer ergonomics | `Planner/slice-runs/cursor-landing-p2/` (create when starting P2) | [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) deferred_phases |
| 3 | P3 — Dogfood & fixtures | `Planner/slice-runs/cursor-landing-p3/` | same |
| 4 | P4 — Publish & install path | `Planner/slice-runs/cursor-landing-p4/` | same |

## Optional outcomes deferred within P1 scope

| item_id | description | phase | reason |
|---------|-------------|-------|--------|
| titan-dogfood-2-mdc | ≥2 `.mdc` on Titan fixture | P3 | SLICE-LIST constraint; user intent — dogfood writes stay on Titan path |
| validate-package-py | `scripts/validate-package.py` | P4 | Publishable tree only; after P3 dogfood |

## Out of phase map (backlog)

| item | notes |
|------|--------|
| Automated repo scanner | Until dogfood proves need |
| Team MCP merge templates | User-invoked only |
| Deep monorepo scan depth | Deferred |
| GitHub issues from PRD | Optional; not blocking P1–P4 |

## Phase lesson (max 1 line)

P1 closed on factory proof (schema + link pass); Titan dogfood remains the P3 gate for real target-repo MDC evidence.
