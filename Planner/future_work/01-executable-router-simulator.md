# 01 - Executable Router Simulator

## Goal

Create a deterministic command or script that reads the portable Planner state
and emits one legal next action without relying on a model to reinterpret the
contract prose.

## Why this matters

The router contract is currently detailed but manual. Multi-agent or long-term
work needs a machine-checkable transition function so agents do not disagree
about whether the run is complete, ready to implement, ready to review, blocked,
or needs a new run directory.

## Inputs

- `Planner/router-state.md`
- selected `RUN_DIR/STATUS.md`
- selected `RUN_DIR/NEXT-SLICE.md` when `active_slice_file` requires it
- selected `RUN_DIR/SLICE-LIST.md`
- selected `RUN_DIR/PROOF-LOG.md`
- selected `RUN_DIR/PHASE-BACKLOG.md`
- `Planner/phase-map/PHASE-MAP.md` for multi-phase projects
- `Planner/contracts/codex-router-planner-unified.md` as the source contract

## Outputs

- `next_legal_action`
- reason for the selected action
- required files for that action
- allowed write surface for that action
- hard stops if state is contradictory or unsafe
- optional machine-readable JSON output for automation

## Required behavior

- Resolve `Planner/router-state.md` first.
- Read only the selected run's `STATUS.md` for transient run fields.
- Treat completed run directories as history unless explicitly selected for
  repair or corrective work.
- Distinguish `project_complete`, `phase_sealed`, `phase_active`,
  `phase_initialized`, and `phase_contested`.
- Refuse compound transitions unless an explicit future automation mode allows
  them.

## Planning questions

- Should the simulator parse the pseudo-Lisp directly or require a normalized
  JSON export?
- Should invalid state return a single `NEED_STATE_REPAIR` action?
- Should the simulator be read-only forever, or should a later command write
  suggested state repairs?
- What error format will be easiest for agents and humans to consume?

## Search/research items

- Parser options for small S-expression dialects.
- Existing state-machine libraries with transition explanation support.
- JSON Schema or equivalent validators for generated normalized records.
- Prior art for CLI commands that return both human-readable and JSON output.

## First useful slice

Implement a read-only command that resolves `Planner/router-state.md`, reads the
selected `STATUS.md`, and emits `RUN_COMPLETE`, `READY_TO_IMPLEMENT`,
`READY_TO_REVIEW`, `READY_TO_REPAIR_ACTIVE_SLICE`, `NEED_NEW_PHASE_RUN_DIR`, or
`NEED_STATE_REPAIR` for a minimal set of fixtures.

