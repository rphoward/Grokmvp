# Grokmvp (factory)

This repository is the **factory**: one place for the whole works—Cursor agent rules (`.cursor/rules/`), the portable Planner kit (`Planner/`), human docs (`docs/`), machine records (`assets/`), and a reference product tree ([`project-code/`](project-code/) for dogfood and layout examples).

There is no separate product GitHub repo in this model. Develop and version everything here; copy `Planner/` or publish artifacts to other repos when a target project needs them (see `Planner/TARGET-REPO-LIFT.md`).

**Greenfield paste:** if you copied the portable kit into a different repository, you are not in factory mode. Grill [Planner/intake/SPEC-SEED.stub.md](Planner/intake/SPEC-SEED.stub.md), reset `Planner/router-state.md` and your slice run folder, and fill `project_layer_mapping` in `Planner/contracts/codex-router-planner-unified.md`. Do not treat this repo’s `SPEC-SEED-grokmvp.md` or `grokmvp-phase1` run as your source of truth.
