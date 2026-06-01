# Start here — how you actually use the Planner

This matches the **unified router** in `Planner/contracts/codex-router-planner-unified.md`. One chat turn = one planner mode. The AI reads your **seed document** and **disk state** (status files), then does the next legal step. You do not paste a stack of “Brief 1 / Brief 2” prompts unless you want to; you **tell the planner what you want** in normal language and it routes itself.

---

## Two different jobs (do not mix them up)

| Job | What it is | When |
|-----|------------|------|
| **A. Make the seed** | A single intake doc the planner treats as truth | **Before** planning |
| **B. Run the planner** | Phase map → slice list → implement slices until the phase is done | **After** the seed is good |

**Grill-with-docs** is for job **A** only. You sharpen a draft (README notes, half-formed goals) into the real seed file. The planner does not replace grilling; it consumes the finished seed.

---

## Job A — Turn your ideas into the seed (you + grill)

The planner’s `create_phase_map` mode reads **source material**. In this repo that file is:

**`Planner/intake/SPEC-SEED-cursor-landing.md`**

That is **not** the marketing README. README is for humans installing the skill. The seed is for the planner: goals, non-goals, constraints, proof, proposed phases, layer mapping notes.

**What you do:**

1. Skim README and [OVERVIEW.md](../../OVERVIEW.md) so you know the product story.
2. Open `SPEC-SEED-cursor-landing.md` (already drafted) or start from [SPEC-SEED.stub.md](SPEC-SEED.stub.md).
3. Run **grill-with-docs** on the seed — especially the phase list and open questions. Example:

   > Grill `Planner/intake/SPEC-SEED-cursor-landing.md`. This repo only ships the Cursor Landing skill, not an app. Update the seed when we agree.

4. Keep editing until **you** would trust this doc as the only briefing for a planner session.

**Job A is done when** the seed reads like a contract: clear goal, clear “won’t do,” clear phases, clear proof — not slogans.

Optional one-time setup: fill `project_layer_mapping` for `cursor-landing` in `Planner/contracts/codex-router-planner-unified.md` (see seed §7). That tells the planner which folders mean “domain” vs “presentation” in **this** repo.

---

## Job B — Run the planner (your real loop)

Open this repo in Cursor (or Codex) with the **unified planner** active (agent follows `Planner/contracts/` and reads `Planner/router-state.md`).

### B0 — Pick a run folder (once per phase effort)

Copy `Planner/slice-runs/_template/` to something like `Planner/slice-runs/cursor-landing-phase1/`.

Point `Planner/router-state.md` at that folder’s `STATUS.md`.

Each **run folder** is one planner “run” (slice list + status + next slice files live there). Multi-phase work may use **a new run folder per phase** when the router says you need a new phase run.

### B1 — Give the planner the seed → phase map

**You say** (plain language is fine):

> Create the phase map from the seed at `Planner/intake/SPEC-SEED-cursor-landing.md`.

Or: **create phase map** — the router enters `create_phase_map` when there is no `PHASE-MAP.md` yet.

**The planner:**

- Reads your seed as source material
- Writes `Planner/phase-map/PHASE-MAP.md`
- Stops (planning mode does not implement skill files yet)

**You:**

- Read `PHASE-MAP.md`
- Say yes, or ask for edits in another planner turn
- Optional: run the **phase map review** gate (`phase_map_review_prompt.md`) if you use that quality step — chat-only verdict, then fix the map if needed

### B2 — You OK the phase map → slice list

After the phase map is **approved**, the router moves toward **create_slice_list** (status becomes something like `phase_initialized` on the path to needing a slice list — the agent follows STATUS).

**You say:**

> Create the slice list for this phase.

**The planner needs:**

- An active run folder (B0)
- Approved `PHASE-MAP.md`
- Source packet fields from your seed (the agent pulls `required_outcomes`, `non_negotiable_intent`, etc. from the seed / phase map)

**The planner writes:**

