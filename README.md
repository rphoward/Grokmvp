# Factory workspace

This repository is the **clone-space factory**: Cursor agent rules (`.cursor/rules/`), the portable Planner kit (`Planner/`), human docs (`docs/`), user-owned machine records (`assets/`), and a reference product tree ([`project-code/`](project-code/) for layout examples).

There is no separate product GitHub repo in this model. Develop and version everything here; copy `Planner/` or publish artifacts to other repos when a target project needs them (post-paste checklist: [docs/references/TARGET-REPO-LIFT.md](docs/references/TARGET-REPO-LIFT.md)).

## Start here (zero setup after clone)

1. Read this README and [`Planner/intake/START-HERE.md`](Planner/intake/START-HERE.md).
2. Grill [`Planner/intake/SPEC-SEED.stub.md`](Planner/intake/SPEC-SEED.stub.md) into your project seed.
3. Open Cursor; the router already points at [`Planner/slice-runs/factory/`](Planner/slice-runs/factory/) (`needs_slice_list` — not a completed run).
4. Say **create the phase map from the seed** or **single_phase_project — create the slice list**.

Verify the reference product: `python project-code/hello.py` from the repo root.

P1 dogfood history (completed proof run, archived seed): [`docs/references/grokmvp-phase1-proof/`](docs/references/grokmvp-phase1-proof/), [`docs/references/SPEC-SEED-grokmvp.md`](docs/references/SPEC-SEED-grokmvp.md). Do not use those as your active planning source.

## Greenfield paste

If you copied the portable kit into a **different** repository, you are not in factory mode. Grill [Planner/intake/SPEC-SEED.stub.md](Planner/intake/SPEC-SEED.stub.md), set up your own slice run and `router-state.md`, fill `project_layer_mapping` in [Planner/contracts/codex-router-planner-unified.md](Planner/contracts/codex-router-planner-unified.md), and follow [docs/references/TARGET-REPO-LIFT.md](docs/references/TARGET-REPO-LIFT.md).
