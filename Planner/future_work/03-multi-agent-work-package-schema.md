# 03 - Multi-Agent Work-Package Schema

## Goal

Define a machine-readable package format for assigning safe, bounded work to
one or more agents.

## Why this matters

Current slices are good for human-guided planning but not sufficient for
parallel execution. A worker needs an exact scope: owned files, forbidden files,
proof commands, dependencies, handback format, and conflict behavior.

## Required fields

- `work_package_id`
- `source_slice_id`
- `worker_role`
- `owned_write_set`
- `read_only_context`
- `forbidden_write_set`
- `shared_files`
- `integration_owner`
- `dependencies`
- `blocked_by`
- `allowed_commands`
- `forbidden_commands`
- `proof_required`
- `handoff_required_fields`
- `expected_outputs`
- `rollback_or_repair_policy`
- `claim_id`
- `claim_expires_at`

## Ownership rules

- Prefer disjoint write sets across workers.
- Shared files require one explicit integration owner.
- Workers must not rewrite run-control state unless their package owns that
  state file.
- Workers must not append `PROOF-LOG.md`; review owns pass records.
- Workers may update handback sections only where the package allows it.

## Handback fields

- files changed
- summary of behavior changed
- proof run or proof not run
- known risks
- unresolved blockers
- deviations from package
- integration notes

## Planning questions

- Should work packages live inside `RUN_DIR/work-packages/`?
- Should packages be generated from `NEXT-SLICE.md`, or should
  `NEXT-SLICE.md` embed them directly?
- Should a package be allowed to span multiple slices?
- What is the minimum useful package for a single-agent run?

## Search/research items

- Multi-agent task assignment schemas.
- Build-system ownership concepts such as Bazel package ownership or CODEOWNERS.
- Work queue handoff formats used by issue trackers and CI systems.
- Conflict-free replicated planning patterns, if multiple agents may update
  status independently.

## First useful slice

Add a `work_package` packet definition to the schema and create one example
package generated from a simple standard slice with a disjoint write set and a
single proof command.

