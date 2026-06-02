# Factory workspace

This repository is the **clone-space factory**: Cursor agent rules (`.cursor/rules/`), the portable Planner kit (`Planner/`), human docs (`docs/`), user-owned machine records (`assets/`), and a reference product tree ([`project-code/`](project-code/) for layout examples).

There is no separate product GitHub repo in this model. Develop and version everything here; copy `Planner/` or publish artifacts to other repos when a target project needs them (post-paste checklist: [docs/references/TARGET-REPO-LIFT.md](docs/references/TARGET-REPO-LIFT.md)).

## Proof run (not your active queue)

[`Planner/slice-runs/grokmvp-phase1/`](Planner/slice-runs/grokmvp-phase1/) is a **completed** single-phase run (`STATUS.md` → `complete`) that proves the router loop on this factory seed. It is historical evidence, not where new work starts. For P2 or new effort: copy `Planner/slice-runs/_template/` to a new run folder, point [`Planner/router-state.md`](Planner/router-state.md) at that run’s `STATUS.md`, and plan from the seed or a new spec.

## Greenfield paste

If you copied the portable kit into a **different** repository, you are not in factory mode. Grill [Planner/intake/SPEC-SEED.stub.md](Planner/intake/SPEC-SEED.stub.md), set up your own slice run and `router-state.md`, fill `project_layer_mapping` in [Planner/contracts/codex-router-planner-unified.md](Planner/contracts/codex-router-planner-unified.md), and follow [docs/references/TARGET-REPO-LIFT.md](docs/references/TARGET-REPO-LIFT.md). Do not treat this repo’s dogfood seed or the completed proof run as your source of truth.
