# Handoff — grill `SPEC-SEED-grokmvp.md` and finish factory P1

> **Historical (P1 complete, 2026-06-02).** Grill and planner loop are done. For
> current factory state use `docs/references/SPEC-SEED-grokmvp.md` and
> `Planner/slice-runs/grokmvp-phase1/STATUS.md` (`complete`). The body below is
> session archive only.

**Next session goal:** Run **`/grill-me`** on the open points below (one question at a time), then **update** `Planner/intake/SPEC-SEED-grokmvp.md` from agreed answers. After the seed is trustworthy, run the planner loop (`create_phase_map` or `single_phase_project` → slice list → implement).

**Do not duplicate** full text from: `Planner/CONTEXT.md`, `Planner/AGENTS.md`, `Planner/contracts/README.md` artifact registry, or `.cursor/rules/*.mdc`. Reference those paths.

---

## Suggested skills

| Order | Skill | Purpose |
|-------|--------|---------|
| 1 | **`/grill-me`** | Resolve open decisions in §5–§6 and seed gaps below |
| 2 | **Agent mode** (no skill) | Edit `SPEC-SEED-grokmvp.md` to match grill outcomes |
| 3 | Optional **`/grill-with-docs`** | Only if glossary terms need `Planner/CONTEXT.md` updates |
| 4 | Planner router | `create_phase_map` from seed (see `Planner/intake/START-HERE.md`) |

**Not for this path:** `/to-prd` (issue tracker PRD). **`/grill-me` does not write files.**

---

## Repo role (not greenfield)

- This repo is a **factory workspace**, not “only `Planner/` tree” (`context-index.md` intro is misleading for Grokmvp—fix in a later doc slice if desired).
- **First sign of real work:** `Planner/intake/SPEC-SEED-grokmvp.md` exists (from lift: chat summary → stub-shaped seed). Job A “grill seed” still **unchecked** in `Planner/intake/PLANNING-WORKFLOW.md`.
- **Clone target:** finished factory = portable `Planner/` + rules + docs + reference `Grokmvp/` scaffold; adoptee runs planner from seed.

---

## Decisions already locked (do not re-litigate in grill)

### Cursor rules vs planner docs

| Layer | Role |
|-------|------|
| `planner-artifacts.mdc` | Narrow: `Planner/**/*.md` — registry, packet schema, no thermonuclear on Lisp artifacts |
| `internal-doc-style.mdc` | Lisp shape; globs `assets/**,Planner/**/*.md` |
| `thermonuclear.mdc` | `alwaysApply: true` for product code review; **forbidden** on `Planner/`; defers planner Lisp to planner-artifacts |
| Unified router | **Authority** for slice workflow: read `router-state` → `STATUS` before coding; mode isolation |

**No new `planner-routed.mdc` needed** for normal workflow (user codes via router + always-on rules).

### Globs vs always-on

- Globs fire when matching files are **open/@‑referenced**, not on directory listing or “about to write.”
- **Thermonuclear stays always-on** so first write to product home still gets review discipline.
- Portable **literal** glob for product home (e.g. `PRODUCT/**`) only if factory generates slug per repo; otherwise `repo-layout` + body scoping.

### `Planner/AGENTS.md` (already edited)

- Read order corrected: router → STATUS → AGENTS → contracts README → context-index.
- **Architecture (echo) removed** → pointer + **architecture contract gate** (allowed archs in `Planner/contracts/`; `domain-spoke-architecture.md` default; deviation only via contract + router selection).
- Project layer mapping scoped to domain-spoke default; other archs via their contracts.
- Write boundaries / out of scope / verification / work style: **keep as-is** (user said leave alone).

### Other artifacts created/updated this session

- `Planner/CONTEXT.md` — glossary + grill closeout table
- `Planner/contracts/README.md` — artifact registry
- `Planner/contracts/domain-spoke-architecture.md` — one sentence: router defines architecture-decision-slice trigger
- `Planner/context-index.md` — CONTEXT step; numbering 1–8

---

## SPEC seed gaps (grill-me targets → then edit seed)

Update **`Planner/intake/SPEC-SEED-grokmvp.md`** to include outcomes not in seed today:

1. **P1 concrete outcomes** — replace vague “stabilize factory layout” with explicit deliverables, e.g.:
   - Cursor rules kit (conduct, safety, repo-layout, thermonuclear, planner-artifacts, internal-doc-style, mdc-authoring, doc-style)
   - Planner guardrails (AGENTS architecture gate, CONTEXT, contracts registry, context-index factory vs kit wording)
   - Optional `assets/` scaffold, `tests/` when slices require
   - Reference product `Grokmvp/` (hello scaffold—not “empty product” test)

2. **§6 Open decisions** — resolve in grill:
   - `single_phase` vs `multi_phase` for finishing P1
   - First implementation priority: rules/planner kit vs `hello.py` vs tests vs `docs/references/`

3. **§ “Already delivered” (new section)** — list manual/session work so planner does not redo:
   - `planner-artifacts.mdc`, registry, AGENTS architecture section, CONTEXT.md, read-order fix, domain-spoke router cross-ref

4. **Multi-architecture policy** — allowed architectures live in `Planner/contracts/`; domain-spoke default; no ad-hoc arch in slices (mirror AGENTS gate in seed constraints).

5. **Factory vs greenfield** — seed should state: configured factory when `SPEC-SEED-<slug>.md` + filled `project_layer_mapping` exist; not “empty Grokmvp/”.

6. **Intake path** — document origin: conversation summary → `SPEC-SEED.stub.md` shape → `SPEC-SEED-grokmvp.md` (optional one line in seed).

---

## Grill-me question queue (start here)

Use **`/grill-me`**. One question at a time; agent gives recommended answer.

1. P1 **definition of done** for “factory finished enough to clone”—what must be true on disk?
2. **single_phase** vs **multi_phase** for remaining P1 work?
3. Priority order: planner kit hardening vs product dogfood vs tests vs docs/reference mining?
4. Should **`assets/`** be created empty in P1 or only when a slice needs machine records?
5. **`context-index.md`** intro: two-mode (kit greenfield vs factory target)—in P1 or defer?
6. Declare **allowed architectures** list in `contracts/README.md` now (domain-spoke only) or wait for second arch file?

After grill: edit seed → check `PLANNING-WORKFLOW.md` Job A checkbox → update `STATUS.md` `next_action` (still says NEED_SOURCE grill—**stale**) → `create_phase_map` or `single_phase_project`.

---

## Key file paths

| Path | Role |
|------|------|
| `Planner/intake/SPEC-SEED-grokmvp.md` | **Edit target** after grill |
| `Planner/intake/SPEC-SEED.stub.md` | Minimum fields template |
| `Planner/intake/START-HERE.md` | Job A / B loop |
| `Planner/intake/PLANNING-WORKFLOW.md` | Checklist |
| `Planner/CONTEXT.md` | Glossary (reference, don’t bloat seed) |
| `Planner/slice-runs/grokmvp-phase1/STATUS.md` | `needs_slice_list` |
| `Planner/router-state.md` | Active run pointer |
| `Planner/contracts/codex-router-planner-unified.md` | Router entry |

---

## Verification note

No project test suite. After seed/planner doc edits: `python Grokmvp/hello.py` from repo root if product touched.
