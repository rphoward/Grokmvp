# Tutorial: How you use the Planner (cursor-landing)

**Start here:** [START-HERE.md](START-HERE.md) — the unified planner entry (seed → phase map → slice list → implement).

This file is extra walkthrough detail. The v4 router runs **one mode per turn** from your seed and STATUS files — not a paste queue of numbered “Briefs.”

**Checklist:** [PLANNING-WORKFLOW.md](PLANNING-WORKFLOW.md)  
**Optional copy-paste shorthand:** [PLANNER-AGENT-BRIEF.md](PLANNER-AGENT-BRIEF.md) (not the primary workflow)

---

## Picture the whole thing

```text
YOU                          AI (Cursor Agent)
───                          ─────────────────
Grill the seed        →      (grill-with-docs updates SPEC-SEED)
Pick a run folder     →      (you edit router-state.md)
"Create phase map"    →      writes Planner/phase-map/PHASE-MAP.md
Read & approve        →      (you)
"Create slice list"   →      writes SLICE-LIST + STATUS
Read & approve        →      (you)
"Implement"           →      edits per NEXT-SLICE only
Review → next slice   →      repeat until phase closeout
Copy skill & test     →      (you dogfood /cursor-landing on another repo)
```

The Planner's value is **structured plans on disk**, not a magic button. Your job is to **steer** and **approve**; the Agent's job is to **draft and execute** inside the guardrails.

See [START-HERE.md](START-HERE.md) for the cheat sheet of plain-language requests (`create phase map`, `create slice list`, `implement`, `review`, …).

---

## What you are building

End users copy a folder to `~/.cursor/skills/cursor-landing/` and run `/cursor-landing` on **their** codebase. This repository is the **factory** for that folder. You are not building an app here.

Ship boundary: [references/install.md](../../references/install.md) and [references/skill-authoring.md](../../references/skill-authoring.md).

---

## Mistakes to avoid

| If you… | What goes wrong |
|---------|-----------------|
| Treat README as the plan | Marketing copy, not phases or constraints — use [SPEC-SEED-cursor-landing.md](SPEC-SEED-cursor-landing.md) |
| Run `/cursor-landing` on this repo while planning | Agent tries to create CONTEXT/AGENTS in the factory |
| Skip approving the phase map and jump to coding | Big unstructured diffs |
| Let the Agent plan from `Planner/adopted/` | Wrong product — adopted material is reference-only |
| Put `Planner/` in the install zip | Users do not need the router kit |
| Paste a stack of Brief prompts as the main workflow | Unified router already knows modes — use STATUS + plain requests |

---

## Phase A — Clarify intent (before plan files)

**Time:** One sitting, ~30–60 minutes with grilling.

1. **File → Open Folder** → this repo (`cursor-landing`).
2. Open [SPEC-SEED-cursor-landing.md](SPEC-SEED-cursor-landing.md). Read §1 Goal, §2 Non-goals, §8 Proposed phases, §10 Open decisions.
3. Open [references/skill-authoring.md](../../references/skill-authoring.md). Remember: only the install bundle ships; `Planner/` stays dev-only.
4. In Agent chat, run **grill-with-docs**. Example:

```text
Grill me on SPEC-SEED-cursor-landing.md sections 8 and 10.
This repo only ships the cursor-landing skill — no src/ app.
Update the seed when we agree on decisions.
```

5. Stop when §8 lists phases you actually want and §10 has fewer "TBD" items.

**You do not need** to understand router S-expressions for this phase.

---

## Phase B — Start a planning run

The kit tracks work in `Planner/slice-runs/<name>/`.

1. Duplicate `Planner/slice-runs/_template/` → e.g. `Planner/slice-runs/cursor-landing-p1/`.
2. Open [Planner/router-state.md](../router-state.md). Set `active_run_dir` and `active_status` to point at your new `STATUS.md`.
3. Optional: read [Planner/README.md](../README.md) once if router pointers are new.

You have created a **notebook** for this planning effort. The Agent will fill it in next.

