# Cursor Landing — planner seed (source packet)

**This file is the seed.** The unified planner reads it as **source material** (`create_phase_map`) and as **source packet** (slice list / slice planning). Grill this document first; do not substitute README.

**Status:** Grill-with-docs complete (2026-05-21); harness annex pass (2026-05-22) — decisions in [CONTEXT.md](../../CONTEXT.md). **Before `create_phase_map`:** finish §12 if anything remains; then phase map → you approve → slice list → implement slices per phase.

**Human steps:** [START-HERE.md](START-HERE.md) · **Router notes:** [PLANNER-DIRECTION.md](PLANNER-DIRECTION.md)

---

## 1. Goal

Ship and maintain **Cursor Landing** as a reliable Cursor Agent skill that:

1. Forensically scans brownfield repos for multi-tool agent debris (Cursor, Codex, Claude, Gemini/Antigravity, Copilot, Cline, Windsurf, Amazon Kiro, Augment Intent, Amp Neo, MCP cross-config, plus checklist-only signals for Continue, Aider, Amazon Q).
2. Produces **excellent `.cursor/rules/*.mdc`** on the target repo: default **conduct + safety** (always-on), optional **glob-scoped** rules from scan evidence, and **markdown links** to foreign repo docs (README, `docs/`, ADRs) when paths exist — not copies of whole docs. Plus glossary **CONTEXT.md**, slim **AGENTS.md** (rules point at both).
3. Supports **emergency handoff** (`docs/EMERGENCY-HANDOFF.md`) for mid-task tool switches.

**Success looks like:** A developer installs `~/.cursor/skills/cursor-landing/`, runs `/cursor-landing` on their app repo, and gets files that still help on the next session—without duplicating run-state or violating glossary/MCP policy.

---

## 2. Non-goals

- **Anything that is not the installable skill** — no app code (`src/`, frameworks, UI). See [references/skill-authoring.md](../../references/skill-authoring.md).
- Shipping `Planner/`, `.cursor/`, or research PDFs inside the user install bundle.
- Running full `/cursor-landing` init **against this skill repo** except deliberate dogfood sessions.
- Auto-merging MCP configs or copying Cline `memory-bank` logs into CONTEXT.
- Replacing Cursor’s product quickstart (link only).
- Maintaining `Planner/adopted/capex3/` as active product work (reference only).
- Publishing a GitHub issue PRD until scope is grilled and phase map approved (optional later).

---

## 3. Product spine (stable wording)

Use in docs and slices; align with [OVERVIEW.md](../../OVERVIEW.md) and [README.md](../../README.md).

- **Brownfield repo** — existing codebase with leftover agent files from prior tools.
- **Phase 0 scan** — read-only inventory; [SCAN-REPORT-SCHEMA.md](../../references/SCAN-REPORT-SCHEMA.md).
- **Mini grill** — ≤5 questions; Q6 replace/merge/leave when agent files exist.
- **CONTEXT.md** — glossary only ([CONTEXT-FORMAT.md](../../references/CONTEXT-FORMAT.md)).
- **AGENTS.md** — slim guardrails + proof command.
- **Host annex** — per-tool scan reference under `references/annexes/` (see [INDEX](../../references/annexes/INDEX.md)).
- **Host extension** — maintainer recipe to add/remove scan hosts: [HOST-EXTENSION.md](../../references/HOST-EXTENSION.md) (annex + INDEX + checklist; do not paste into SKILL).
- **Emergency handoff** — transient run-state only.
- **MDC rule set** — scan proposes, Phase 2 writes; [MDC-RULES-FORMAT.md](../../references/MDC-RULES-FORMAT.md); factory examples under `.cursor/rules/cursor-landing-*.mdc`.

---

## 4. Current repo state (evidence for planner)