- `RUN_DIR/SLICE-LIST.md`
- Updates `RUN_DIR/STATUS.md` (e.g. slice list draft)

**You:**

- Read the slice list
- Approve or ask for revisions (**approve slice list** in router terms)

### B3 — Implement one slice at a time until the phase finishes

After the slice list is approved, the planner **plans the next slice** (writes `NEXT-SLICE.md`, sets status to ready to implement).

**You say:**

> Implement.

**The planner:**

- Implements **only** what that slice allows (for cursor-landing: skill files under `SKILL.md`, `references/`, `assets/`, `scripts/` — not `src/` app code)
- Stops when the slice is complete or marked incomplete for resume

Then review → next slice → repeat until **closeout** for that phase.

**You do not** re-run “create phase map” in the middle of a healthy run. The router blocks that when a run is already complete. You continue from STATUS.

### B4 — Next phase (if PHASE-MAP has more phases)

When the phase is **sealed** and the map still has deferred phases, the router may tell you to start a **new run folder** for the next phase. Point `router-state.md` at the new run, keep the same seed unless intent changed, and continue slice work for that phase.

### B5 — Prove the skill (you, outside the planner)

Copy the install bundle to `~/.cursor/skills/cursor-landing/` (see `references/install.md`).

Open **another** repository and run `/cursor-landing`. That is not a planner mode; it validates the skill. Feed failures back as a **corrective** or new slice in a planner run if needed.

---

## Your loop in one diagram

```text
GRILL (optional but recommended)
  README / notes  →  SPEC-SEED-cursor-landing.md  (the seed)

PLANNER
  seed  →  PHASE-MAP.md     →  you OK
        →  SLICE-LIST       →  you OK
        →  NEXT-SLICE → implement  →  review  →  … until phase closeout
        →  (next phase: new run folder if needed)

YOU
  dogfood /cursor-landing on another repo
```

---

## What to say to the planner (cheat sheet)

| You want… | Say something like… |
|-----------|---------------------|
| First plan | “Create the phase map from `Planner/intake/SPEC-SEED-cursor-landing.md`.” |
| Slice breakdown | “Create the slice list.” (after phase map approved) |
| OK slice list | “Approve the slice list.” |
| Do work | “Implement.” (when STATUS says ready) |
| Continue | “Resume.” (if a slice was left incomplete) |
| Fix a slice | “Repair” / corrective path (when closeout found gaps) |

The agent should read `Planner/router-state.md` and the active `STATUS.md` every time — not guess the mode.

---

## What we got wrong before

Earlier docs described **you** copying “Brief 1, Brief 2” into chat. That is not how the unified planner is meant to work. The router already knows the modes (`create_phase_map`, `create_slice_list`, `implement_slice`, …). Your job is:

1. A good **seed** on disk  
2. A **run folder** wired in `router-state.md`  
3. Plain-language **requests** that match the next step  
4. **Reading** the files the planner wrote before you say “implement”

---

## Files to know (plain names)

| File | Role |
|------|------|
| `SPEC-SEED-cursor-landing.md` | **Seed** — grill this, then feed the planner |
| `PHASE-MAP.md` | Big chunks of work across phases |
| `slice-runs/<name>/SLICE-LIST.md` | Small tasks for the current run |
| `slice-runs/<name>/NEXT-SLICE.md` | The one task being implemented now |
| `slice-runs/<name>/STATUS.md` | Where the planner thinks the run is |
| `router-state.md` | Which run folder is active |

---

## More detail

| Doc | Use |
|-----|-----|
| [SPEC-SEED-cursor-landing.md](SPEC-SEED-cursor-landing.md) | The seed itself |
| [PLANNING-WORKFLOW.md](PLANNING-WORKFLOW.md) | Short checklist |
| [PLANNER-DIRECTION.md](PLANNER-DIRECTION.md) | What must be in the seed for the router |
| [../contracts/codex-router-planner-unified.md](../contracts/codex-router-planner-unified.md) | Full router (for the agent) |
