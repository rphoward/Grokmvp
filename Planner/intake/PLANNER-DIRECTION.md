# Direction for the unified planner (cursor-landing)

**Audience:** You, when preparing a planner session — and the AI when it runs the v4 router.

This repo is **standalone_target** planning: contracts live under `Planner/`. The planner reads **disk**, not chat memory, as authority.

---

## The seed is the source packet

| Planner term | Your file |
|--------------|-----------|
| `source_material` (create_phase_map) | [SPEC-SEED-cursor-landing.md](SPEC-SEED-cursor-landing.md) |
| `source_packet` (create_slice_list, plan_next_slice, …) | Same seed + approved `PHASE-MAP.md` |

**Before any planner session:** Job A in [START-HERE.md](START-HERE.md) — grill until the seed is trustworthy.

Minimum seed content (matches [SPEC-SEED.stub.md](SPEC-SEED.stub.md) and router `require_fields`):

- Goal and non-goals  
- Constraints (skill-only repo; install bundle; no auto MCP merge)  
- Definition of done / proof  
- Proposed phases (becomes PHASE-MAP body)  
- `project_layer_mapping` notes for slug `cursor-landing` (see seed §7)

Do **not** point `create_phase_map` at README alone.

---

## One-time: project_layer_mapping

In `Planner/contracts/codex-router-planner-unified.md`, replace the `cursor-landing` block per seed §7:

- **domain** → `references/`  
- **application** → `SKILL.md`  
- **infrastructure** → `assets/`, `scripts/`  
- **presentation** → `README.md`, `OVERVIEW.md`  
- **forbidden_physical_folders** → `src`, `lib`, `apps`, top-level `domain`, `application` as code trees  

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

## cursor-landing slice content rules

When the planner plans or implements slices for this product:

- **In scope:** `SKILL.md`, `references/**`, `assets/**`, `scripts/**`, `README.md` / `OVERVIEW.md` / `install.md` when the slice says user-facing docs  
- **Out of scope:** `src/` application code, any product work under `Planner/adopted/` (reference-only quarantine — see [adopted/README.md](../adopted/README.md)), copying `Planner/` into the user install bundle  
- **Policy:** [references/skill-authoring.md](../../references/skill-authoring.md), [references/CONTEXT-FORMAT.md](../../references/CONTEXT-FORMAT.md)

Embed these in the seed **constraints** and **non_negotiable_intent** so `create_phase_map` extraction rules keep them in PHASE-MAP.

---

## Multi-phase vs single-phase

| Shape | When for cursor-landing |
|-------|-------------------------|
| **multi_phase** | Full roadmap (forensics → packaging → dogfood → release) — writes `PHASE-MAP.md` |
| **single_phase** | One small change; phase intent inline in slice list; skips PHASE-MAP |

You said you want **full phase planning** → use **multi_phase**, grill seed §8, then `create_phase_map`.

---

## Phase map review (optional gate)

Before `create_slice_list`, you may run the chat-only validator in `Planner/contracts/phase_map_review_prompt.md`. It does not write files; it returns a verdict. Fix `PHASE-MAP.md` if blocked.

---

## Grill → seed → planner (correct order)

```text
1. grill-with-docs  →  updates SPEC-SEED-cursor-landing.md
2. you read seed    →  satisfied
3. router-state     →  points at slice-runs/<run>/
4. "create phase map from seed"
5. you OK PHASE-MAP
6. "create slice list"
7. you OK SLICE-LIST
8. "implement" per slice until phase closeout
```

No separate “convert README to seed” step unless README was only your draft input to the grill.

---

## If the planner emits NEED_SOURCE

The router could not find enough **source_material** / **source_packet** on disk.

**Fix:** Ensure `SPEC-SEED-cursor-landing.md` exists, paths in your request are correct, and `PHASE-MAP.md` exists before slice list if you skipped approval step.

---

## Agent contract load order

When running the planner in Cursor on this repo, the agent should read:

1. `Planner/router-state.md`  
2. Active `Planner/slice-runs/<run>/STATUS.md`  
3. `Planner/contracts/codex-router-planner-unified.md`  
4. Seed path you name  
5. `Planner/AGENTS.md` for planner-routed guardrails  

Not anything under `Planner/adopted/` — that tree is reference-only quarantine, not active run state.