| Area | Path | State |
|------|------|--------|
| Skill workflow | `SKILL.md` | Phases 0–3 + emergency |
| Scan | `references/scan-checklist.md`, `SCAN-REPORT-SCHEMA.md`, `HOST-EXTENSION.md` | v2 human schema + checklist (11 host annexes + mcp); JSON schema + `legacy_host_signals` rename still P1 |
| Forensics research | `references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md` | Sanitized; drives annex/checklist |
| Annexes | `references/annexes/*.md` | cursor, codex, claude, gemini, mcp, copilot, cline, windsurf, **kiro, augment-intent, amp**; add/remove recipe: `references/HOST-EXTENSION.md` |
| Templates | `assets/*` | Written into **target** repos |
| Maintainer rules | `.cursor/rules/cursor-landing-*.mdc` | This repo only |
| Planner kit | `Planner/` | Portable router; **not** copied on skill install |
| Legacy noise | `Planner/adopted/capex3/` | Do not plan Capex3 app work here |
| **Publishable skill tree** | `cursor-landing/` (subdir at repo root) | **To scaffold** — clean package for GitHub + global `~/.cursor/skills/cursor-landing/`; alpha prototype untouched elsewhere |
| Factory-only | Repo root `SKILL.md`, `Planner/`, `.cursor/`, maintainer `CONTEXT.md`, `references/research/*.md` (e.g. Harnesses synthesis, forensics) | Not in install bundle; annexes cite paths, not full research dumps |

**Install bundle** (per [references/install.md](../../references/install.md)): lives in **`cursor-landing/`** subfolder when scaffolded: `README.md`, `OVERVIEW.md`, `SKILL.md`, `references/`, `assets/`, `scripts/` — **exclude** `Planner/`, factory `.cursor/`, `references/research/*.pdf`.

**Target repos (dogfood / users):** `/cursor-landing` creates **their** `.cursor/rules/*.mdc`, `CONTEXT.md`, `AGENTS.md` — global skill install; not project-scoped `.cursor/skills/` as the default path.

**Authoring authority:** [references/skill-authoring.md](../../references/skill-authoring.md) + [SKILL.md](../../SKILL.md). Anthropic full guide: [references/research/claude-skills-guide.md](../../references/research/claude-skills-guide.md) (slices touching description/packaging only).

---

## 5. Constraints

- **Cursor Agent only** for skill execution (`disable-model-invocation`; slash invoke required).
- **CONTEXT = glossary only** — no architecture trees or run-state in CONTEXT.
- **MCP:** inventory in Phase 0; merge to `.cursor/mcp.json` only if user explicitly requests (Q12).
- **Vendor docs** over blogs when updating annexes; mark Antigravity/Gemini/Kiro as verify-locally when paths drift.
- **New scan hosts** — follow [HOST-EXTENSION.md](../../references/HOST-EXTENSION.md); optional forensics/schema only when dogfood or P1 slice requires it.
- **Surgical diffs** — match existing doc tone; no drive-by Planner/Capex3 vocabulary in user-facing skill docs.
- **No secrets** in committed MCP examples.

---

## 6. Proof / definition of done

| Check | Command / action |
|-------|------------------|
| Maintainer docs consistent | Manual: links in `references/` resolve; SKILL matches checklist/schema |
| Skill identity | `SKILL.md` frontmatter `name: cursor-landing` |
| Remote smoke (optional) | Fresh clone; verify required files present (see research validation) |
| Dogfood (per slice) | Run `/cursor-landing` on a **separate** messy fixture repo; verify CONTEXT/AGENTS/rules |
| Planner slice done | `PROOF-LOG.md` in active run records what ran |

This repo has **no** default `pytest` / architecture gates unless a slice adds them.

---

## 7. Project layer mapping (authoritative for this project)

**This seed §7 is authoritative `project_layer_mapping` for cursor-landing.** The phase map and slice lists must **repeat or cite** this table — not invent `src/`, `lib/`, or other app package trees. The portable planner contract (`Planner/contracts/codex-router-planner-unified.md`) stays static; do not edit it for this skill.

`{{PROJECT_SLUG}}` → **cursor-landing**

| Conceptual (planner) | Physical (this repo) |
|----------------------|----------------------|
| domain | `references/` — formats, annexes, `HOST-EXTENSION.md`, scan schema, research |
| application | `SKILL.md` — phase workflow (behavior spec) |
| infrastructure | `assets/`, `scripts/` |
| presentation | `README.md`, `OVERVIEW.md`, `READMEback.md` |
| bootstrap / runtime | N/A (no app server) |