---

## Phase C — Phase map and slice list (planner modes)

Open Agent chat. Read [START-HERE.md](START-HERE.md) Job B.

### C1 — Phase map

**You say** (plain language):

> Create the phase map from `Planner/intake/SPEC-SEED-cursor-landing.md`.

When the Agent finishes, open `Planner/phase-map/PHASE-MAP.md` on disk.

**You check:** Is every phase about the skill (docs, scan, install, dogfood)? Any phase that adds `src/` or a web app → send it back.

Optional: run the chat-only validator in `Planner/contracts/phase_map_review_prompt.md` before slice list creation.

### C2 — Slice list

After you approve the phase map:

> Create the slice list for this phase.

Open `SLICE-LIST.md` and `STATUS.md` in your run folder.

**You check:** Each slice is small? Paths limited to skill factory surfaces (`SKILL.md`, `references/`, `assets/`, `scripts/`, maintainer docs as scoped)?

If the Agent only prints plans in chat, say: **"Write these to the Planner files, not chat only."**

---

## Phase D — Implement and review slices

After the slice list is approved, the router plans the next slice (`NEXT-SLICE.md`, STATUS → ready to implement).

For each slice, in order:

1. **You read** `NEXT-SLICE.md` (scope + proof).
2. **You say:** "Implement the active slice" (or "Implement") when STATUS says ready.
3. **You review the diff** — reject drive-by changes outside the slice.
4. **You** run or skim proof noted in the slice.
5. In a **fresh session**, say **"Review the active slice"** so the Agent records `PROOF-LOG.md` and advances STATUS.

Repeat until the slice list is finished or you start a new run for leftover work.

---

## Phase E — Validate on another repo

Planning does not prove the skill works.

1. Copy the install bundle to `~/.cursor/skills/cursor-landing/`.
2. Open a **messy project that is not this repo**.
3. Agent mode → type `/cursor-landing`.
4. If something fails, note what repo and what broke. Open a **corrective slice** or new run slice in the factory repo — do not re-plan from `Planner/adopted/`.

---

## Phase F — Optional: issues (you)

If you want GitHub/Linear tickets **after** the phase map and slices look right, run **to-prd** in a separate chat. Skip this if Planner files are enough for you alone.

---

## What to read when (you)

| When | You open |
|------|----------|
| Before any planning | [START-HERE.md](START-HERE.md), SPEC-SEED, skill-authoring |
| Before approving a plan | PHASE-MAP.md, slice files in your run |
| Before calling a release "done" | skill-authoring checklist, install.md |
| Deep skill packaging question | research/claude-skills-guide.md (not the PDF every time) |

Tell the Agent to read `router-state.md` and active `STATUS.md` every session — you do not have to @-mention every file if the prompt names the next mode.

---

## If you are stuck

| Feeling | What to do |
|---------|------------|
| "The doc sounds like the AI's job" | Open [PLANNING-WORKFLOW.md](PLANNING-WORKFLOW.md) — Phases A–F are **your** checkboxes |
| "I don't know what to say" | [START-HERE.md](START-HERE.md) cheat sheet; optional [PLANNER-AGENT-BRIEF.md](PLANNER-AGENT-BRIEF.md) |
| "Agent talks about deals/slices from another product" | Say: "cursor-landing skill factory only; read SPEC-SEED; do not plan from Planner/adopted/" |
| "Too many files" | START-HERE + SPEC-SEED + skill-authoring until Phase C; add forensics paths when a slice needs them |

---

## Short summary

1. **You** grill the seed ([START-HERE.md](START-HERE.md) Job A).
2. **You** set up `slice-runs/<run>/` and `router-state.md`.
3. **You ask** → **Agent writes** phase map → **you approve**.
4. **You ask** → **Agent writes** slice list → **you approve**.
5. **You ask** → **Agent implements** one slice → **you review** → repeat until closeout.
6. **You** dogfood on another repo.

The Planner automates **nothing** without your prompts. It **structures** what the Agent writes so execution is traceable.
