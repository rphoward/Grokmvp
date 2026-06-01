# 02 - State Doctor And Golden Transition Fixtures

## Goal

Create a validation layer that catches stale, contradictory, or unsafe Planner
state before agents begin work. Back it with golden fixtures for every edge
case that previously caused desync.

## Why this matters

The planner's biggest historical failure mode was state duplication and stale
authority. A router simulator chooses actions; the doctor proves the state it
is reading is internally coherent.

## Doctor checks

- `Planner/router-state.md` points to an existing selected run directory.
- selected `STATUS.md` exists and contains required transient fields.
- support docs do not claim active run authority.
- `support_doc_sync` is recorded in `STATUS.md`, not used to mutate support
  docs.
- completed runs are not reused for new phase or slice-list planning.
- `project_shape` exists where required.
- single-phase projects do not require `PHASE-MAP.md`.
- multi-phase projects consult `PHASE-MAP.md` without overriding selected
  `STATUS.md`.
- `PROOF-LOG.md` pass lookup accepts `passed_closing` and `passed_with_debt`,
  never bare `passed`.
- blocking closeout entries have `status flagged` when first appended.
- `resolution_id` and `decision_id` records match the expected slice types.

## Golden fixtures

- completed run plus missing phase map
- completed run with explicit repair request
- phase sealed with deferred phases
- single-phase closeout
- multi-phase initialized before `project_shape` exists
- corrective reopen from unmet required intent
- corrective slice that resolves a flagged blocking item
- architecture decision slice that skips implementation
- failed review that requires repair
- stale support-doc state repetition
- wrong `PROOF-LOG` status value
- forbidden physical folder created by a planned slice

## Outputs

- human-readable doctor report
- machine-readable issue list
- severity classification: blocker, warning, info
- recommended next safe action
- fixture pass/fail summary

## Planning questions

- Should fixtures be literal Planner directory trees or compact normalized
  records?
- Should the doctor autofix trivial issues, or stay read-only at first?
- Which checks are generic versus project-specific?
- Should the doctor run before every simulator invocation?

## Search/research items

- Snapshot/golden testing patterns for file-backed state machines.
- Static analysis patterns for validating repo-local instruction files.
- Lightweight CLI report formats for humans and agent consumers.

## First useful slice

Create golden fixture directories for three high-risk states: completed run,
phase sealed, and stale support-doc repetition. Implement a read-only doctor
that reports whether each fixture is safe and what action the router should
emit.

