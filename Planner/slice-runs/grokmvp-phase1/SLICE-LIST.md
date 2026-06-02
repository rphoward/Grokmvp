# SLICE-LIST — grokmvp-phase1 (single_phase)

Inline-intent slice list for finishing the clone-space factory (P1). Source is
`Planner/intake/SPEC-SEED-grokmvp.md`. No `PHASE-MAP.md`; `phase_intent` below
carries required outcomes, non-negotiable intent, and constraints.

```lisp
(single_phase_slice_list
  (run_dir       "Planner/slice-runs/grokmvp-phase1")
  (project_shape single_phase)

  (phase_intent
    (required_outcomes
      (ro1 "Intake tells the truth: factory vs greenfield documented; PLANNING-WORKFLOW Job A grill-seed checkbox satisfied")
      (ro2 "Planner/context-index.md reads as a factory workspace, not 'only this Planner/ tree'; adopters pointed to SPEC-SEED.stub.md")
      (ro3 "Product home aligned to project-code/ across disk, project_layer_mapping, .cursor/rules/repo-layout.mdc, root AGENTS.md, and seed section 7; python project-code/hello.py passes from repo root")
      (ro4 "Empty assets/ committed as factory layout (user-owned machine-record home)")
      (ro5 "Router runs this seed through slice-list approval and phase closeout, proven by final_closeout with PROOF-LOG entries"))
    (non_negotiable_intent
      "Product and app code only under the single product home (Grokmvp/ now, project-code/ after rename); repo root is workspace shell"
      ".cursor/rules/ are operational guardrails; normative architecture lives in Planner/contracts/; routed work uses an allowed contract (default domain-spoke); the five stub families are not selectable in P1"
      "assets/ is user-owned; router and planner do not write machine records there"
      "no active planner run state in root AGENTS.md"
      "do not reintroduce cursor-landing factory paths, publish bundles, or /cursor-landing dogfood")
    (constraints
      "no stub architecture selection in P1 (research only)"
      "no separate product GitHub repo, auto MCP merge, deployment, or accounts unless a future slice selects them"
      "do not copy whole repo; do not create forbidden physical folders (src lib apps top-level domain/ application/)"))

  (goal
    (finish_line "clone-space factory finished: truthful intake, factory-mode context-index, empty assets/, product home named project-code/, router loop closed out on this seed")
    (done_proof  "python project-code/hello.py passes from repo root; repo grep shows no stale product-path Grokmvp/ outside history/docs; STATUS reaches complete via final_closeout")
    (slice_count 4)
    (required_outcomes (ro1 ro2 ro3 ro4 ro5))
    (non_negotiable_user_intent "finish the factory so it can be cloned; do not redo manual kit work already on disk (seed section 6)"))

  (source_packet
    (active_local_source        "Planner/intake/SPEC-SEED-grokmvp.md")
    (supporting                 "docs/references/HANDOFF-grill-spec-seed-2026-06-02.md; Planner/contracts/README.md allowed-architectures; seed section 9 rename checklist")
    (historical_external_evidence none))

  (slices
    (slice
      (number  1)
      (name    "empty assets/ factory layout")
      (slice_type standard)
      (status  passed_with_debt)
      (debt
        (classification follow_up)
        (reason "Whitelist !assets/.gitkeep in root .gitignore so empty assets/ is VCS-visible"))
      (depends none)
      (inspect "repo root (assets/ absent today); seed sections 3 and 7; Planner/AGENTS.md write boundaries")
      (done    "assets/ exists at repo root, tracked, empty except a .gitkeep; router and planner write nothing there")
      (required_outcomes      (ro4))
      (blocking_backlog_items none))
    (slice
      (number  2)
      (name    "intake truthfulness and Job A")
      (slice_type standard)
      (status  passed_closing)
      (reviewed "2026-06-02")
      (depends none)
      (inspect "Planner/intake/PLANNING-WORKFLOW.md (Job A grill checkbox unchecked); README.md START-HERE.md PLANNER-DIRECTION.md; seed section 8 factory vs greenfield")
      (done    "Job A grill-seed checkbox checked; intake states the factory vs greenfield kit-paste distinction")
      (required_outcomes      (ro1))
      (blocking_backlog_items none))
    (slice
      (number  3)
      (name    "context-index factory mode")
      (slice_type standard)
      (status  passed_closing)
      (reviewed "2026-06-02")
      (depends none)
      (inspect "Planner/context-index.md (intro reads 'only this Planner/ tree'); seed section 8")
      (done    "context-index.md frames factory workspace vs greenfield kit paste; adopters use SPEC-SEED.stub.md")
      (required_outcomes      (ro2))
      (blocking_backlog_items none))
    (slice
      (number  4)
      (name    "rename product home to project-code/")
      (slice_type standard)
      (status  pending)
      (depends (2 3))
      (inspect "seed section 9 checklist; Grokmvp/ (README.md LICENSE.md hello.py); .cursor/rules/repo-layout.mdc; project_layer_mapping in codex-router-planner-unified.md; root AGENTS.md; repo grep for Grokmvp/ and grokmvp")
      (done    "Grokmvp/ renamed to project-code/; repo-layout factory product-home exception added; project_layer_mapping paths and root AGENTS.md verification path updated; seed section 7 interim note removed; grep clean outside history/docs; python project-code/hello.py passes from repo root")
      (required_outcomes      (ro3))
      (blocking_backlog_items none)))

  (constraints
    (do_not create_forbidden_physical_folders)
    (do_not select_stub_architecture)
    (do_not reintroduce_cursor_landing_paths)
    (do_not write_to_assets_as_router_or_planner)
    (do_not store_active_run_state_in_root_AGENTS))

  (next_action
    (mode        needs_next_slice_plan)
    (next        "slice 4 — rename product home to project-code/ (ro3)")
    (write_only  "RUN_DIR/NEXT-SLICE.md and RUN_DIR/STATUS.md on plan")
    (do_not_write "PHASE-MAP.md; Grokmvp/ rename until slice 4 planned")))
```

**Deferred (optional, not slices unless you ask):** minimal smoke-test harness
under `tests/`, and further architecture-stub research — both per seed section 5;
no stub selection in P1.
