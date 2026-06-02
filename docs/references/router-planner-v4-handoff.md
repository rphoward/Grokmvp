# Router Planner v4 — Handoff Brief

> **Reference only** — lives under `docs/references/`, not in `Planner/contracts/`.
> For current work use `Planner/contracts/README.md` read order (unified router + schema + domain-spoke).

## Purpose of this document

Mid-rewrite continuation point. v4 contract and schema have been written and
revised to fold in first-run fixes plus the multi-phase bootstrap fix. The
user's broader roadmap still has a deferred item: review cadence.

**Fresh-session opening move:** read this brief only if continuation context is
needed, then follow `README.md` read order from this repo before touching
anything. Specifically:

- Confirm the review-cadence evolution remains deferred if that question
  becomes relevant; the user has stated it should wait until architecture flow
  is solid.

Do not start v5 work, do not "improve" the contract structurally, and do
not propose new shapes unless the user explicitly asks. v4 just stabilized;
let it run.

---

## Current v4 file set (post-revision)

The fresh session should follow `README.md` for read order. The functional
contract files are:

- `codex-router-planner-unified.md` — v4 contract. Folds in F1–F6 fixes,
  `single_phase_project` path, `phase_initialized` bridge, and
  `project_layer_mapping` section.
- `codex-extraction-packet-schema-sexpr.md` — v4 schema. Adds
   `single_phase_slice_list` packet variant, `project_layer_mapping` packet,
   `project_shape` field contract.

The unchanged reference document:

- `domain-spoke-architecture.md` — v4 references it as the conceptual
  ownership rule set. No changes needed unless `architecture_decision_slice`
  vocabulary diverges from the architecture contract's `architecture_decision_slice`
  record format (it currently matches).

---

## First-run findings and how v4 resolves them

User ran v3-ish contract on a small feature and reported these. v4 (post-revision)
folds in fixes for all five.

**F1 [P1] — Router routed completed STATUS to `create_phase_map`.**

Symptom: PHASE-MAP.md absent, STATUS=complete, router ignored RUN_COMPLETE and
tried to create a phase map.

v4 fix: Router order flipped. Completed phase states (`project_complete`,
`phase_sealed`) are checked first. The phase-authoring branch only fires when
`(no phase_map AND no completed_status)` or `user_says create_phase_map`.
`phase_state_derivation` has a legacy fallback:
`STATUS complete AND no phase_map AND no project_shape → project_complete`.
This lets v3-era completed runs route correctly without backfill.

**F2 [P1] — `plan_architecture_decision_slice` set `slice_review_needed`,
bypassing `READY_TO_REVIEW_DECISION`.**

Symptom: handoff to fresh-session review unreachable.

v4 fix: `plan_architecture_decision_slice` now sets `(set_STATUS slice_planned)`.
Router's `slice_planned` case switches on `slice_type`; the `architecture_decision`
arm emits `READY_TO_REVIEW_DECISION` by default, or routes to `review_gate` when
the user explicitly says review. Hard stop added:
`architecture_decision_slice_does_not_skip_review`.

**F3 [P2] — `ownership_change_gate` looked for PROOF-LOG status `passed`,
schema only has `passed_closing` / `passed_with_debt`.**

Symptom: approved architecture decisions failed lookup; could repeatedly
block standard slices.

v4 fix: Three call sites updated to `(status_in passed_closing passed_with_debt)`:
`ownership_change_gate.response.until`, `ownership_change_gate.lookup.filter`,
`final_closeout.state_carry.lookup`. Schema's `proof_log_entry` got a
`lookup_rule` clause forbidding bare `passed`. Hard stop:
`proof_log_status_lookup_does_not_use_bare_passed`.

**F4 [P2] — `blocking_items_resolution_log` entries written without `status`.**

Symptom: schema-required field missing; state_carry can't correctly
identify which entries are still flagged.

v4 fix: `final_closeout.classify_remaining_work.case_c` writes the entry
with `(status flagged)` explicitly. Schema's
`blocking_items_resolution_log.initial_append_rule` spells out the invariant:
initial append is always `flagged`; `state_carry` sets to `resolved` when a
matching PROOF-LOG entry exists; `phase_contested_gate` may set to `deferred`.
Hard stop: `closeout_does_not_append_blocking_item_without_status_flagged`.

**F5 [P2] — Contract used `application` as concrete layer; capex3 AGENTS.md
forbids that target folder.**

Symptom: contract vocabulary clashed with project-physical reality.

v4 fix: New `project_layer_mapping` section. Architecture contract still uses
conceptual names (`domain`, `application`, `infrastructure`, `presentation`) —
those are the ownership rules. `project_layer_mapping` maps conceptual to
physical per project:

- capex3: `domain → core` (folder), `application → conceptual_core_boundaries`
  (no folder; lives inside core/), `infrastructure → infrastructure` (folder),
  `presentation → presentation` (folder).
- `bootstrap` listed as physical-only, not a planner layer.
- `forbidden_physical_folders: application domain` for capex3.

Planner uses conceptual names in `layer_ownership` and decision records;
physical names in `allowed_edits`, `forbidden_edits`, file paths. Hard stop:
`planner_does_not_create_physical_folders_listed_as_forbidden_in_project_layer_mapping`.

AGENTS.md remains source of truth; the contract makes the rule machine-readable
for planning gates.

---

## Shape additions in v4

Two additions that aren't bug fixes but resolve shape mismatches the user
hit on the first run.

