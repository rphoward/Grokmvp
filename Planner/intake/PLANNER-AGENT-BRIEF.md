# Planner prompts (optional shortcuts only)

**Primary guide:** [START-HERE.md](START-HERE.md) — the unified router routes from **seed + STATUS**, not from a stack of pasted briefs.

Use the phrases below only if you want shorthand. The agent should still read `router-state.md`, active `STATUS.md`, and [codex-router-planner-unified.md](../contracts/codex-router-planner-unified.md).

---

## Deprecated workflow

Earlier versions told you to paste “Brief 0–5” for every step. That does **not** match the v4 unified planner. Keep this file for **short phrases**, not as the main process.

---

## Short phrases (match router modes)

| Router mode | You can say |
|-------------|-------------|
| `create_phase_map` | “Create the phase map from `Planner/intake/SPEC-SEED.stub.md`.” (or your seed path) |
| Phase map review | “Validate PHASE-MAP with phase_map_review_prompt.” |
| `create_slice_list` | “Create the slice list.” |
| `approve_or_revise_slice_list` | “Approve the slice list.” / “Revise slice N in the list.” |
| `plan_next_slice` | (Usually automatic after approval) |
| `implement_slice` | “Implement.” |
| `resume_slice` | “Resume the active slice.” |

---

## Seed path

```text
Planner/intake/SPEC-SEED.stub.md
```

P1 archive: `docs/references/SPEC-SEED-grokmvp.md`

Repo constraint:

```text
Product code under project-code/ only. See repo-layout.mdc and unified contract project_layer_mapping.
```
