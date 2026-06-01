# PHASE-BACKLOG — cursor-landing-p3

Deferrals from [SLICE-LIST.md](SLICE-LIST.md) `optional_deferred_outcomes` and [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) `deferred_phases`. Recorded at P3 **final_closeout** (2026-05-24). Source: [STATUS.md](STATUS.md) `closeout_validation.deferrals`.

## Deferred phases (from PHASE-MAP)

| order | phase | suggested_run_dir | source |
|-------|-------|-------------------|--------|
| 4 | P4 — Publish & install path | `Planner/slice-runs/cursor-landing-p4/` | [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) |

## Carried from P2 / P3 optional outcomes

| item_id | description | phase | reason |
|---------|-------------|-------|--------|
| publishable-tree-scaffold | `cursor-landing/cursor-landing/` | P4 | Not P3 scope |
| validate-package-py | `scripts/validate-package.py` | P4 | After P3 dogfood pass on Kbupgrade |

**P3 dogfood (actual path):** `C:\Projects\Kbupgrade - Copy (4)` — substituted for PHASE-MAP Titan label (`C:\Antigravity_Dev\Titan_GenAI_KB_Builder_v5_Standalone`). Evidence: [tests/fixtures/dogfood-notes.md](../../../tests/fixtures/dogfood-notes.md), [PROOF-LOG.md](PROOF-LOG.md) § P3 closeout proof.

## Out of phase map (unchanged)

| item | note |
|------|------|
| Automated repo scanner | Until dogfood proves need |
| Team MCP merge templates | User-invoked only |
| Deep monorepo scan depth | Deferred |

## phase_lessons

P3 dogfood on Kbupgrade proved dual-host Q14 + multi-mdc without importing the fixture into the factory tree.
