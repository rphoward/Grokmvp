# Handoff — zero-setup cloneable factory (no proof dogfood)

**Session decision (2026-06-02):** Remove `grokmvp-phase1` from active `Planner/slice-runs/` on the default branch. Archive under [`grokmvp-phase1-proof/`](grokmvp-phase1-proof/). Default router points at [`Planner/slice-runs/factory/`](../../Planner/slice-runs/factory/).

**Next session goal:** Turn this repo into a **full working factory** that clones from GitHub and goes **straight to work** with the unified planner and a **real spec seed**—not a museum demo with `grokmvp-phase1` as the default active run.

**User constraint (explicit):** Zero setup after clone; **not** “proof / dogfood / completed run on disk by default.” Historical P1 artifacts may stay in `docs/references/` only. **Default router + intake must not assume P1 is done.**

---

## Target state (definition of done)

After clone, a new user can:

1. `git clone` → open repo → read root `README.md` (one path, no “proof run vs active queue” confusion).
2. Grill/fill **`Planner/intake/SPEC-SEED.stub.md`** (or a renamed factory seed still under intake—not the archived grokmvp file).
3. Say **single_phase_project** or **create phase map** → router reaches **`create_slice_list` / `plan_next_slice`** without manual RUN_DIR surgery.
4. **`Planner/router-state.md`** points at a **live, empty-or-ready run** (not `complete`, not `_template` as writable active run).
5. **`project-code/`** is the only product home; **`python project-code/hello.py`** passes from repo root.
6. **`assets/`** exists and is VCS-visible (slice-1 gitignore debt resolved).
7. No duplicate **`Grokmvp/`** tree on disk.
8. Push to GitHub matches local “factory product” layout (no “works only on one machine” drift).

**Not required:** Preserving `grokmvp-phase1` under `Planner/slice-runs/` for newcomers (archived under `docs/references/grokmvp-phase1-proof/`).

---

## Open decision (resolved)

| Option | Verdict |
|--------|---------|
| Remove / relocate from default export | **Chosen** — P1 under `docs/references/grokmvp-phase1-proof/` |
| Keep in `slice-runs/` as archive | Rejected for default branch |
| Museum (router → complete phase1) | Rejected |

---

## Verification checklist

```text
git clone <repo> && cd <repo>
test ! -d Grokmvp
test -d project-code && python project-code/hello.py  # Hello, world!
test -f assets/.gitkeep && git check-ignore -v assets/.gitkeep  # should NOT be ignored
# Read router-state → active STATUS: NOT complete
# Read intake seed: grill SPEC-SEED.stub (or factory seed when added)
# Agent: "create slice list from <seed>" → STATUS becomes slice_list_draft or needs_next_slice_plan, NOT RUN_COMPLETE
```
