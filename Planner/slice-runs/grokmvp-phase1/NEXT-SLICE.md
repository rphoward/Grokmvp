# NEXT-SLICE — grokmvp-phase1 / slice 1 (archived)

Reviewed 2026-06-02 — `passed_with_debt`. Record of record: `PROOF-LOG.md` entry 1.

Planned standard slice. Source is `Planner/intake/SPEC-SEED-grokmvp.md`
(sections 3 and 7). Phase intent lives inline in `SLICE-LIST.md` (single_phase).

```lisp
(extraction_next_slice
  (run_dir    "Planner/slice-runs/grokmvp-phase1")
  (slice      "1 — empty assets/ factory layout")
  (slice_type standard)

  (goal
    (name            "empty assets/ factory layout")
    (finish_line     "assets/ exists at repo root, tracked, empty except a .gitkeep; router and planner write no machine records there")
    (distance_closed "satisfies ro4: the user-owned machine-record home is present in the factory layout")
    (required_outcomes        (ro4))
    (optional_deferred_outcomes none))

  (source_packet
    (active_local_source "Planner/intake/SPEC-SEED-grokmvp.md — section 3 (commit empty assets/), section 7 (infrastructure -> assets/)")
    (historical_external_evidence none))

  (run_dir_validation
    "Same single_phase run grokmvp-phase1, first unpassed slice. Not a new phase; no new RUN_DIR required.")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes
      "factory layout / repo shell — no product capability spoke; this slice creates the infrastructure-layer machine-record home assets/")
    (layer_ownership
      (concept
        (name            "assets/ machine-record home")
        (owner           infrastructure)
        (must_not_change "domain and application ownership; assets/ stays user-owned; planner and router do not write records into it")))
    (architecture_guardrails
      "assets/ is user-owned; router and planner write no machine records there (VCS placeholder only)"
      "repo root is workspace shell; product code lives only under the product home (Grokmvp/ today)"
      "do not create forbidden physical folders (src lib apps top-level domain/ application/)")
    (ownership_decision
      (change_detected false)
      (if_false        not_applicable)))

  (inspect
    (inspect_first "confirm assets/ does not already exist at repo root (git status / ls); confirm no machine records are being added")
    (inspect       "SPEC-SEED-grokmvp.md sections 3 and 7; Planner/AGENTS.md write boundaries (assets/ user-owned, router/planner do not write there)"))

  (allowed_changes
    (note   "physical layer name infrastructure -> assets/ per project_layer_mapping")
    (create "assets/.gitkeep — empty placeholder so the otherwise-empty assets/ directory is tracked"))

  (constraints
    (do_not        "write any machine record, schema, or generated file into assets/ (placeholder only)")
    (do_not        "create forbidden physical folders (src lib apps top-level domain/ application/)")
    (do_not        "touch product code, Planner kit files, .cursor/rules, docs/, or root AGENTS.md in this slice")
    (minimum_change true))

  (proof
    (command "test -f assets/.gitkeep && [ \"$(ls -A assets)\" = \".gitkeep\" ] && echo OK")
    (manual  "assets/ exists at repo root, contains only .gitkeep, and is tracked; nothing else added")
    (optional "python Grokmvp/hello.py still runs from repo root (unaffected by this slice)"))

  (implementation_handback
    (completed     "2026-06-02")
    (writes        "assets/.gitkeep")
    (proof_ran     "test -f assets/.gitkeep equivalent on Windows; assets/ contains only .gitkeep")
    (proof_result  "OK")
    (optional      "python Grokmvp/hello.py -> Hello, world!"))

  (slice_state archived)
  (review_outcome passed_with_debt)
  (archived "2026-06-02")

  (next_action
    (mode         none)
    (note         "superseded; STATUS active_slice_file is none")))
```
