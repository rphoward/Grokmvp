# Phase map (portable)

**Seed** — Start from `Planner/phase-map/PHASE-MAP.stub.md` (or author
`Planner/phase-map/PHASE-MAP.md` directly when you are ready).

**Authoritative file** — `Planner/phase-map/PHASE-MAP.md` is the multi-phase
intent record referenced at closeout in the v4 unified contract (paths in this
kit point under `Planner/`).

**Validation gate** — Before `create_slice_list` on a multi-phase project, run
the chat-only gate in `Planner/contracts/phase_map_review_prompt.md` (no file
writes; output is a single `(phase_validation_result …)` s-expression).

**Slice list** — After the phase map is approved (or single-phase path chosen),
create or update the active run’s `SLICE-LIST.md` per the schema contract.

Optional human-pasted verdict files may live under `Planner/phase-map/validation/`
if you adopt a local convention; the default gate remains chat-only.
