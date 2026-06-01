# Your checklist (matches the unified planner)

**Plain steps:** [START-HERE.md](START-HERE.md)  
**Seed + router notes:** [PLANNER-DIRECTION.md](PLANNER-DIRECTION.md)

---

## Job A — Seed (before planner)

- [ ] Grill [SPEC-SEED-cursor-landing.md](SPEC-SEED-cursor-landing.md) until phases and constraints are solid
- [x] `project_layer_mapping` filled for `cursor-landing` in unified contract (once; 2026-05-22 closeout)

## Job B — Planner loop

- [ ] Copy `slice-runs/_template` → `slice-runs/<run>/`; wire [router-state.md](../router-state.md)
- [ ] Ask planner: **create phase map** from seed → read [PHASE-MAP.md](../phase-map/PHASE-MAP.md) → **you OK**
- [ ] Ask planner: **create slice list** → read SLICE-LIST → **you OK**
- [ ] Repeat: planner plans next slice → you say **implement** → review → until phase closeout
- [ ] Next phase: new run folder if PHASE-MAP says so

## After planner

- [ ] Dogfood `/cursor-landing` on **another** repo ([install.md](../../references/install.md))

---

## Not this

- Paste Brief 1/2/3 stacks (see [PLANNER-AGENT-BRIEF.md](PLANNER-AGENT-BRIEF.md) — deprecated as primary workflow)
- README as seed
- Implement before you OK phase map and slice list
