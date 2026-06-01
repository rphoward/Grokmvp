# Router/planner contracts (portable kit)

This file is the **contract index** for routed router/planner work in a repo
that carries this `Planner/` tree. It lists the v4 contracts, gives a read
order, and points to supporting material.

## Read order (v4)

0. `../router-state.md` — resolve the active run directory before interpreting
   any per-run `STATUS.md`.
1. `codex-router-planner-unified.md` — router decision tree, phase tier, slice
   tier, review/closeout gates, architecture contract references.
2. `codex-extraction-packet-schema-sexpr.md` — packet shapes for slice lists,
   next-slice, corrective slices, architecture-decision slices, closeout fields
   (`slice_type`, `resolution_id`, `decision_id`,
   `blocking_items_resolution_log`, and related keys).
3. `domain-spoke-architecture.md` — ownership, dependency direction, slice
   planning vocabulary, and presentation/infrastructure rules the planner applies
   when filling `layer_ownership`, `touched_spokes`, and proof fields.

Then read **`../AGENTS.md` (this kit)** and `../context-index.md`. Map **domain**
/ **domain center** to your innermost domain package through
`project_layer_mapping` in `codex-router-planner-unified.md`, with
`../AGENTS.md` as the durable planner guardrail explanation. A repository root
`AGENTS.md` may defer to this kit or echo durable repo-local facts, but it must
not be used as active Planner run state. For precedence when root `AGENTS.md`
also exists, see the **Precedence** section in `../AGENTS.md`.

## Phase map (cross-repo anchor)

- `../phase-map/PHASE-MAP.md` — required outcomes, deferred phases, and phase
  intent referenced at closeout (path pinned in the unified contract).

## Archive

- `archive/` — older prompts, superseded contract snapshots, and portability
  notes. Prefer the three files in **Read order** above for current v4 work.
