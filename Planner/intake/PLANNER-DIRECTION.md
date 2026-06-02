# Direction for the unified planner

**Audience:** You, when preparing a planner session — and the AI when it runs the v4 router.

This repo is **standalone_target** planning: contracts live under `Planner/`. The planner reads **disk**, not chat memory, as authority.

This workspace is the **factory** (see [SPEC-SEED.stub.md](SPEC-SEED.stub.md) and [../../docs/references/SPEC-SEED-grokmvp.md](../../docs/references/SPEC-SEED-grokmvp.md) §8). For **greenfield paste** into another repo, use [SPEC-SEED.stub.md](SPEC-SEED.stub.md), reset `router-state.md`, and follow [TARGET-REPO-LIFT.md](../../docs/references/TARGET-REPO-LIFT.md)—not factory reference seeds or the completed proof run under `slice-runs/grokmvp-phase1/`.

---

## The seed is the source packet

| Planner term | Your file |
|--------------|-----------|
| `source_material` (create_phase_map) | [SPEC-SEED.stub.md](SPEC-SEED.stub.md) or your new `SPEC-SEED-<slug>.md` under intake |
| `source_packet` (create_slice_list, plan_next_slice, …) | Same seed; plus approved `PHASE-MAP.md` when **multi_phase** |

P1 used [SPEC-SEED-grokmvp.md](../../docs/references/SPEC-SEED-grokmvp.md) (archived); proof run is **single_phase** with intent inline in `grokmvp-phase1/SLICE-LIST.md`.

**Before any planner session:** Job A in [START-HERE.md](START-HERE.md) — grill until the seed is trustworthy.

Minimum seed content (matches [SPEC-SEED.stub.md](SPEC-SEED.stub.md) and router `require_fields`):

- Goal and non-goals  
- Constraints (repo-layout; product under `project-code/` per repo-layout factory exception; no auto scope creep)  
- Definition of done / proof  
- Proposed phases (becomes PHASE-MAP body when multi_phase)  
- `project_layer_mapping` notes for slug `grokmvp` (see unified contract)

Do **not** point `create_phase_map` at README alone.

---

## One-time: project_layer_mapping

In `Planner/contracts/codex-router-planner-unified.md`, the `grokmvp` block should read:

- **domain** → `project-code/`  
- **application** → `project-code/`  
- **infrastructure** → `assets/`, `tests/`  
- **presentation** → `README.md`, `docs/`, `project-code/README.md`  
- **forbidden_physical_folders** → `src`, `lib`, `apps`, top-level `domain`, `application` at repo root  

Without this, slice `allowed_edits` / `forbidden_edits` will not match the repo.

---

## Router flow (what you experience)

```text
create_phase_map
  → writes PHASE-MAP.md
  → stops (no RUN_DIR required yet for this mode)

[you approve phase map]

create_slice_list (needs RUN_DIR + approved PHASE-MAP + source_packet)
  → writes SLICE-LIST.md, STATUS = slice_list_draft
  → stops

[you approve slice list]

plan_next_slice
  → writes NEXT-SLICE.md, STATUS = slice_planned
  → stops

[you say implement]

implement_slice
  → edits repo per NEXT-SLICE only
  → STATUS = slice_review_needed or slice_active_incomplete
  → stops

… review, next slice, closeout …
```

**Mode isolation:** A planning turn must not implement product/skill files. An implement turn must not rewrite the phase map. Trust STATUS + router, not a pasted script.

---

## Factory slice content rules

When the planner plans or implements slices for this product:

- **In scope:** `project-code/**`, `.cursor/rules/**`, `docs/**`, `assets/**`, `tests/**` when the slice allows  
- **Out of scope:** parallel product trees at repo root (`src/`, `lib/`, `apps/`, top-level `domain/`, `application/`) per `repo-layout.mdc`  
- **Planner kit:** edit `Planner/contracts/` only when the slice explicitly scopes kit maintenance  

Embed these in the seed **constraints** and **non_negotiable_intent** so `create_phase_map` extraction rules keep them in PHASE-MAP.

---

## Multi-phase vs single-phase

| Shape | When |
|-------|------|
| **multi_phase** | Roadmap with multiple phases — writes `PHASE-MAP.md` |
| **single_phase** | One bounded effort; phase intent inline in slice list; skips PHASE-MAP |

For a multi-phase effort, grill seed §5, then `create_phase_map`.

---

## Phase map review (optional gate)

Before `create_slice_list`, you may run the chat-only validator in `Planner/contracts/phase_map_review_prompt.md`. It does not write files; it returns a verdict. Fix `PHASE-MAP.md` if blocked.

---

## Grill → seed → planner (correct order)

```text
1. grill-with-docs  →  updates your seed (from SPEC-SEED.stub.md)
2. you read seed    →  satisfied
3. router-state     →  points at slice-runs/<run>/
4. "create phase map from seed" (or single_phase_project)
5. you OK PHASE-MAP (if multi_phase)
6. "create slice list"
7. you OK SLICE-LIST
8. "implement" per slice until phase closeout
```

---

## If the planner emits NEED_SOURCE

The router could not find enough **source_material** / **source_packet** on disk.

**Fix:** Ensure your seed exists under `Planner/intake/` (or path you name), `router-state.md` points at a live RUN_DIR, and `PHASE-MAP.md` exists before slice list when multi_phase.

---

## Agent contract load order

When running the planner in Cursor on this repo, the agent should read:

1. `Planner/router-state.md`  
2. Active `Planner/slice-runs/<run>/STATUS.md`  
3. `Planner/contracts/codex-router-planner-unified.md`  
4. Seed path you name  
5. `Planner/AGENTS.md` for planner-routed guardrails  

Do not treat deleted factory paths (`Planner/adopted/`, old `cursor-landing-p*` runs) as active state.
