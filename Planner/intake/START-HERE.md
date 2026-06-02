# Start here — how you actually use the Planner

This matches the **unified router** in `Planner/contracts/codex-router-planner-unified.md`. One chat turn = one planner mode. The AI reads your **seed document** and **disk state** (status files), then does the next legal step.

---

## Two different jobs (do not mix them up)

| Job | What it is | When |
|-----|------------|------|
| **A. Make the seed** | A single intake doc the planner treats as truth | **Before** planning |
| **B. Run the planner** | Phase map → slice list → implement slices until the phase is done | **After** the seed is good |

**Grill-with-docs** is for job **A** only. You sharpen a draft into the real seed file. The planner consumes the finished seed.

## Factory vs greenfield (which repo are you in?)

| Mode | Meaning |
|------|---------|
| **Factory** (this repo) | Full workspace: `.cursor/rules/`, `Planner/`, `docs/`, `assets/`, reference product under [`project-code/`](../../project-code/). Default run [`factory`](../../slice-runs/factory/) (`needs_slice_list`). New planning: [`SPEC-SEED.stub.md`](SPEC-SEED.stub.md). P1 proof archived: [`grokmvp-phase1-proof`](../../docs/references/grokmvp-phase1-proof/), seed [`SPEC-SEED-grokmvp.md`](../../docs/references/SPEC-SEED-grokmvp.md). |
| **Greenfield paste** | Copy the portable kit into another repo; grill and plan from [`SPEC-SEED.stub.md`](SPEC-SEED.stub.md); reset `Planner/router-state.md` and your run folder; fill `project_layer_mapping` in the unified contract. Do not copy factory reference seeds, handoffs, or completed runs. |

Factory vs greenfield: [SPEC-SEED.stub.md](SPEC-SEED.stub.md) and [../../docs/references/SPEC-SEED-grokmvp.md](../../docs/references/SPEC-SEED-grokmvp.md) §8. Post-paste cleanup: [TARGET-REPO-LIFT.md](../../docs/references/TARGET-REPO-LIFT.md).

---

## Job A — Turn your ideas into the seed (you + grill)

The planner’s `create_phase_map` mode reads **source material**. For **new work** in this factory, start from:

**[`Planner/intake/SPEC-SEED.stub.md`](SPEC-SEED.stub.md)**

That is **not** the root README alone (README orients humans; the seed is the planner source packet). The seed holds goals, non-goals, constraints, proof, proposed phases, and layer mapping notes.

P1 dogfood seed is archived at [`docs/references/SPEC-SEED-grokmvp.md`](../../docs/references/SPEC-SEED-grokmvp.md) (do not edit for new phases unless you are deliberately revising history).

**What you do:**

1. Skim [README.md](../../README.md) and [project-code/README.md](../../project-code/README.md) for product context.
2. Copy or grill from [SPEC-SEED.stub.md](SPEC-SEED.stub.md) (or your own `SPEC-SEED-<slug>.md` under intake if you prefer).
3. Run **grill-with-docs** on the seed — especially phases and open decisions.

4. Keep editing until **you** would trust this doc as the only briefing for a planner session.

**Job A is done when** the seed reads like a contract: clear goal, clear “won’t do,” clear phases, clear proof.

`project_layer_mapping` for `grokmvp` is already filled in `Planner/contracts/codex-router-planner-unified.md`. Adjust there if your folder layout changes.

---

## Job B — Run the planner (your real loop)

Open this repo in Cursor with the **unified planner** active (agent follows `Planner/contracts/` and reads `Planner/router-state.md`).

### B0 — Active run folder

Router pointer: **`Planner/slice-runs/factory/`** (see `Planner/router-state.md`) — default after clone; grill seed then plan.

For a **second** parallel phase effort, copy `Planner/slice-runs/_template/` to a new name, point `router-state.md` at that folder’s `STATUS.md`, and use your seed from Job A.

### B1 — Give the planner the seed → phase map

**You say:**

> Create the phase map from the seed at `Planner/intake/SPEC-SEED.stub.md` (or your new seed path).

Or say **single_phase_project** / **small_feature** to skip `PHASE-MAP.md` for a tiny task.

**The planner** writes `Planner/phase-map/PHASE-MAP.md` (multi-phase) and stops in planning mode.

**You** read the map and approve or request edits.

### B2 — You OK the phase map → slice list

**You say:** “Create the slice list.”

**The planner** writes `RUN_DIR/SLICE-LIST.md` and updates `STATUS.md`.

**You** approve or revise the slice list.

### B3 — Implement one slice at a time

After approval, the planner plans `NEXT-SLICE.md`. **You say:** “Implement.”

The planner implements only what the slice allows (paths under `project-code/`, `docs/`, `.cursor/rules/`, etc. per slice and `project_layer_mapping`).

Then review → next slice → closeout.

### B4 — Next phase

When the router says the phase is sealed and more phases remain, start a **new run folder** and update `router-state.md`.

---

## What to say to the planner (cheat sheet)

| You want… | Say something like… |
|-----------|---------------------|
| First plan | “Create the phase map from `Planner/intake/SPEC-SEED.stub.md`.” (or your seed path) |
| Small task | “This is a single_phase_project — create the slice list.” |
| Slice breakdown | “Create the slice list.” (after phase map approved) |
| OK slice list | “Approve the slice list.” |
| Do work | “Implement.” |
| Continue | “Resume.” |

The agent should read `Planner/router-state.md` and the active `STATUS.md` every time.

---

## Files to know

| File | Role |
|------|------|
| `SPEC-SEED.stub.md` | **Seed template** — grill this for new work |
| `docs/references/SPEC-SEED-grokmvp.md` | P1 dogfood seed (historical) |
| `PHASE-MAP.md` | Multi-phase chunks (created by planner) |
| `slice-runs/<name>/SLICE-LIST.md` | Tasks for the current run |
| `slice-runs/<name>/NEXT-SLICE.md` | The one task being implemented now |
| `slice-runs/<name>/STATUS.md` | Where the planner thinks the run is |
| `router-state.md` | Which run folder is active |

---

## More detail

| Doc | Use |
|-----|-----|
| [SPEC-SEED.stub.md](SPEC-SEED.stub.md) | Active seed template |
| [../../docs/references/SPEC-SEED-grokmvp.md](../../docs/references/SPEC-SEED-grokmvp.md) | P1 dogfood seed (archive) |
| [PLANNING-WORKFLOW.md](PLANNING-WORKFLOW.md) | Short checklist |
| [PLANNER-DIRECTION.md](PLANNER-DIRECTION.md) | Seed requirements for the router |
| [../contracts/codex-router-planner-unified.md](../contracts/codex-router-planner-unified.md) | Full router (for the agent) |
| [../../docs/references/TARGET-REPO-LIFT.md](../../docs/references/TARGET-REPO-LIFT.md) | Post-paste cleanup checklist |
