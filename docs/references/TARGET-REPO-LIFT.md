# Planner kit — target repo lift (paste, then clean)

**Drop this into Agent chat in the target repo** after you copy the whole `Planner/` folder from the source factory (e.g. `cursor-landing`).

**Flow:** paste `Planner/` → **cleanup** factory baggage → **configure** for this repo → **clash-check** your real code paths → plan.

No install script. Copy/paste is enough; this doc is the post-paste checklist.

---

## Step 1 — Paste

Copy the entire **`Planner/`** directory from the source repo into the **target repo root** (sibling to `src/`, `docs/`, etc.).

Quick check before cleanup: does the target already have its own `Planner/` or root `NEXT-SLICE.md`? If yes, resolve that first (merge, rename, or abort).

---

## Step 2 — Cleanup (delete factory-only baggage)

Remove these paths under the pasted `Planner/`. They are cursor-landing history or reference, not needed to run v4 in a new repo.

| Delete | Why |
|--------|-----|
| `Planner/adopted/` | Capex3 backups; reference-only |
| `Planner/slice-runs/cursor-landing-p1/` … `p6/` | Completed factory runs; wrong paths and state |
| `Planner/contracts/archive/` | Superseded contracts and old `docs/` layout notes |
| `Planner/future_work/` | Roadmap essays only |
| `Planner/folder-map.html`, `Planner/folder-map.lisp` | Factory tree map (optional delete) |

**Intake — remove cursor-landing–specific seeds** (keep generic docs):

| Delete | Keep |
|--------|------|
| `Planner/intake/SPEC-SEED-cursor-landing.md` | `SPEC-SEED.stub.md`, `START-HERE.md`, `PLANNER-DIRECTION.md`, `PLANNING-WORKFLOW.md`, `PLANNER-AGENT-BRIEF.md`, `README.md` |
| `Planner/intake/SPEC-ADDENDUM-indexing-ignore.md` | |
| `Planner/intake/HANDOFF-idempotent-phase2-planner-seed.md` | |
| `Planner/intake/TUTORIAL-planning-cursor-landing.md` | |

**Phase map — remove factory plan** (planner will write a new one, or use single-phase):

| Delete | Keep |
|--------|------|
| `Planner/phase-map/PHASE-MAP.md` | `PHASE-MAP.stub.md`, `README.md`, `validation/` |

**Optional:** delete `Planner/contracts/router-planner-v4-handoff.md` if you want a slimmer kit.

---

## Step 3 — Reset run state (fresh planning session)

1. **Keep** `Planner/slice-runs/_template/`.

2. **Create** a new run folder, e.g. `Planner/slice-runs/my-project-phase1/`:
   - Copy `Planner/slice-runs/_template/STATUS.md` into it.
   - In that `STATUS.md`, set `run_dir` / `status_path` to this folder (not `_template`).
   - Set `current_mode` to something like `needs_slice_list` and `next_action` to note that a seed is required.

3. **Rewrite** `Planner/router-state.md` to point only at the new run:

```lisp
(router_state
  (active_run_dir   "Planner/slice-runs/my-project-phase1")
  (active_status    "Planner/slice-runs/my-project-phase1/STATUS.md")
  (active_phase     "Phase 1")
  (updated          "YYYY-MM-DD")
  (notes            "Fresh lift; add SPEC-SEED and project_layer_mapping before create_phase_map."))
```

Do not leave `router-state` pointing at `cursor-landing-p6` or any deleted run.

---

## Step 4 — Configure for the target repo

### 4a — `project_layer_mapping` (required)

In `Planner/contracts/codex-router-planner-unified.md`, find `(project_layer_mapping …)`.

- Change `(active_project …)` to your slug (e.g. `my-app`).
- Replace the `(cursor-landing …)` block with your paths, or add a new stanza and set `active_project` to it.
- Update `forbidden_physical_folders` for **this** repo (cursor-landing forbids `src/`, `lib/`, etc. because it is a skill factory — a normal app repo usually **must not** copy that list blindly).

Conceptual layers → your real folders:

