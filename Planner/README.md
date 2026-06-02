# Portable planner kit (`Planner/`)

This folder is a **self-contained router/planner contract pack** you can copy
into another repository’s root without changing that project’s existing `docs/`
tree. Planner-routed work uses the files inside this directory:
`Planner/router-state.md`, `Planner/context-index.md`, `Planner/contracts/`,
`Planner/phase-map/`, and `Planner/slice-runs/`.

## Read order (paths under `Planner/` only)

1. `Planner/router-state.md` — resolve `active_run_dir` / `active_status` before
   reading any per-run `STATUS.md`.
2. The selected run’s `STATUS.md` (path from `active_status`; default stub points
   at `Planner/slice-runs/_template/STATUS.md`) — `current_mode`, `active_slice_file`,
   `next_action`.
3. `Planner/context-index.md` — factory vs greenfield navigation for this kit.
4. `Planner/AGENTS.md` — architecture echo, write boundaries, verification habits
   (before deep-diving contracts).
5. `Planner/contracts/README.md` — then the v4 contract files in the order listed
   there.
6. `Planner/phase-map/README.md` — how PHASE-MAP seeds validation and slice
   planning.
7. `Planner/intake/SPEC-SEED.stub.md` — placeholder for source packet / intent
   seed.

## Lift into a fresh repository

1. Copy the entire `Planner/` directory to the new project **repository root**
   (sibling to `src/`, `docs/`, etc.).
2. Edit `Planner/router-state.md`: set `active_run_dir` and `active_status` to
   your real run directory and `STATUS.md` path under `Planner/slice-runs/…`.
3. Copy `Planner/slice-runs/_template/` to a new run folder (rename the
   folder), then point `router-state` at it; fill `STATUS.md` and
   `SLICE-LIST.md` per `Planner/contracts/codex-extraction-packet-schema-sexpr.md`.
4. Replace `{{PROJECT_SLUG}}` and `FILL_*` placeholders in
   `Planner/contracts/codex-router-planner-unified.md` (`project_layer_mapping`).
5. Decide how the target repo discovers planner guardrails. Prefer keeping
   `Planner/AGENTS.md` as the Planner-routed authority and adding at most a
   short root `AGENTS.md` deferral sentence. Do not copy active run state into
   root `AGENTS.md`. Add or adapt `src/`, tests, and CI as that project needs.

## Fresh-repo paste checklist

- [ ] `Planner/` pasted at repo root.
- [ ] `Planner/router-state.md` slugs and paths updated.
- [ ] `Planner/slice-runs/<your-run>/STATUS.md` (from `_template`) updated.
- [ ] `Planner/contracts/codex-router-planner-unified.md`
      `project_layer_mapping` block filled for the target repo.
- [ ] Root `AGENTS.md`, if present, either defers Planner-routed work to
      `Planner/AGENTS.md` or echoes only durable repo guardrails; it does not
      duplicate active run state.
- [ ] Optional: `Planner/phase-map/PHASE-MAP.md` created from
      `Planner/phase-map/PHASE-MAP.stub.md` when using multi-phase mode.