**`single_phase_project` path.** A small feature that doesn't need multi-phase
decomposition skips PHASE-MAP.md entirely. The slice list embeds phase intent
inline (`required_outcomes`, `non_negotiable_intent`, `constraints` in a
`phase_intent` section). Mode: `create_slice_list_single_phase`. Closeout
routes directly to `project_complete`. Triggers in the router:
`user_says single_phase_project`, `user_says small_feature`, or
`(source_present AND user_says create_slice_list AND user_signals_no_phase_plan)`.

**`project_shape` on STATUS.md.** Either `single_phase` or `multi_phase`,
recorded at slice-list creation. Drives `phase_state_derivation`'s decision
between `project_complete` and `phase_sealed` at closeout. Legacy fallback:
completed runs with no `project_shape` and no `phase_map` are treated as
`single_phase`.

---

## Resolved gap: multi-phase bootstrap

The original gap was a circular dependency: `phase_active` required
`project_shape multi_phase`, but `project_shape` was only written by
`create_slice_list`, and the router could not reach `create_slice_list` before
`phase_active`.

**Scenario.** User runs `create_phase_map` in session 1 → PHASE-MAP.md
written. User approves. User creates RUN_DIR for phase 1 manually. User
starts fresh session 2 and asks for slice list creation.

**State at session 2 start.**

- `phase_map_presence` = true
- STATUS.md absent (fresh RUN_DIR)
- `project_shape` not yet recorded
- user_request = create slice list

**Current fix.** The unified contract adds `phase_initialized`: approved
PHASE-MAP, live RUN_DIR, no STATUS/project_shape yet. The router handles that
state before `phase_active` and routes to `create_slice_list` when source is
present. `create_phase_map` still does not write RUN_DIR/STATUS state.

---

## Workflow context (carry forward from prior brief)

Sequential, user-gated, no automation pressure. User's stated rhythm:

1. Discuss feature in chat, solidify intent.
2. If larger, initialize unified planner, ask for a phase plan, planner
   writes phase map.
3. User approves phase map.
4. User asks for slice map for next phase. Planner writes SLICE-LIST.md.
5. For each slice in order: plan slice → implement slice → review slice.
6. Cycle back to ask for next slice map (or next phase's slice map).
7. Continue until all slices of all phases are complete.

For small features, steps 2–4 collapse: user provides seed, planner writes
single_phase slice list inline.

---

## Deferred — review cadence

User raised this during v4 design and explicitly deferred:

> "this was written to granularly work on a problem that needed lots of
> reviews. In use it is very slow, like writing code manually kind of slow.
> your last diagram had a state where everything converged on review needed.
> I am thinking the bottleneck is that review needed has to evolve to after
> all the slices are written and implemented and the whole phase is complete."

User decision: "forget the evolution for now, I will research evolving my
workflow after I learn how to get architecture done well."

**Do not raise this unprompted in the fresh session.** Architecture comes
first. If the user surfaces it after running v4 for a while, the analysis
from the v4-design conversation is summarized here:

The slowness comes from `slice_review_needed` being the convergence point
in the slice tier — every slice requires a full session at the review gate
before the next slice can start. Three lighter-to-heavier evolutions
considered:

1. *Compound session: review-then-plan-next.* Already half-allowed by the
   contract (compound modes forbidden "unless explicit_automation_mode_declared").
   Allowing `review_gate` + `plan_next_slice` in one session on a passing
   review cuts session count ~50% without changing review cadence.

2. *Tiered review.* Each slice marked at planning time with
   `review_weight = quick | full`. Quick slices get a sanity check; full
   slices stay as today. Architecture-touching, ownership-change, boundary
   work stays full. Wiring, cosmetic, mechanical work goes quick.

3. *Phase-end review.* Slices implement back-to-back; review converges on
   `phase_review_needed` before `final_closeout`. Biggest change. Loses the
   per-slice safety net (drift in slice N affects how slice N+1 is built);
   gains the most speed. Requires bookkeeping to map phase-end findings back
   to originating slices.

Recommended progression when the user is ready: 1 → 2 → maybe 3, with at
least one project run at each level before moving up.

---

## Things not to do in the fresh session

- Don't restructure the contract for elegance. v4 just stabilized.
- Don't add features the user hasn't asked for. The bootstrap gap is the
  only known structural issue; everything else should come from user
  observation during real use.
- Don't propose a v5 unless the user names it.
- Don't redraw diagrams. The user said earlier: "the diagram names are not
  sources of truth, no need to redraw or rename, they were created under
  context duress for your reference only." If diagrams are needed for a
  specific fix, draw them disposable; don't try to canonicalize.
- Don't volunteer review-cadence evolution analysis. Architecture first.

---

## Style notes for the fresh session

- User prefers real-lisp-shaped pseudo-code in the contract: label-bound
  nesting, deeply nested where the logic earns it, no snake_case prose
  phrases as pseudo-identifiers. Single-line predicate-action pairs OK
  where logic doesn't need nesting.
- Critique mode is explicit-only. User's workflow is create → review.
  Don't volunteer concerns about user choices unless asked. When asked,
  surface assumptions, present alternatives, push back honestly, offer
  paths forward.
- Brief opening moves are welcomed. Long preamble is not.

---

## Next moves in priority order (when fresh session opens)

1. Hold until user has run v4 on real work and reports back. Do not
   propose further changes unsolicited.
2. If user surfaces review-cadence pain, present the three-tier evolution
   summary above and ask which tier they want to design first.
