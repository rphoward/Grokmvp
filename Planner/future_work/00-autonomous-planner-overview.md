# Autonomous Planner Future Work

## Purpose

The current portable `Planner/` kit is a strong manual planning and routing
contract. It prevents architectural drift, stale run state, and accidental
scope expansion, but it still depends on a human or model reading prose and
choosing the next legal step.

The next project is to turn the portable planner into an autonomous planning
system that can safely coordinate long-running, multi-slice, multi-agent, and
multi-phase coding work.

## Target end state

- A deterministic router can read Planner files and emit exactly one legal next
  action.
- A doctor can detect stale or contradictory Planner state before work begins.
- Planned slices can be decomposed into worker-safe packages with explicit
  ownership, proof, and handback requirements.
- Multiple agents can work in parallel without overlapping write sets unless an
  integration owner explicitly coordinates shared files.
- Review and closeout can process several worker handbacks without planning the
  next slice in the same pass.
- A dashboard can show current phase, active slices, claims, blockers, proof
  status, and next legal action.
- Autonomy can be introduced gradually: suggest-only, write-plan, spawn-workers,
  integrate, review, and closeout.

## Development sequence

1. Build the executable router simulator.
2. Build the state doctor and golden transition fixtures.
3. Define the multi-agent work-package schema.
4. Add the phase/slice DAG and lease model.
5. Define branch/worktree and integration policy.
6. Add a reviewer/integration gate for multi-agent handbacks.
7. Build the run dashboard.
8. Add a progressive autonomy ladder.

## Global constraints

- `Planner/router-state.md` remains the only active-run pointer.
- The selected `RUN_DIR/STATUS.md` remains the only authority for
  `current_mode`, `active_slice_file`, and `next_action`.
- `Planner/AGENTS.md`, root `AGENTS.md`, and `Planner/context-index.md` are
  guardrails/navigation files, not run ledgers.
- Support-doc checks are recorded in `RUN_DIR/STATUS.md`; closeout must not
  synchronize active run state into support docs.

## Research before implementation

- Existing lightweight state-machine libraries for the target implementation
  language, if any.
- Existing schema validation tools that can validate S-expression-like records
  or a converted JSON representation.
- Existing multi-agent work-queue patterns: leases, claims, stale claim
  recovery, conflict detection, and resumable handbacks.
- Existing CI/reporting patterns for generating static dashboards from local
  repository files.

