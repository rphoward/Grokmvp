# PHASE-BACKLOG — cursor-landing-p4

Out-of-map backlog only. Recorded at P4 **final_closeout** (2026-05-24). Source: [STATUS.md](STATUS.md) `closeout_validation.deferrals`. **P4 is the final mapped phase** — `project_complete`; no further `deferred_phases`.

## In scope this phase (delivered)

| item_id | description | slice | status |
|---------|-------------|-------|--------|
| publishable-tree-scaffold | Sole path `cursor-landing/cursor-landing/`; build/sync scripts repointed | 1 | done |
| install-readme-publish-align | Factory + publishable install/README/OVERVIEW | 2 | done |
| github-install-smoke | Recorded in install.md + fixtures README | 3 | done |
| troubleshooting-new-hosts | P1 hosts + install-path mistakes | 4 | done |
| validate-package-py | `scripts/validate-package.py` on publishable root | 5 | done |
| p4-proof-and-closeout-prep | PROOF-LOG § P4 closeout proof + fixtures maintainer subsection | 6 | done (`passed_closing` 2026-05-24) |

## Out of phase map

Aligned with [SLICE-LIST.md](SLICE-LIST.md) `optional_deferred_outcomes` and [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) § Out of phase map:

| item | note |
|------|------|
| Automated repo scanner | Until dogfood proves need |
| Team MCP merge templates | User-invoked only; no default merge into `.cursor/mcp.json` |
| Deep monorepo scan depth | Deferred |
| Re-publishing GitHub issues from PRD | Optional — not blocking P1–P4 |

## phase_lessons

Publishable tree is build output under `cursor-landing/cursor-landing/` — keep untracked until the user chooses to commit; re-run GitHub smoke after pushing P4 layout to default branch.

## P3 dogfood (authoritative)

**Path:** `C:\Projects\Kbupgrade - Copy (4)` — [dogfood-notes.md](../../../tests/fixtures/dogfood-notes.md), [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) P3 outcomes.

**Superseded label:** `C:\Antigravity_Dev\Titan_GenAI_KB_Builder_v5_Standalone` (seed/TUTORIAL only).