| Layer | Means | You assign |
|-------|--------|------------|
| domain | Core meaning, schemas, invariants | e.g. `packages/core/`, `domain/` |
| application | Main behavior / orchestration | e.g. `src/`, `app/`, `SKILL.md` |
| infrastructure | Scripts, adapters, assets | e.g. `scripts/`, `infra/` |
| presentation | README, docs, UI copy | e.g. `README.md`, `docs/` |

### 4b — Seed doc (required before planning)

- Copy `Planner/intake/SPEC-SEED.stub.md` → `Planner/intake/SPEC-SEED-<your-slug>.md`.
- Fill goal, non-goals, constraints, proof, phases (grill-with-docs if you use it).
- Edit `Planner/intake/START-HERE.md` / `README.md` to reference your seed filename, not `SPEC-SEED-cursor-landing.md`.

### 4c — Root `AGENTS.md` (recommended)

Add a short deferral — repo CI/commands here; planner architecture in `Planner/AGENTS.md`:

```markdown
## Planner-routed work

For `Planner/slice-runs/` and `Planner/contracts/`, follow
[Planner/AGENTS.md](Planner/AGENTS.md) and the active run `STATUS.md`
(after [Planner/router-state.md](Planner/router-state.md)).
Do not store active planner run state in this file.
```

---

## Step 5 — Clash audit (target scaffolding)

### A — Did paste + cleanup leave a sane `Planner/` tree?

You should have: `contracts/` (3 v4 files + README + `phase_map_review_prompt.md`), `intake/` stubs, `phase-map/` without filled `PHASE-MAP.md` (until you plan), `slice-runs/_template/` + **one** new run, `router-state.md` → that run.

### B — Repo root (outside `Planner/`)

| Path | Risk |
|------|------|
| `AGENTS.md` | OK for deferral only; planner must not mirror run state here |
| `NEXT-SLICE.md` at repo root | **High** — closeout may remove/mark it; do not use for another tool |

### C — Product paths (audit D — most important for daily work)

After you edit `project_layer_mapping`, list **each physical path** you assigned and check the target repo:

| Check | Question |
|-------|----------|
| Exists? | What already lives there? |
| Right layer? | Is “domain” really domain, or mostly UI? |
| Forbidden list | Is anything you **need** (e.g. `src/`) incorrectly forbidden? |

**cursor-landing example (do not keep unless this repo is the same shape):**

| Conceptual | Physical |
|------------|----------|
| domain | `references/` |
| application | `SKILL.md` |
| infrastructure | `assets/`, `scripts/` |
| presentation | `README.md`, `OVERVIEW.md` |
| forbidden | `src`, `lib`, `apps`, `domain`, `application` |

---

## What the planner will create later (for clash scouting)

Paths the v4 router writes during operation — reserve or expect these:

| When | Path |
|------|------|
| Multi-phase plan | `Planner/phase-map/PHASE-MAP.md` |
| Slice breakdown | `Planner/slice-runs/<run>/SLICE-LIST.md`, `STATUS.md` |
| One task | `Planner/slice-runs/<run>/NEXT-SLICE.md` |
| After review | `Planner/slice-runs/<run>/PROOF-LOG.md`, `archive/*.md` |
| Closeout | `STATUS.md` closeout block; optional `PHASE-BACKLOG.md` |
| Implement | **Your** mapped paths only (`NEXT-SLICE.allowed_edits`) |

Kit-internal only: `Planner/router-state.md` (pointer/notes). Do not sync run state into root `AGENTS.md` or `Planner/context-index.md`.

---

## Agent checklist (target repo)

1. Confirm user pasted `Planner/` (or paste was already done).
2. Run **Step 2** deletes; report anything missing (already cleaned).
3. Run **Step 3** if run folder / `router-state` still factory-stale.
4. Run **Step 4** with user’s slug and folder layout.
5. Run **Step 5** clash audit; report conflicts.
6. Stop. Do not `create_phase_map` until seed + mapping are done unless user asks.

---

## Router read order (after lift)

1. `Planner/router-state.md`
2. Active `Planner/slice-runs/<run>/STATUS.md`
3. `Planner/AGENTS.md` → `Planner/contracts/README.md`
4. `Planner/intake/SPEC-SEED-<slug>.md`
5. `Planner/phase-map/PHASE-MAP.md` when multi-phase exists

Authority: `Planner/contracts/codex-router-planner-unified.md` (v4).
