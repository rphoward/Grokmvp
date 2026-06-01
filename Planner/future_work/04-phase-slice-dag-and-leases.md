# 04 - Phase/Slice DAG And Leases

## Goal

Represent long-term work as a dependency graph and add durable leases so agents
can claim work safely.

## Why this matters

Autonomous multi-phase coding needs to know what can run in parallel, what is
blocked, what is stale, and what should be resumed. A linear slice list is not
enough for multi-agent execution.

## DAG concepts

- phase nodes
- slice nodes
- corrective slice nodes
- architecture decision nodes
- work-package nodes
- proof nodes
- closeout nodes
- dependency edges
- blocks edges
- supersedes edges
- resolves edges

## Lease concepts

- `claim_id`
- `claimed_by`
- `claimed_at`
- `expires_at`
- `scope`
- `owned_files`
- `status`
- `heartbeat`
- `recovery_action`

## Required behavior

- No two active claims may own the same file unless one is the integration
  owner.
- Expired claims become recoverable, not automatically overwritten.
- A blocked node cannot be claimed.
- A corrective node must bind to a flagged blocking item.
- An architecture decision node must pass review before dependent standard
  work can begin.

## Planning questions

- Should the DAG live in `RUN_DIR/WORK-GRAPH.md`, `RUN_DIR/work-graph.json`, or
  both?
- Should leases be stored in the graph or in a separate `RUN_DIR/CLAIMS.md`?
- How should a human override a stale lease?
- How much identity does an agent need: model name, thread id, branch name,
  worktree path?

## Search/research items

- Distributed lease and lock patterns.
- Build graph and task graph representations.
- Work-stealing and stale-claim recovery policies.
- Human-in-the-loop override patterns for autonomous agents.

## First useful slice

Create a graph format that can represent three slices, one architecture
decision dependency, and two independent work packages. Add lease validation
rules without executing any workers.

