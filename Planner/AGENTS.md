# AGENTS.md (portable planner kit)

This file steers coding agents when work is routed through the **`Planner/`**
tree (router state, slice runs, v4 contracts). It is the portable planner
guardrail file for Planner-routed work. The repository root **`AGENTS.md`** may
still contain repo-local operational facts, but it should not duplicate active
Planner run state.

## Precedence vs repository root `AGENTS.md`

Nothing **automatically** “wins” by path: tools may load **both** root `AGENTS.md`
and `Planner/AGENTS.md`. Without an explicit rule, a messy or stale root file can
**dilute or contradict** planner architecture in practice.

**Declared rule for Planner-routed work** (slices under `Planner/slice-runs/…`
using `Planner/contracts/`): **`Planner/AGENTS.md`**, **`Planner/contracts/domain-spoke-architecture.md`**, and **`Planner/contracts/codex-router-planner-unified.md`**
govern **architecture, `project_layer_mapping`, ownership gates, and slice
discipline.** Root **`AGENTS.md`** stays good for **repo-only operational facts**
(commands, CI, local paths) **as long as it does not contradict** those Planner
sources or the selected run’s **`STATUS.md`**.

If you add conflicting lines to root `AGENTS.md` later, **they do not override**
this kit for routed architecture until you **reconcile** them. The preferred
root-file pattern is one durable sentence that defers Planner-routed work to
`Planner/AGENTS.md`, not copying Planner run state or lifecycle details into
root. Until then, treat contradictions as a **documentation bug** to fix, not as
new law for the router.

## Read order (Planner-local)

Resolve state before planning or implementing:

1. `Planner/router-state.md` — active run pointer (`active_run_dir`,
   `active_status`).
2. The selected run’s `STATUS.md` (path given by `active_status`) — sole
   authority for `current_mode`, `active_slice_file`, and `next_action` for routed
   work.
3. `Planner/context-index.md` — short index for this kit.
4. **`Planner/AGENTS.md` (this file)** — architecture echo and write boundaries.
5. `Planner/contracts/README.md` — then the v4 contracts in the order listed
   there (`codex-router-planner-unified.md`, packet schema, architecture rules).

Normative architecture rules and vocabulary live in
`Planner/contracts/domain-spoke-architecture.md`. This file summarizes; that
file decides when details conflict.

## Architecture (echo)

- **Domain center** holds durable business meaning, invariants, and product
  language. **Spokes** express user or system capabilities outward through the
  application boundary, **ports**, concrete infrastructure, and **presentation
  transforms** (UI, HTTP, CLI, etc.).
- **Planning a slice does not grant permission to bypass architecture.** If a
  slice would change ownership of meaning, source data, dependency direction, or
  stack direction, the unified router requires an **architecture decision slice**
  (see `Planner/contracts/codex-router-planner-unified.md`) before standard
  implementation proceeds.
- Prefer **intent-revealing names** (folders, modules, public entry points).
  Avoid vague catch-alls (`utils`, `helpers`, `manager`, …) unless qualified by
  domain language; details in `domain-spoke-architecture.md`.

## Project layer mapping (placeholders)

Conceptual planner layers (`domain`, `application`, `infrastructure`,
`presentation`) map to **your** physical packages and folders in
`Planner/contracts/codex-router-planner-unified.md` under `project_layer_mapping`.
Replace `{{PROJECT_SLUG}}` and `FILL_*` placeholders there. That contract block
is the machine-readable mapping source for Planner-routed work. The **root**
`AGENTS.md` of the target repo may echo the durable domain-center boundary or
defer to `Planner/AGENTS.md`, but it is not required to mirror Planner internals
and must not carry active run state.

## Write boundaries (generic)

- Touch only files needed for the **active slice** or an explicit user request.
- Keep a **deterministic** calculation or domain core **free of framework and
  transport** concerns where the product requires reproducibility.
- If you expose a **runtime** (HTTP, jobs, CLI), it orchestrates and presents; it
  must not silently become a second implementation of core business rules unless
  a slice explicitly records that tradeoff.
- Separate **test fixtures** from **runtime shipped data**; keep fixture trees
  under something like `tests/fixtures/` and production data under a package
  data home (e.g. `src/<package>/.../data/`) as your layout dictates.
- Prefer explicit package roots (e.g. `src/<package>/`) over ad hoc scattered
  modules unless a slice says otherwise.

Do not create parallel “second domain” trees because of naming fatigue: one
clear domain center (name varies by project) unless an approved architecture
decision says otherwise.

## Out of scope unless a slice selects it

Do not expand into open-ended product roadmap, unscoped UX redesign, deployment
pipelines, accounts, persistence product features, or extra presentation stacks
unless the **phase map** or **slice list** explicitly includes that work.

## Verification (lightweight, slice-driven)

Before calling a slice done, run the **lightest proof** the slice and
`STATUS.md` require, for example:

- Import or syntax smoke checks with the repo’s normal `PYTHONPATH` / install
  layout.
- Target-local unit tests that already exist for the touched surface.
- HTTP readiness or a single home-route check when the slice owns runtime
  exposure.
- Browser or screenshot proof **only** when the slice explicitly carries that
  surface; follow paths and commands recorded in the active run’s `STATUS.md` or
  `PROOF-LOG.md` when present.

If the scaffold for a proof command does not exist yet, say so instead of
pointing at another repository’s proof as a substitute.

## Work style

- Preserve unrelated user work; keep edits scoped.
- Prefer concrete paths and copy-pasteable commands in notes you add to run
  files.
- When root `AGENTS.md` disagrees with **`Planner/AGENTS.md` or v4 contracts** on
  **architecture or slice discipline**, prefer this kit for Planner-routed work
  until root is reconciled (see **Precedence** above).
- When any steering file disagrees with the selected run on **transient** router
  fields (`current_mode`, `next_action`, …), trust **`STATUS.md`** after
  `Planner/router-state.md`.
- Planner closeout records support-doc checks in the selected run’s
  `STATUS.md`; it must not update root `AGENTS.md`, `Planner/AGENTS.md`, or
  `Planner/context-index.md` just to synchronize active run state.
