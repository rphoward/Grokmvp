# 05 - Branch, Worktree, And Integration Policy

## Goal

Define how agents isolate code changes and how a coordinator integrates them.

## Why this matters

Multi-agent coding fails quickly if workers edit the same files, run different
assumptions, or overwrite each other. The planner needs a clear isolation and
integration strategy before it can safely spawn agents.

## Policy decisions

- one branch or worktree per work package
- one integration branch or worktree per selected slice
- coordinator owns merge/integration files
- workers do not rebase, reset, or rewrite history unless explicitly allowed
- workers do not modify unrelated files
- proof commands are run in worker scope first, then integration scope

## Required fields in work packages

- `branch_name`
- `worktree_path`
- `base_revision`
- `integration_target`
- `merge_strategy`
- `conflict_owner`
- `proof_before_integration`
- `proof_after_integration`

## Planning questions

- Should this planner assume Git, or support non-Git file workspaces?
- Should branch creation be part of Planner automation or handled externally?
- How should generated files and lockfiles be assigned?
- Should each worker be allowed to update tests, or should tests be a separate
  package?

## Search/research items

- Git worktree-based multi-agent workflows.
- Merge queue and stacked branch patterns.
- CODEOWNERS-style file ownership.
- CI matrix design for independently produced work packages.

## First useful slice

Document a minimal Git worktree policy and add schema fields for branch,
worktree, base revision, and integration target. Do not automate Git operations
until the simulator and doctor are stable.

