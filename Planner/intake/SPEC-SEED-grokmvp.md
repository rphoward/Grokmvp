# SPEC seed — Grokmvp

Source packet for the **factory** workspace in this repository. The unified router
reads this (with `Planner/router-state.md` and the active run `STATUS.md`) before
`create_phase_map` or slice-list planning.

**Intake path:** conversation summary → `SPEC-SEED.stub.md` shape → this file
(2026-06-01 lift; grill closeout 2026-06-02).

## 1. Goal

Finalize the **clone-space factory**: portable `Planner/`, Cursor rules
(`.cursor/rules/`), human `docs/`, user-owned `assets/`, and a reference product
tree under **`project-code/`** (layout proof—not an empty product). This seed is
the **plan to finish that factory**; the router and planner turn it into phase
planning, slice lists, and implementation slices.

Develop here; copy the factory kit to other repos when needed. A **clean clone**
does not require `Planner/TARGET-REPO-LIFT.md` (that doc is for migrating dirty
repos only).

## 2. Non-goals

- Shipping a separate product GitHub repo from this workspace unless a future slice
  selects it.
- Reintroducing cursor-landing factory paths, publish bundles, or `/cursor-landing`
  dogfood unless a slice explicitly adds them.
- Auto MCP merge, deployment pipelines, or accounts unless a slice selects them.
- Selecting stub architecture contracts for routed work (stubs are for research
  only; see `Planner/contracts/README.md`).

## 3. Constraints

- **repo-layout:** implementation and shipped app code under **`project-code/`**
  only; repo root is workspace shell. This factory is an exception to
  “resolve slug from repository folder name” (repo is `Grokmvp`, product home is
  **`project-code/`**). `.cursor/rules/repo-layout.mdc` records that factory
  exception.
- **Rules:** `.cursor/rules/` are operational guardrails; normative architecture
  lives in `Planner/contracts/`.
- **Architecture gate:** routed work uses an **allowed** contract in
  `Planner/contracts/README.md`; default **`domain-spoke-architecture.md`**.
  No ad-hoc architecture in slices. Stub families (client-interactive, dataflow,
  deployable-unit, agent-orchestration, state-event) are not selectable until
  promoted and wired in `codex-router-planner-unified.md`.
- **assets/:** user-owned machine-record home; router/planner do not write there.
  Commit an **empty** `assets/` directory as part of factory layout.
- **Tests:** add when slices require proof; report pass/fail explicitly.
- Do not store active planner run state in root `AGENTS.md`.

## 4. Definition of done / proof

**P1 (factory seed) is done when:**

- This seed accurately lists what is already delivered and what remains for slices.
- `Planner/intake/PLANNING-WORKFLOW.md` Job A (grill seed) is satisfied.
- The router has run on this seed at least once through slice-list approval and
  phase closeout for the agreed factory-completion work (slice order and
  dependencies are planner-computed, not fixed in the seed).

**Ongoing proof:**

- Slice proof per `NEXT-SLICE.md` and `PROOF-LOG.md`.
- Phase closeout per `PHASE-MAP.md` or inline single-phase intent.
- Non-trivial product changes: lightest available verification (e.g.
  `python project-code/hello.py` from repo root).

**Phase shape:** the router chooses **single-phase** vs **multi-phase** from seed
complexity and session signals (`single_phase_project`, `create_phase_map`, etc.);
do not lock phase count in this file.

## 5. Proposed phases

| Phase | Focus |
|-------|--------|
| **P1** | Complete clone-space factory: truthful seed, `context-index` factory mode, empty `assets/`, align product home naming with **`project-code/`**, run planner loop to closeout without redoing manual kit work listed below. |
| **P2+** | TBD after P1 closeout and user intent. |

P1 **outcomes** (planner slices derive order and dependencies):

- Update intake/docs for **factory** vs greenfield kit paste (see §8).
- Fix `Planner/context-index.md` for factory mode; portable adopters use
  `SPEC-SEED.stub.md`, not this repo-specific seed.
- **`project-code/` rename slice** — completed (slice 4; checklist §9).
- P1 planner loop closed out in `grokmvp-phase1` (`STATUS.md` `complete`, 2026-06-02).
- Optional post-P1: `Planner/slice-runs/grokmvp-phase1/PHASE-BACKLOG.md` (gitignore debt, smoke tests, arch stub research).

## 6. Already delivered (do not re-slice)

Manual / pre-grill factory work already on disk:

- Cursor rules kit: conduct, safety, repo-layout, thermonuclear, planner-artifacts,
  internal-doc-style, mdc-authoring, doc-style.
- `Planner/AGENTS.md` architecture gate; read order; no architecture echo blob.
- `Planner/CONTEXT.md` glossary; `Planner/contracts/README.md` artifact registry
  and **allowed architectures** table (domain-spoke selectable; five stubs not).
- `Planner/contracts/domain-spoke-architecture.md` + architecture stub files for
  later research.
- `project_layer_mapping` filled for `grokmvp` in unified contract (`project-code/` paths).
- `Planner/slice-runs/grokmvp-phase1/` run wired in `Planner/router-state.md`.
- Reference `project-code/hello.py` scaffold.
- Grill handoff: `Planner/intake/HANDOFF-grill-spec-seed-2026-06-02.md`.

## 7. Layer mapping (physical)

Authoritative block: `project_layer_mapping` /
`(active_project grokmvp)` in
`Planner/contracts/codex-router-planner-unified.md`.

| Conceptual | Physical |
|------------|----------|
| domain | `project-code/` |
| application | `project-code/` |
| infrastructure | `assets/`, `tests/` |
| presentation | `README.md`, `docs/`, `project-code/README.md` |
| forbidden (repo root) | `src/`, `lib/`, `apps/`, top-level `domain/`, `application/` as parallel product trees |

`Planner/` and `Planner/contracts/` are **factory / kit maintenance**, not
product code under `project-code/`, unless a slice explicitly scopes planner edits.

## 8. Factory vs greenfield

| Mode | Meaning |
|------|---------|
| **Factory** (this repo) | Full workspace: rules + `Planner/` + docs + `assets/` + reference product + dogfood seed (`SPEC-SEED-grokmvp.md`) and run (`grokmvp-phase1`). |
| **Greenfield paste** | Copy portable kit; use `SPEC-SEED.stub.md`; reset `router-state` and run folder; fill `project_layer_mapping`; no Grokmvp-specific intake or completed runs. |

Configured factory: this seed exists, mapping is filled, and an active run is
wired—not an empty `project-code/` tree alone.

## 9. Rename slice — `project-code/` (checklist for planner)

Completed in slice 4 (2026-06-02):

- [x] `.cursor/rules/repo-layout.mdc` — factory product home is `project-code/`
      (override repo-name resolution for this workspace only).
- [ ] Optional: `.cursor/rules/thermonuclear.mdc` — literal `project-code/**` in
      `apply-body-only-when` if tighter code-review scope is needed (deferred; repo-layout factory exception suffices).
- [x] Rename `Grokmvp/` → `project-code/` on disk (hello scaffold and README).
- [x] `Planner/contracts/codex-router-planner-unified.md` — `project_layer_mapping`
      paths to `project-code/` (`active_project` key remains `grokmvp`).
- [x] Root `AGENTS.md` — verification command path.
- [x] This seed §7 — aligned with disk and contract.
- [x] Repo grep for `Grokmvp/` path references outside `docs/references/` (repo name / factory title OK).

Proof: `python project-code/hello.py` from repo root passes.
