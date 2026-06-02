# SPEC seed — factory dogfood (historical)

> **Historical (P1 complete, 2026-06-02).** This seed drove `grokmvp-phase1`
> through closeout. For **new planning** use
> [`Planner/intake/SPEC-SEED.stub.md`](../../Planner/intake/SPEC-SEED.stub.md) and the
> default run [`Planner/slice-runs/factory/`](../../Planner/slice-runs/factory/). For **proof**, see
> [`grokmvp-phase1-proof/run/`](grokmvp-phase1-proof/run/).

Source packet for the **factory** workspace P1 effort. The unified router read this
(with `Planner/router-state.md` and the run `STATUS.md`) during slice-list planning.

**Intake path:** conversation summary → `SPEC-SEED.stub.md` shape → this file
(2026-06-01 lift; grill closeout 2026-06-02; archived to `docs/references/` after P1).

## 1. Goal

Finalize the **clone-space factory**: portable `Planner/`, Cursor rules
(`.cursor/rules/`), human `docs/`, user-owned `assets/`, and a reference product
tree under **`project-code/`** (layout proof—not an empty product). This seed was
the **plan to finish that factory**; the router and planner turned it into phase
planning, slice lists, and implementation slices.

Develop here; copy the factory kit to other repos when needed. A **clean clone**
does not require `docs/references/TARGET-REPO-LIFT.md` (that doc is for migrating dirty
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
  “resolve slug from repository folder name” (repo folder name may differ; product home is
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

**P1 (factory seed) — achieved 2026-06-02:**

- This seed listed delivered work and slice-derived completion.
- `Planner/intake/PLANNING-WORKFLOW.md` Job A (grill seed) satisfied.
- Router ran through slice-list approval and `final_closeout` on `grokmvp-phase1`.

**Ongoing proof (post-P1):**

- Slice proof per `NEXT-SLICE.md` and `PROOF-LOG.md` on the active run.
- Phase closeout per `PHASE-MAP.md` or inline single-phase intent.
- Non-trivial product changes: lightest available verification (e.g.
  `python project-code/hello.py` from repo root).

## 5. Proposed phases

| Phase | Focus |
|-------|--------|
| **P1** | Complete clone-space factory (done). |
| **P2+** | TBD after P1 closeout and user intent. |

P1 **outcomes** (completed via `grokmvp-phase1` slices):

- Intake/docs for **factory** vs greenfield kit paste (§8).
- `Planner/context-index.md` factory mode; portable adopters use `SPEC-SEED.stub.md`.
- **`project-code/` rename slice** (slice 4).
- P1 planner loop closed out (`STATUS.md` `complete`).
- Optional post-P1: [grokmvp-phase1-proof/run/PHASE-BACKLOG.md](grokmvp-phase1-proof/run/PHASE-BACKLOG.md).

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
- P1 proof run archived under `docs/references/grokmvp-phase1-proof/` (no longer in `slice-runs/`).
- Reference `project-code/hello.py` scaffold.
- Grill handoff (historical): `docs/references/HANDOFF-grill-spec-seed-2026-06-02.md`.

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

## 8. Factory vs greenfield

| Mode | Meaning |
|------|---------|
| **Factory** (this repo) | Full workspace: rules + `Planner/` + docs + `assets/` + reference product; default run `slice-runs/factory/`. P1 proof + seed archived under `docs/references/`. |
| **Greenfield paste** | Copy portable kit; use `SPEC-SEED.stub.md`; reset `router-state` and run folder; fill `project_layer_mapping`; no factory-specific reference seeds or completed runs. |

## 9. Rename slice — `project-code/` (checklist)

Completed in slice 4 (2026-06-02). See proof run `SLICE-LIST.md` slice 4.
