# Start here — how you actually use the Planner

This matches the **unified router** in `Planner/contracts/codex-router-planner-unified.md`. One chat turn = one planner mode. The AI reads your **seed document** and **disk state** (status files), then does the next legal step.

---

## Two different jobs (do not mix them up)

| Job | What it is | When |
|-----|------------|------|
| **A. Make the seed** | A single intake doc the planner treats as truth | **Before** planning |
| **B. Run the planner** | Phase map → slice list → implement slices until the phase is done | **After** the seed is good |

**Grill-with-docs** is for job **A** only. You sharpen a draft into the real seed file. The planner consumes the finished seed.

---

## Job A — Turn your ideas into the seed (you + grill)

The planner’s `create_phase_map` mode reads **source material**. In this repo that file is:

**`Planner/intake/SPEC-SEED-grokmvp.md`**

That is **not** the root README alone. The seed is for the planner: goals, non-goals, constraints, proof, proposed phases, layer mapping notes.

**What you do:**

1. Skim [README.md](../../README.md) and [Grokmvp/README.md](../../Grokmvp/README.md) for product context.
2. Open `SPEC-SEED-grokmvp.md` or start from [SPEC-SEED.stub.md](SPEC-SEED.stub.md).
3. Run **grill-with-docs** on the seed — especially phases and open decisions. Example:

   > Grill `Planner/intake/SPEC-SEED-grokmvp.md`. This repo is the Grokmvp factory; product code lives under `Grokmvp/`. Update the seed when we agree.

4. Keep editing until **you** would trust this doc as the only briefing for a planner session.

**Job A is done when** the seed reads like a contract: clear goal, clear “won’t do,” clear phases, clear proof.

`project_layer_mapping` for `grokmvp` is already filled in `Planner/contracts/codex-router-planner-unified.md` (see seed §7). Adjust there if your folder layout changes.

---

## Job B — Run the planner (your real loop)

Open this repo in Cursor with the **unified planner** active (agent follows `Planner/contracts/` and reads `Planner/router-state.md`).

### B0 — Pick a run folder (once per phase effort)

Active run: **`Planner/slice-runs/grokmvp-phase1/`** (see `Planner/router-state.md`).

For a new phase effort, copy `Planner/slice-runs/_template/` to a new name and point `router-state.md` at that folder’s `STATUS.md`.

### B1 — Give the planner the seed → phase map

**You say:**

> Create the phase map from the seed at `Planner/intake/SPEC-SEED-grokmvp.md`.

Or say **single_phase_project** / **small_feature** to skip `PHASE-MAP.md` for a tiny task.

**The planner** writes `Planner/phase-map/PHASE-MAP.md` (multi-phase) and stops in planning mode.

**You** read the map and approve or request edits.

### B2 — You OK the phase map → slice list

**You say:** “Create the slice list.”

**The planner** writes `RUN_DIR/SLICE-LIST.md` and updates `STATUS.md`.

**You** approve or revise the slice list.

### B3 — Implement one slice at a time

After approval, the planner plans `NEXT-SLICE.md`. **You say:** “Implement.”

The planner implements only what the slice allows (paths under `Grokmvp/`, `docs/`, `.cursor/rules/`, etc. per slice and `project_layer_mapping`).

Then review → next slice → closeout.

### B4 — Next phase

When the router says the phase is sealed and more phases remain, start a **new run folder** and update `router-state.md`.

---

## What to say to the planner (cheat sheet)

| You want… | Say something like… |
|-----------|---------------------|
| First plan | “Create the phase map from `Planner/intake/SPEC-SEED-grokmvp.md`.” |
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
| `SPEC-SEED-grokmvp.md` | **Seed** — grill this, then feed the planner |
| `PHASE-MAP.md` | Multi-phase chunks (created by planner) |
| `slice-runs/<name>/SLICE-LIST.md` | Tasks for the current run |
| `slice-runs/<name>/NEXT-SLICE.md` | The one task being implemented now |
| `slice-runs/<name>/STATUS.md` | Where the planner thinks the run is |
| `router-state.md` | Which run folder is active |

---

## More detail

| Doc | Use |
|-----|-----|
| [SPEC-SEED-grokmvp.md](SPEC-SEED-grokmvp.md) | The seed itself |
| [PLANNING-WORKFLOW.md](PLANNING-WORKFLOW.md) | Short checklist |
| [PLANNER-DIRECTION.md](PLANNER-DIRECTION.md) | Seed requirements for the router |
| [../contracts/codex-router-planner-unified.md](../contracts/codex-router-planner-unified.md) | Full router (for the agent) |
| [../TARGET-REPO-LIFT.md](../TARGET-REPO-LIFT.md) | Post-paste cleanup checklist |
