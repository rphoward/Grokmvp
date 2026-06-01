# SPEC seed — Grokmvp

Source packet for the portable planner in this repository. Grill this before `create_phase_map` or single-phase slice list.

## 1. Goal

Evolve **Grokmvp** as a factory workspace: Cursor rules (`.cursor/rules/`), portable `Planner/`, human docs (`docs/`), machine records (`assets/`), and a reference product tree under `Grokmvp/` for dogfood and layout examples. Use the planner to break work into phased slices without polluting the kit with prior-project run state.

## 2. Non-goals

- Shipping a separate product GitHub repo from this workspace (develop here; copy `Planner/` or artifacts out when needed).
- Reintroducing cursor-landing skill factory paths, publish bundles, or `/cursor-landing` dogfood in this repo unless a slice explicitly adds them.
- Auto MCP merge, deployment pipelines, or accounts unless a future slice selects them.

## 3. Constraints

- **repo-layout:** implementation and shipped app code under `Grokmvp/` only; root is workspace shell.
- **Rules:** `.cursor/rules/` are operational guardrails; planner architecture lives in `Planner/contracts/`.
- **Tests:** add when slices require proof; report explicitly (no test harness yet at lift).
- Do not store active planner run state in root `AGENTS.md`.

## 4. Definition of done / proof

- Slice proof is whatever `NEXT-SLICE.md` and `PROOF-LOG.md` require (commands, file checks, review pass).
- Phase closeout satisfies `required_outcomes` from `PHASE-MAP.md` or inline phase intent.
- Non-trivial product changes run the lightest available verification and report pass/fail.

## 5. Proposed phases (draft — grill before planning)

| Phase | Focus |
|-------|--------|
| P1 | Stabilize factory layout: seed, mapping, first slice list for Grokmvp product or rules work the user chooses |
| P2+ | TBD after P1 closeout and user intent |

## 6. Open decisions

- Single-phase vs multi-phase for the next body of work (small task → `single_phase_project`; larger → `create_phase_map`).
- First implementation target: extend `Grokmvp/hello.py`, add tests, or continue rules/docs extraction from `docs/references/`.

## 7. Layer mapping (physical)

Aligns with `project_layer_mapping` / `active_project grokmvp` in `Planner/contracts/codex-router-planner-unified.md`:

| Conceptual | Physical |
|------------|----------|
| domain | `Grokmvp/` |
| application | `Grokmvp/` |
| infrastructure | `assets/`, `tests/` |
| presentation | `README.md`, `docs/`, `Grokmvp/README.md` |
| forbidden (repo root) | `src/`, `lib/`, `apps/`, top-level `domain/`, `application/` as parallel product trees |

Planner kit paths (`Planner/`, `Planner/contracts/`) are **kit maintenance**, not domain product code, unless a slice explicitly scopes planner edits.
