# PHASE-MAP — cursor-landing (skill factory)

**Shape:** `multi_phase`  
**Authority:** [SPEC-SEED-cursor-landing.md](../intake/SPEC-SEED-cursor-landing.md) (grilled 2026-05-21; harness pass 2026-05-22)  
**Layer mapping:** Seed §7 only — `references/` (domain), `SKILL.md` (application), `assets/` + `scripts/` (infrastructure), `README.md` / `OVERVIEW.md` (presentation). **Forbidden:** `src/`, `lib/`, `apps/`, top-level `domain/`, `application/` as code trees. Planner contract file stays static.

**Project state:** **`project_complete`** — P1–P6 sealed 2026-05-26.  
**Phase map approval:** P1–P6 approved; P6 slice list approved 2026-05-26 — [p6 SLICE-LIST](../slice-runs/cursor-landing-p6/SLICE-LIST.md).  
**Last completed run:** `Planner/slice-runs/cursor-landing-p6/` — **STATUS `complete`** · [closeout_validation](../slice-runs/cursor-landing-p6/STATUS.md#closeout_validation)  
**Prior run:** `Planner/slice-runs/cursor-landing-p5/` — [closeout_validation](../slice-runs/cursor-landing-p5/STATUS.md#closeout_validation)  
**P5 authority:** [SPEC-ADDENDUM-indexing-ignore.md](../intake/SPEC-ADDENDUM-indexing-ignore.md) (grill closeout 2026-05-25) + seed §8 P5 row.  
**P6 authority:** [HANDOFF-idempotent-phase2-planner-seed.md](../intake/HANDOFF-idempotent-phase2-planner-seed.md).

---

## non_negotiable_intent

- **Skill-only product** — installable Cursor Agent skill for brownfield repos; not an app, SaaS, or framework codebase in the factory or publishable tree.
- **Cursor conversion on targets** — Phase 2 writes `.cursor/rules/*.mdc` that reference `CONTEXT.md` and `AGENTS.md`; foreign hosts stay scan-only via annexes unless Q6 says replace/merge/leave.
- **MDC output quality is first-class** — scan proposes rules; Phase 2 ships at least thin **safety** always-on plus conduct (or Q13-combined); glob/link-out rules from evidence; dogfood proof ≥2 `.mdc` on fixture unless user chose one combined rule.
- **CONTEXT = glossary only** on target repos; no run-state, architecture trees, or MCP auto-merge without explicit user request (Q12).
- **Publishable tree** — user install bundle lives under `cursor-landing/cursor-landing/` when scaffolded; **exclude** `Planner/`, factory `.cursor/`, `references/research/*.pdf` from bundle.
- **Global skill install** default (`~/.cursor/skills/cursor-landing/`); slash invoke `/cursor-landing` with `disable-model-invocation`.
- **Dogfood writes** — external fixture only on disk (`C:\Projects\Kbupgrade - Copy (4)` for P3); factory keeps sanitized `tests/fixtures/` examples, no fixture repo import.
- **Do not** run full `/cursor-landing` init against this factory repo except deliberate dogfood; **do not** plan `Planner/adopted/capex3/` as product work.

---

## constraints

- Cursor Agent only for skill execution; vendor docs over blogs for annex updates.
- MCP: Phase 0 inventory only; merge to `.cursor/mcp.json` only on explicit user OK.
- New scan hosts: [HOST-EXTENSION.md](../../references/HOST-EXTENSION.md) recipe — annex + INDEX + checklist; do not paste annex bodies into `SKILL.md`.
- Surgical doc/skill diffs; no Capex3/orchestrator vocabulary in user-facing skill docs.
- No secrets in committed MCP examples.
- Proof: manual link/schema checks + `PROOF-LOG.md` per slice; no default pytest unless a slice adds it.
- `scan-report.schema.json` mirrors `proposed_mdc_rules` in P1 — not a blocker for this map’s approval.

---

## required_outcomes (P1–P4 — complete)

**Closed 2026-05-24.** Detail in each run `closeout_validation` + PROOF-LOG: [p1](../slice-runs/cursor-landing-p1/STATUS.md) research/JSON/mdc; [p2](../slice-runs/cursor-landing-p2/STATUS.md) maintainer rules/docs; [p3](../slice-runs/cursor-landing-p3/STATUS.md) dogfood `C:\Projects\Kbupgrade - Copy (4)` + fixtures; [p4](../slice-runs/cursor-landing-p4/STATUS.md) `cursor-landing/cursor-landing/` publish path.

---

## required_outcomes (P5 — Indexing & ignore files)

**Ship target only:** `github-publish-lisp/cursor-landing-skill/**` plus `github-publish-lisp/check-parens.py` and `validate-lisp-bundle.py` when manifest/checks need updates. **Do not** edit factory root `SKILL.md`, `references/scan-report.schema.json`, `github-publish/`, or `cursor-landing/cursor-landing/` in P5.

**P5 layer mapping (overrides seed §7 for this phase):** `application` → `github-publish-lisp/cursor-landing-skill/SKILL.md`; `domain` → `.../references/`; `infrastructure` → `.../assets/`; `presentation` → `.../README.md`, `OVERVIEW.md`, `references/install.md`, `references/troubleshooting.md`.

Observable before P5 closeout:

1. **Baseline `.cursorindexingignore`** — new `assets/cursorindexingignore.baseline.template`; Lisp `SKILL.md` Phase 2 writes target-root file append-only when present; then **`read` that file once** (best-effort index nudge — [addendum §](../intake/SPEC-ADDENDUM-indexing-ignore.md#addendum-to-this-addendum-index-refresh-only)).
2. **Phase 0 scan discipline** — no baseline pattern list inside `(scan_report …)`; at most **8** repo paths via `trim_candidates` (`type_id` `indexing_noise`, `suggested_action` `append_indexing_ignore`); Phase 2 appends to `.cursorindexingignore`.
3. **Q14 dual-host** — Lisp `question-bank.md` plain wording; `.cursorignore` per grill (dual-host template append-only when user keeps another tool; skip dual-host block when Cursor-only unless scan/grill “never show Agent” paths).
4. **Phase 3 closeout** — plain English chat only (what was set up, other-tool question, new-chat when `.cursorignore` written **or** when fresh `@` search matters after indexing-ignore changes, proof unchanged, one-line ignore ≠ security, one line that search refresh is background); no skill jargon; no new repo doc unless user asks.
5. **Teaching UX** — no ignore paragraphs in `conduct.mdc` / `project-proof.mdc`; `troubleshooting.md` one line + link [Cursor ignore file](https://cursor.com/docs/reference/ignore-file).
6. **Lisp bundle proof** — `python github-publish-lisp/check-parens.py` and `validate-lisp-bundle.py` exit `0`; `BUNDLE-MANIFEST.md` lists new assets if added.

*Explicitly out of P5:* factory markdown `SKILL.md`; markdown publish tree `github-publish/` and `cursor-landing/cursor-landing/`; SDK/script codebase reindex (unavailable — best-effort Phase 2 `read` per [SPEC-ADDENDUM](../intake/SPEC-ADDENDUM-indexing-ignore.md#post-init-index-refresh-best-effort)).

---

## required_outcomes (P6 — Idempotent Phase 2)

**Ship target only:** `github-publish-lisp/cursor-landing-skill/**` plus `github-publish-lisp/check-parens.py` and `validate-lisp-bundle.py` when manifest/checks need updates. **Do not** edit factory root `SKILL.md`, `github-publish/`, or reopen P5 `closeout_validation`.

**Layer mapping:** Same as P5 — application → `.../SKILL.md`; domain → `.../references/`; infrastructure → `.../assets/`; presentation → `.../README.md`, `OVERVIEW.md`, `references/install.md`, `references/troubleshooting.md`.

Observable before P6 closeout:

1. **Marked managed blocks** — `.cursorindexingignore` baseline and dual-host `.cursorignore` use stable begin/end markers in templates; Phase 2 **replace section** or skip when marker present (not blind full-template append on re-init). *Supersedes P5 step_1 re-init append only; user lines outside markers stay append-only.*
2. **Trim unchanged** — cap 8 `indexing_noise` rows; `skip_if path_already_present` on append.
3. **First-time init** — unchanged outcomes vs P5 for new repos (baseline + trim + Q14 dual-host).
4. **Docs** — idempotent rules in `SKILL.md` pseudo-Lisp and [MERGE-TO-RULES.md](../../github-publish-lisp/cursor-landing-skill/references/MERGE-TO-RULES.md); [troubleshooting.md](../../github-publish-lisp/cursor-landing-skill/references/troubleshooting.md) one plain re-run line.
5. **Proof** — PROOF-LOG manual double-init scenario (same Q14 path twice, no duplicate baseline or dual-host paths); validators exit `0`; push **cursor-landing-v3**.

*Explicitly out of P6:* factory markdown `SKILL.md`; markdown publish tree; JSON schema; automated scanner; SDK resync; deleting user ignore lines without confirmation; reopening P5 slices.

---

## deferred_phases

Router authority for **remaining** mapped phases. P1–P4 are omitted here — each has `STATUS complete` and `closeout_validation`; the map does not re-run their closeout.

| order | name | prerequisite | status |
|-------|------|--------------|--------|
| 5 | P5 — Indexing & ignore files | P4 — Publish & install path | **complete** — [p5 STATUS](../slice-runs/cursor-landing-p5/STATUS.md) |
| 6 | P6 — Idempotent Phase 2 | P5 — Indexing & ignore files | **complete** — [p6 STATUS](../slice-runs/cursor-landing-p6/STATUS.md) |

**`project_complete`** — no further mapped phases (P1–P6 complete).

---

## phase_sequence

| order | name | prerequisite | status |
|-------|------|--------------|--------|
| 1 | P1 — Research integration | — | **complete** — [p1 STATUS](../slice-runs/cursor-landing-p1/STATUS.md) |
| 2 | P2 — Maintainer ergonomics | P1 | **complete** — [p2 STATUS](../slice-runs/cursor-landing-p2/STATUS.md) |
| 3 | P3 — Dogfood & fixtures | P2 | **complete** — [p3 STATUS](../slice-runs/cursor-landing-p3/STATUS.md); dogfood `C:\Projects\Kbupgrade - Copy (4)` |
| 4 | P4 — Publish & install path | P3 | **complete** — [p4 STATUS](../slice-runs/cursor-landing-p4/STATUS.md) |
| 5 | P5 — Indexing & ignore files | P4 | **complete** — [p5 STATUS](../slice-runs/cursor-landing-p5/STATUS.md) |
| 6 | P6 — Idempotent Phase 2 | P5 | **complete** — [p6 STATUS](../slice-runs/cursor-landing-p6/STATUS.md) |

*Superseded label:* seed/TUTORIAL **Titan** path `C:\Antigravity_Dev\Titan_GenAI_KB_Builder_v5_Standalone` — not used; see [dogfood-notes.md](../../tests/fixtures/dogfood-notes.md).

### Out of phase map (explicit backlog)

- Automated repo scanner (deferred until dogfood proves need).
- Team MCP merge templates (user-invoked only; no default merge).
- Deep monorepo scan depth (deferred).
- Re-publishing GitHub issues from [docs/PRD-cursor-landing-v1.md](../../docs/PRD-cursor-landing-v1.md) — optional.

**Seed traceability:** §8 P1–P5 → phase_sequence above; §12 MDC → `non_negotiable_intent`; P5 → [SPEC-ADDENDUM](../intake/SPEC-ADDENDUM-indexing-ignore.md); P6 → [HANDOFF-idempotent-phase2-planner-seed.md](../intake/HANDOFF-idempotent-phase2-planner-seed.md). After P6 closeout → `project_complete` (if no P7).
