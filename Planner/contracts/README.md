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

## Artifact registry (Lisp-shaped planner state)

Before creating or editing a planner artifact, identify its **type** in this
table and follow the **canonical schema** column only. If the type is not listed,
**halt** and add a row plus schema definition before writing (do not invent keys
or split state across new files).

| Type | Typical path | Canonical schema |
|------|----------------|------------------|
| `router_state` | `Planner/router-state.md` | `codex-extraction-packet-schema-sexpr.md` → `(packet router_state)`; echo `codex-router-planner-unified.md` → `active_run_pointer` |
| `run_status` | `RUN_DIR/STATUS.md` (lisp fence: `(run_status …)`) | `codex-router-planner-unified.md` (STATUS authority); `_template/STATUS.md` stub fields; `codex-extraction-packet-schema-sexpr.md` → `project_shape`, `closeout_validation` / `extraction_final_closeout` |
| `extraction_phase_map` | `Planner/phase-map/PHASE-MAP.md` | `codex-extraction-packet-schema-sexpr.md` → `(packet extraction_phase_map)` |
| `extraction_slice_list` | `RUN_DIR/SLICE-LIST.md` when `project_shape` is `multi_phase` | `codex-extraction-packet-schema-sexpr.md` → `(packet extraction_slice_list)` |
| `single_phase_slice_list` | `RUN_DIR/SLICE-LIST.md` when `project_shape` is `single_phase` | `codex-extraction-packet-schema-sexpr.md` → `(packet single_phase_slice_list)` |
| `extraction_next_slice` | `RUN_DIR/<slice>.md` (standard slice) | `codex-extraction-packet-schema-sexpr.md` → `(packet extraction_next_slice)` |
| `extraction_corrective_slice` | `RUN_DIR/<slice>.md` (corrective) | `codex-extraction-packet-schema-sexpr.md` → `(packet extraction_corrective_slice)` |
| `extraction_architecture_decision_slice` | `RUN_DIR/<slice>.md` (architecture decision) | `codex-extraction-packet-schema-sexpr.md` → `(packet extraction_architecture_decision_slice)` |
| `proof_log_entry` | `RUN_DIR/PROOF-LOG.md` entries | `codex-extraction-packet-schema-sexpr.md` → `(proof_log_entry)` |
| `extraction_final_closeout` | `RUN_DIR/STATUS.md` closeout sections | `codex-extraction-packet-schema-sexpr.md` → `(packet extraction_final_closeout)` |
| `project_layer_mapping` | `codex-router-planner-unified.md` `project_layer_mapping` block | `codex-extraction-packet-schema-sexpr.md` → `(packet project_layer_mapping)` |

**Not in this registry (prose, not Lisp packets):** `Planner/intake/*` seeds and
briefs, `Planner/AGENTS.md`, contract prose outside lisp code fences, and
`Planner/phase-map/validation/*` notes. Routed work still follows
`../AGENTS.md` and the v4 read order above.

Cursor rules when editing `Planner/**/*.md`: `.cursor/rules/planner-artifacts.mdc`
(schema + halt) and `.cursor/rules/internal-doc-style.mdc` (Lisp shape, nesting).
Do **not** apply `.cursor/rules/thermonuclear.mdc` implementation protocols to
planner artifacts.

## Phase map (cross-repo anchor)

- `../phase-map/PHASE-MAP.md` — required outcomes, deferred phases, and phase
  intent referenced at closeout (path pinned in the unified contract).

## Archive

- `archive/` — older prompts, superseded contract snapshots, and portability
  notes. Prefer the three files in **Read order** above for current v4 work.