**Forbidden physical folders (do not create):** `src/`, `lib/`, `apps/`, `domain/`, `application/` as top-level code packages.

**Notes:** Edits to `Planner/contracts/*.md` are planner-kit maintenance, not “domain” product code. Slice work on skill behavior should touch `references/` + `SKILL.md` + `assets/` + `.cursor/rules/` first.

---

## 8. Proposed phases (starting point for PHASE-MAP)

Refine in grill; validate with `phase_map_review_prompt` before `create_slice_list`.

| Phase | Outcome (observable) |
|-------|----------------------|
| **P1 — Research integration** | JSON schema + human spec sync (incl. `proposed_mdc_rules`), Codex `PLANS.md` in handoff, `legacy_host_signals` rename, selective forensics; **SKILL Phase 2 multi-mdc** + Q13; **Kiro/Intent/Amp annexes done** |
| **P2 — Maintainer ergonomics** | `.cursor/rules` + handoff + install doc aligned; no capex3/import noise |
| **P3 — Dogfood & fixtures** | Dogfood on `C:\Projects\Kbupgrade - Copy (4)` (writes stay there; Titan label superseded). Factory: `tests/fixtures/` for sanitized scan example + notes only — no skill outputs at factory root |
| **P4 — Publish & install path** | README/OVERVIEW accurate; GitHub install tested; troubleshooting covers new hosts |
| **P5 — Indexing & ignore files** | **Lisp ship product only** (`github-publish-lisp/cursor-landing-skill/`): baseline `.cursorindexingignore`, capped scan append via `trim_candidates`, Q14 plain choice, Phase 3 plain chat closeout, best-effort post-write `read` (no SDK resync) — [SPEC-ADDENDUM-indexing-ignore.md](SPEC-ADDENDUM-indexing-ignore.md) |
| **Deferred** | Automated scanner; issue-tracker PRD; team MCP merge templates; optional factory glossary maintainer pass (not on phase map) |

---

## 9. Attachments for planner sessions

**Workflow:** Grill this seed → planner `create_phase_map` → you OK `PHASE-MAP.md` → `create_slice_list` → you OK → `implement` each slice until phase closeout. See [START-HERE.md](START-HERE.md).

Minimum packet:

- This file (SPEC-SEED-cursor-landing.md)
- [SPEC-ADDENDUM-indexing-ignore.md](SPEC-ADDENDUM-indexing-ignore.md) (**required for P5**)
- [references/skill-authoring.md](../../references/skill-authoring.md)
- [SKILL.md](../../SKILL.md)
- [references/install.md](../../references/install.md)
- [references/HOST-EXTENSION.md](../../references/HOST-EXTENSION.md) (maintainer / annex slices)
- [references/MDC-RULES-FORMAT.md](../../references/MDC-RULES-FORMAT.md) (rules / conversion slices)
- [references/annexes/INDEX.md](../../references/annexes/INDEX.md) (scan / conversion slices)
- [references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md](../../references/research/AGENT-FORENSICS-RESEARCH-RESULTS.md) (P1 selective signals — link annexes, avoid duplicating paths)

**Factory-only (not install bundle):** extended harness research under `references/research/` (e.g. Intent/Kiro/Amp synthesis); use for annex authoring, not pasted into SKILL.

---

## 10. Grill outcomes (2026-05-21) + harness pass (2026-05-22)

Full glossary: [CONTEXT.md](../../CONTEXT.md). Summary:

1. **P1 integration gaps:** Codex `PLANS.md` in handoff; `scan-report.schema.json` + JSON-first Phase 0 + human bullets; `legacy_host_signals` rename; selective forensics (link annexes, avoid path duplication); Aider/Continue/Q checklist-only; monorepo depth + scanner deferred.
2. **Done before P1 slices (2026-05-22):** `kiro.md`, `augment-intent.md`, `amp.md`, [HOST-EXTENSION.md](../../references/HOST-EXTENSION.md), INDEX + checklist wiring; SKILL unchanged (checklist + INDEX only).
3. **Dogfood:** `C:\Antigravity_Dev\Titan_GenAI_KB_Builder_v5_Standalone` — writes on Titan only; factory `tests/fixtures/` for sanitized examples (no repo import).
4. **Repo layout:** `Planner/` at factory root; publishable `cursor-landing/cursor-landing/` for GitHub + global install; target repos get `.cursor/rules/` + CONTEXT + AGENTS (Cursor conversion non-negotiable).
5. **PRD / issues (agreed):** [docs/PRD-cursor-landing-v1.md](../../docs/PRD-cursor-landing-v1.md) published to GitHub issues with `ready-for-agent`.
6. **Proof:** Manual until Titan dogfood passes; then `validate-package.py` on publishable tree only.

