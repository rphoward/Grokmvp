# Handoff — Idempotent Phase 2 repair (Planner seed)

**Written:** 2026-05-26 · **For:** fresh Cursor session → Planner (phase map / slice list / implement)  
**Not for:** v3 install bundle — factory + `github-publish-lisp/cursor-landing-skill/` maintainer work only.

---

## Where the project stands

| Item | State |
|------|--------|
| Factory map | **project_complete** — P1–P5 sealed; [PHASE-MAP.md](../phase-map/PHASE-MAP.md) `deferred_phases` empty |
| P5 run | [cursor-landing-p5 STATUS](../slice-runs/cursor-landing-p5/STATUS.md) `complete`; indexing + ignore shipped in Lisp v3 |
| v3 skill repo | [cursor-landing-v3](https://github.com/rphoward/cursor-landing-v3) — `main` includes P5 + doc passes (`f43ad8e` area); **only** git root for users |
| Factory layout | `github-publish-lisp/cursor-landing-v2/` submodule **removed**; v2 frozen on GitHub @ `5497390` — [docs/archive/cursor-landing-v2-ship-reference.md](../../docs/archive/cursor-landing-v2-ship-reference.md) |
| Parent clutter | Plan A done for `HANDOFF-*.md`; session handoffs are **not** in v3 clone |

**Do not** re-run P5 closeout or rewrite PHASE-MAP unless this becomes a **new phase** (P6) or an explicit **corrective slice** on a new run.

---

## Problem (why this handoff exists)

Phase 2 is **skill-shaped** (bounded init, caps, grill gates) but **not fully idempotent** on **re-init** of the same target repo.

The skill **does not write** into installed `references/` — that tree is read-only policy. Writes go to the **brownfield target repo**:

| Target file | Current behavior | Re-run risk |
|-------------|------------------|-------------|
| `.cursorindexingignore` | Append baseline template; then append ≤8 `indexing_noise` paths (`skip_if path_already_present` on trim only) | **Baseline block may append again** when file already exists — see `SKILL.md` `(step_1_write_baseline … if_exists append_template_lines_only)` |
| `.cursorignore` | Dual-host: **append-only** merge of `cursorignore.dual-host.template` | **Duplicate lines** if Q14 keep_both init runs again |
| `CONTEXT.md` | Merge, **12–20 term** cap | Usually OK; watch merge without dedup |
| `.cursor/rules/*.mdc` | Q6 replace / merge / leave; stack rules from scan evidence | Extra rules if scan + merge on repeat |
| `docs/EMERGENCY-HANDOFF.md` | **Overwrite** each emergency | OK — bounded |

**Design tension:** append-only on ignore files protects user edits but conflicts with “run `/cursor-landing` again safely.”

**Evidence anchors:**

- `github-publish-lisp/cursor-landing-skill/SKILL.md` — `(indexing_ignore …)`, `(phase_2_route …)`, `(phase_2_write …)`
- `references/MERGE-TO-RULES.md` — Q14 `.cursorignore` append-only; Phase 2 order with indexing first
- `references/CONTEXT-FORMAT.md` — merge + term cap (model to emulate for ignore files)
- P5 addendum: [SPEC-ADDENDUM-indexing-ignore.md](SPEC-ADDENDUM-indexing-ignore.md) — append-only baseline, cap 8 trim, no SDK resync

---

## Proposed initiative name

**P6 — Idempotent Phase 2 (re-init safe)** — or a **corrective slice** on a new `Planner/slice-runs/cursor-landing-p6/` if you want phase map continuity without reopening P5.

Planner should choose: **new phase** vs **post-complete maintenance run** (single slice).

---

## Goal (finish line)

Re-running `/cursor-landing` on a repo that **already went through Phase 2** does **not** duplicate:

1. Cursor Landing baseline block in `.cursorindexingignore`
2. Dual-host `.cursorignore` template paths
3. (Stretch) Conflicting `.mdc` conduct/safety duplicates — only if cheap; Q6 already has replace/merge

**Must preserve:**

- First-time init behavior unchanged (baseline + trim + dual-host still work)
- Append-only **spirit** for user-authored lines outside managed blocks
- P5 outcomes (indexing cap 8, Q14, plain closeout, no ignore teaching in conduct templates)
- Pseudo-Lisp spine; validators exit 0

---

## Recommended repair approach (for Planner to refine)

Pick one primary strategy in planning grill:

| Approach | Idea | Trade-off |
|----------|------|-----------|
| **A — Marked sections** | Wrap CL-managed blocks in `.cursorindexingignore` / `.cursorignore` with stable markers; Phase 2 **replace section** or skip if marker present | Best idempotency; small template/SKILL change |
| **B — Append-if-missing** | Before append, normalize paths; skip line if path (or template line) already in file | Simpler; weaker if user edited markers |
| **C — Re-init gate** | Phase 2 detects prior init (marker or existing conduct.mdc + CONTEXT); branch to **merge-only** path | UX question: warn user in closeout |

**Recommendation for slice 1:** **A + B** for ignore files only; leave CONTEXT/AGENTS/MERGE Q6 as-is.

**Out of scope unless user expands:**

- Factory root `SKILL.md` / markdown publish tree
- JSON schema / `github-publish/`
- Automated repo scanner
- SDK/index resync API (still unavailable)
- Deleting user `.cursorindexingignore` lines without confirmation

---

## Edit scope (ship tree)

```
github-publish-lisp/cursor-landing-skill/
  SKILL.md                          ← indexing_ignore + phase_2_route idempotency
  references/MERGE-TO-RULES.md      ← .cursorignore policy + re-init note
  references/troubleshooting.md     ← one plain line: safe to re-run / what duplicates mean
  assets/cursorindexingignore.baseline.template   ← optional marker comments
  assets/cursorignore.dual-host.template          ← optional marker comments
```

Validators (factory parent, if `REQUIRED_*` unchanged):

```powershell
cd C:\Project\cursor-landing
python github-publish-lisp/check-parens.py
python github-publish-lisp/validate-lisp-bundle.py
```

Commit/push **only** inside `cursor-landing-skill/` → **cursor-landing-v3**.

---

## Acceptance criteria (proof)

1. **Spec:** Document idempotent rules in MERGE + SKILL (pseudo-Lisp), not prose-only.
2. **Manual scenario (describe in PROOF-LOG):** Target fixture or dogfood repo — run Phase 2 twice with same Q14 path; second run does not duplicate baseline globs or `AGENTS.md` in `.cursorignore`.
3. **Trim unchanged:** Still cap 8; `skip_if path_already_present` still applies.
4. **Closeout:** Phase 3 chat still plain English; mention re-run safe if true.
5. Validators exit 0 on committed tree.

---

## Suggested Planner next steps

1. Read this file + [codex-router-planner-unified.md](../contracts/codex-router-planner-unified.md) + [domain-spoke-architecture.md](../contracts/domain-spoke-architecture.md).
2. Decide **P6 phase map row** vs **single corrective run** (no new deferred phase if you want map to stay sealed).
3. Create run dir e.g. `Planner/slice-runs/cursor-landing-p6/` (or `cursor-landing-idempotent-p2/`).
4. Slice sketch (example):
   - **Slice 1** — SKILL + templates: marked blocks + replace-or-skip baseline
   - **Slice 2** — MERGE + troubleshooting + closeout bullet
   - **Slice 3** — proof log + dogfood note + v3 push
5. Point [router-state.md](../router-state.md) at new run when planning starts.

---

## Context compression (do not re-litigate)

- v3 clone = flat skill bundle only; no `github-publish-lisp/` parent on GitHub.
- `references/` annex bulk is **intentional** for brownfield scan — not slimmed in P5.
- Thermo-nuclear review: ship OK; optional v2 README deprecation on GitHub only.
- User audience for troubleshooting: stressed new Cursor users — plain language done in `troubleshooting.md`.

---

## First message to paste in fresh session

```text
Read Planner/intake/HANDOFF-idempotent-phase2-planner-seed.md.
Start Planner: propose P6 (or a focused run) for idempotent Phase 2 —
re-init must not duplicate .cursorindexingignore baseline or dual-host .cursorignore lines.
Ship in github-publish-lisp/cursor-landing-skill/ only; push cursor-landing-v3.
Do not reopen P5 closeout or edit factory root SKILL.md.
```
