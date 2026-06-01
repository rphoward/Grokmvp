# 08 - Progressive Autonomy Ladder

## Goal

Define safe autonomy levels so the planner can evolve from manual guidance to
multi-agent execution without jumping straight to unsupervised code changes.

## Why this matters

The current method is cautious and labor-intensive. The next system should
increase autonomy gradually while preserving the parts that work: explicit
state, architecture gates, proof, and closeout discipline.

## Proposed levels

### Level 0 - Read-only diagnosis

Run simulator, doctor, and dashboard. No file writes.

### Level 1 - Suggested plan

Generate proposed slices, work packages, or repairs as text. Human approves
before writes.

### Level 2 - Write plan artifacts

Write `SLICE-LIST.md`, `NEXT-SLICE.md`, work packages, graph, or claims. No
product code changes.

### Level 3 - Single-agent implementation

Implement one approved work package with bounded write set and required
handback.

### Level 4 - Multi-agent implementation

Spawn or coordinate multiple workers with disjoint write sets and durable
leases.

### Level 5 - Integration and review

Coordinator integrates worker outputs, runs proof, and routes to review gate.

### Level 6 - Closeout automation

Closeout can classify remaining work, record support-doc checks, and route to
complete/corrective/contested without planning the next phase in the same pass.

## Required controls

- explicit autonomy level recorded in run state or invocation
- allowed write surfaces per level
- proof requirements per level
- human approval gates for destructive or broad changes
- rollback/recovery policy for stale or failed workers

## Planning questions

- Where is autonomy level stored: user prompt, `STATUS.md`, or automation
  config?
- Which levels are allowed to spawn agents?
- Which levels can write code?
- Which levels can update run-control files?
- What requires human approval every time?

## Search/research items

- Autonomy-level frameworks for coding agents.
- Human approval and escalation patterns.
- Long-running agent job orchestration.
- Safe rollout patterns from read-only tools to write-capable automation.

## First useful slice

Add an `autonomy_level` concept to planner docs and simulator output. Keep all
behavior read-only until levels 0 and 1 are proven against golden fixtures.

