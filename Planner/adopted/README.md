# Adopted planner backups (reference-only)

This folder is **insurance and historical reference**, not something you run during
normal cursor-landing maintainer work.

## Active planner contracts for this repo

| Location | Role |
|----------|------|
| `Planner/contracts/` | **Active** — v4 router, packet schema, architecture rules |
| `Planner/contracts/codex-router-planner-unified.md` | Filled `project_layer_mapping` for slug `cursor-landing` |
| `Planner/router-state.md` + `Planner/slice-runs/<run>/STATUS.md` | Active run pointer and per-run state |

Do **not** treat paths under `adopted/` as actionable instructions for cursor-landing
planning or implementation.

## What is in `adopted/capex3/`?

Frozen backup from a Capex3 migration attempt. **Do not edit these files during
normal work.**

| File | Use |
|------|-----|
| `codex-router-planner-unified-filled.md` | Backup of a filled contract for a different product |
| `docs-mirror-codex-router-planner-unified.md` | Another backup snapshot from git |
| `router-state-capex3.md` | Old router pointer snapshot — reference only |

## Copying Planner to another repo

1. Copy the whole **`Planner/`** folder (contracts stay as templates or pre-filled per target).
2. In the **new** repo, fill `project_layer_mapping` in
   `Planner/contracts/codex-router-planner-unified.md` per that repo's seed.
3. Do **not** copy `Planner/adopted/`.
4. Do **not** copy another project's filled contract into this repo's active
   `Planner/contracts/` without an explicit migration slice.

## Reference-only rule

`Planner/adopted/capex3/` and anything under `Planner/adopted/` are **reference-only**.
Active slice planning and implementation for cursor-landing use `Planner/contracts/`,
the seed at `Planner/intake/SPEC-SEED-cursor-landing.md`, and the selected run under
`Planner/slice-runs/`.
