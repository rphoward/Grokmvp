# 07 - Run Dashboard

## Goal

Generate a compact dashboard from Planner files showing the current state of a
phase, slice, and any active work packages.

## Why this matters

Long-running autonomy needs visibility. Humans and agents need to know what is
active, what is blocked, what is claimed, what proof passed, and what the next
legal action is.

## Dashboard sections

- active run pointer
- selected `STATUS.md` state
- current phase state
- active slice
- work-package claims
- blockers
- proof status
- closeout readiness
- stale support-doc check
- next legal action from router simulator

## Output formats

- terminal summary
- Markdown report
- optional static HTML
- optional JSON for agent tooling

## Planning questions

- Should dashboard generation be part of the doctor command?
- Should it show historical runs, or only selected run state?
- Should stale claims be highlighted as blockers?
- How much proof detail should be shown by default?

## Search/research items

- Static dashboard generation from repository files.
- CLI table rendering libraries.
- JSON report conventions used by CI tools.
- Human-readable status pages for long-running automation.

## First useful slice

Build a read-only Markdown dashboard from `Planner/router-state.md` and selected
`STATUS.md`, then add sections for proof and claims after those schemas exist.

