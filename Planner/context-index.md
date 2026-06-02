# Context index (Grokmvp factory workspace)

This repository is the **clone-space factory**: Cursor rules, `Planner/`, human
`docs/`, user-owned `assets/`, reference product under `project-code/`, proof run
[`grokmvp-phase1`](slice-runs/grokmvp-phase1/) (`complete`). New planning:
[`SPEC-SEED.stub.md`](intake/SPEC-SEED.stub.md). P1 seed archived:
[`SPEC-SEED-grokmvp.md`](../docs/references/SPEC-SEED-grokmvp.md). Factory vs greenfield:
[START-HERE.md](intake/START-HERE.md).

## Read order — factory (this repo)

1. `Planner/router-state.md` — active run directory and `STATUS.md` path.
2. The run `STATUS.md` named by `active_status` (currently
   `Planner/slice-runs/grokmvp-phase1/STATUS.md`) — `current_mode`,
   `active_slice_file`, `next_action`. When `current_mode` is `complete`, that run
   is historical; start a new folder under `Planner/slice-runs/` for P2+ work.
3. `Planner/AGENTS.md` — guardrails, write boundaries, verification habits.
4. `Planner/CONTEXT.md` — shared vocabulary for this kit.
5. `Planner/contracts/README.md` — v4 contract stack and read order.
6. `Planner/context-index.md` — this file.
7. `Planner/phase-map/README.md` — phase map stub and validation gate (chat-only
   per `Planner/contracts/phase_map_review_prompt.md`).
8. `Planner/intake/SPEC-SEED.stub.md` — seed template for new planning (P1 dogfood:
   `docs/references/SPEC-SEED-grokmvp.md`).

## Greenfield paste (another repository)

Copy the portable `Planner/` kit (and your project's rules/docs layout) into a
**different** repo. Do **not** copy Grokmvp-specific seed, handoff, or completed
factory runs.

| Step | Action |
|------|--------|
| Seed | Grill and plan from [`Planner/intake/SPEC-SEED.stub.md`](intake/SPEC-SEED.stub.md), not `SPEC-SEED-grokmvp.md`. |
| Router | Reset `Planner/router-state.md` and create a new run under `Planner/slice-runs/`. |
| Mapping | Fill `project_layer_mapping` in `Planner/contracts/codex-router-planner-unified.md`. |
| Lift | Follow [`docs/references/TARGET-REPO-LIFT.md`](../docs/references/TARGET-REPO-LIFT.md) for post-paste cleanup. |

Orientation for humans: [START-HERE.md](intake/START-HERE.md),
[PLANNER-DIRECTION.md](intake/PLANNER-DIRECTION.md).