---

## 11. How this relates to README

| README | This seed |
|--------|-----------|
| User-facing story and install steps | Planner-facing goals, constraints, phases, mapping |
| Marketing tone | Decision-complete intake |
| No layer mapping table | Seed §7 is authoritative `project_layer_mapping`; phase map/slices cite §7 |

---

## 12. Pre phase map — MDC excellence (decision-complete)

### Product intent

Use Phase 0 scan facts to write **Cursor project rules** (`.cursor/rules/*.mdc`) that are **equivalent or better** than the factory split pattern ([`.cursor/rules/`](../../.cursor/rules/) — conduct, safety, layout, scoped references). Foreign tools (Gemini CLI, Kiro, Codex, etc.) stay **scan-only** via annexes; **Cursor** loads `.cursor/rules`, `AGENTS.md`, and (for compatibility) root `CLAUDE.md` per [cursor.com/docs/context/rules](https://cursor.com/docs/context/rules). **Do not assume** `GEMINI.md` or other host files load in Cursor unless a rule **links** to them.

When durable guidance lives in the foreign repo (`docs/`, ADRs, OpenAPI), **link from `.mdc`** instead of duplicating bodies. Only link paths **present in scan**; otherwise `open_questions` or omit.

### Gap found in dogfood (pre-seed)

Phase 2 previously shipped **one** rule from [conduct.template.mdc](../../assets/conduct.template.mdc) only. Target: **at least conduct + safety** always-on; optional glob rules from stack/layout; respect Q6 on existing rules.

### Schemas / stubs (yes — lean)

| Artifact | Role |
|----------|------|
| [MDC-RULES-FORMAT.md](../../references/MDC-RULES-FORMAT.md) | What to propose in scan and write in Phase 2; anti-hallucination |
| [SCAN-REPORT-SCHEMA.md](../../references/SCAN-REPORT-SCHEMA.md) § `proposed_mdc_rules` | Phase 0 fills filenames, globs, `source_paths`, `status` |
| [assets/conduct.template.mdc](../../assets/conduct.template.mdc), [safety.template.mdc](../../assets/safety.template.mdc) | Minimum write set |
| Grill **Q13** ([question-bank.md](../../references/question-bank.md)) | One combined vs several small always-on rules |

`scan-report.schema.json` (P1 slice) should mirror `proposed_mdc_rules` — not required before `create_phase_map`.

### Planner authority (layer mapping + MDC)

- **Layer mapping:** Planner and slices use **seed §7** as `project_layer_mapping`. PHASE-MAP and SLICE-LIST entries cite §7 paths (`references/`, `SKILL.md`, `assets/`, …). Forbidden folders in §7 stay forbidden in every slice.
- **MDC activation:** **Scan- + grill-informed patterns**, not a fixed count of always-on files. Phase 0 `proposed_mdc_rules` records `activation` (`always` | `glob` | `agent_request`) and a one-line **rationale** from evidence. Grill Q13 personalizes when scan is ambiguous.
- **Thin safety (all repos):** Always ship a **minimal** `safety.mdc` (destructive commands, scope, secrets). “Fast” or yolo-style repos get **fewer** conduct/architecture always-on rules and more **glob** or link-out rules — not weaker safety.

### Non-negotiable for phase map / P1

- Phase map must treat **MDC output quality** as first-class (not only CONTEXT/AGENTS).
- P1 slices: align SKILL Phase 2, templates, optional `cursor.md` annex note, dogfood proof = **≥2** `.mdc` on fixture unless user chose one combined rule.

