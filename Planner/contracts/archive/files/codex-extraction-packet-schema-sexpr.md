# Codex Extraction Packet Schema — S-Expression Experimental

Status: v4. Aligned with v4 router-planner contract (post first-run fixes).

Changes from prior v4:

- `single_phase_slice_list` packet variant. Small features with no
  multi-phase decomposition embed `phase_intent` inline. No PHASE-MAP.md.
- `project_layer_mapping` packet. Conceptual planner vocabulary
  (`domain`, `application`, `infrastructure`, `presentation`) maps to
  project-specific physical layer names.
- `project_shape` field on STATUS recorded at slice-list creation.
- Explicit reminder that `blocking_items_resolution_log` entries
  require `status` (`flagged` on initial append).
- Explicit reminder that PROOF-LOG status lookup uses
  `passed_closing` or `passed_with_debt`, never bare `passed`.

```lisp
(packet_schema
  (domain extraction)
  (meaning "move already-working behavior from mixed source repo to cleaner target home with minimal behavior change")

  (atom_rules
    (keys           lowercase_snake_case)
    (enum_values    lowercase_snake_case)
    (quote          paths labels sentences)
    (forbid         reasoning_trace generic_roadmap_prose))


  ; ─── PROJECT SHAPE ────────────────────────────────────────────────────────

  (project_shape
    (values single_phase multi_phase)
    (recorded_on "RUN_DIR/STATUS.md project_shape field")
    (set_at create_slice_list)
    (consulted_by final_closeout phase_state_derivation)
    (legacy_fallback
      "completed runs without project_shape are treated as single_phase"))


  ; ─── PROJECT LAYER MAPPING ────────────────────────────────────────────────
  ; Per-project. Conceptual layer names from architecture_contract map to
  ; physical layer folder names. Planner records use conceptual names;
  ; writes (allowed_edits, forbidden_edits, file paths) use physical names.

  (packet project_layer_mapping
    (required
      active_project
      conceptual_to_physical
      forbidden_physical_folders
      source_of_truth)

    (conceptual_layer_values
      domain
      application
      infrastructure
      presentation)

    (conceptual_to_physical_keys
      conceptual_layer
      physical_name
      is_folder)

    (capex3_example
      (conceptual_to_physical
        (domain          core                          (is_folder true))
        (application     conceptual_core_boundaries    (is_folder false))
        (infrastructure  infrastructure                (is_folder true))
        (presentation    presentation                  (is_folder true)))
      (physical_only
        (bootstrap
          (owns "wires concrete adapters to use cases")
          (note "physical-only; not a planner layer")))
      (forbidden_physical_folders application domain)
      (source_of_truth "docs/AGENTS.md project boundaries section")))


  ; ─── EXTRACTION PHASE MAP ─────────────────────────────────────────────────

  (packet extraction_phase_map
    (trigger create_phase_map)
    (path    "Planner/phase-map/PHASE-MAP.md")
    (max_lines 140)
    (required
      migration_type
      goal
      phases
      move_list
      constraints
      leave_behind
      human_review
      next_action)
    (goal_keys
      source target finish_line done_proof phase_count
      move_to_target_after required_outcomes optional_deferred_outcomes
      non_negotiable_user_intent)
    (phase_keys
      number name repo depends proof_claim done
      required_outcomes deferred_outcomes)
    (next_action_keys mode run_dir source write_only do_not_write))


  ; ─── EXTRACTION SLICE LIST (multi_phase) ──────────────────────────────────

  (packet extraction_slice_list
    (trigger create_slice_list)
    (project_shape multi_phase)
    (max_lines 160)
    (required
      run_dir
      phase
      goal
      source_packet
      prior_closeout
      project_shape
      required_outcomes
      optional_deferred_outcomes
      slices
      constraints
      next_action)
    (goal_keys
      finish_line done_proof slice_count
      required_outcomes optional_deferred_outcomes
      non_negotiable_user_intent)
    (slice_keys
      number
      name
      slice_type
      status
      depends
      inspect
      done
      required_outcomes
      blocking_backlog_items
      corrective_slice_reason
      resolution_id
      decision_id)
    (next_action_keys mode write_only do_not_write))


  ; ─── EXTRACTION SLICE LIST (single_phase) ─────────────────────────────────

  (packet single_phase_slice_list
    (trigger create_slice_list_single_phase)
    (project_shape single_phase)
    (max_lines 160)
    (required
      run_dir
      phase_intent
      goal
      source_packet
      project_shape
      slices
      constraints
      next_action)

    (phase_intent_keys
      required_outcomes
      non_negotiable_intent
      constraints)
    (phase_intent_note
      "Embedded inline because no PHASE-MAP.md exists for single_phase projects.
       Serves the same authority role at plan_next_slice, plan_corrective_slice,
       final_closeout, and phase_contested_gate.")

    (goal_keys
      finish_line done_proof slice_count
      required_outcomes
      non_negotiable_user_intent)
    (slice_keys
      number
      name
      slice_type
      status
      depends
      inspect
      done
      required_outcomes
      blocking_backlog_items
      corrective_slice_reason
      resolution_id
      decision_id)
    (next_action_keys mode write_only do_not_write))


  ; ─── EXTRACTION NEXT SLICE (standard) ─────────────────────────────────────

  (packet extraction_next_slice
    (trigger plan_next_slice)
    (max_lines 180)
    (required
      run_dir
      slice
      slice_type
      goal
      source_packet
      architecture
      inspect
      allowed_changes
      constraints
      proof
      next_action)
    (slice_type_value standard)
    (goal_keys
      name finish_line distance_closed
      required_outcomes optional_deferred_outcomes)
    (optional run_dir_validation inspect_first)
    (architecture
      (contract "Planner/contracts/domain-spoke-architecture.md")
      (touched_spokes
        "spoke name — list every spoke this slice touches")
      (layer_ownership
        (note "use conceptual layer names per project_layer_mapping")
        (concept
          (name             "concept name")
          (owner            domain | application | infrastructure | presentation)
          (must_not_change  "layer boundary not in scope for this slice")))
      (architecture_guardrails
        "specific rule this slice must preserve")
      (ownership_decision
        (change_detected   true | false)
        (if_true
          (approved         true | false)
          (decision_slice   "path to architecture_decision_slice or pending"))
        (if_false
          not_applicable)))
    (allowed_changes_note
      "use physical layer names per project_layer_mapping")
    (inspect_keys inspect inspect_first)
    (proof_keys   manual command optional)
    (next_action_keys mode write_only do_not_write))


  ; ─── EXTRACTION CORRECTIVE SLICE ──────────────────────────────────────────

  (packet extraction_corrective_slice
    (trigger plan_corrective_slice)
    (max_lines 180)
    (required
      run_dir
      slice
      slice_type
      resolution_id
      reopen_reason
      goal
      source_packet
      prior_closeout
      architecture
      inspect
      allowed_changes
      constraints
      proof
      next_action)
    (slice_type_value corrective)
    (goal_keys
      name finish_line distance_closed
      required_outcomes corrective_slice_reason user_review_reopen_reason)
    (resolution_id
      (source       STATUS.closeout_validation.blocking_items_resolution_log)
      (rule         each_corrective_slice_binds_to_one_flagged_blocking_item)
      (verified_by  review_gate corrective_context))
    (architecture (same_as extraction_next_slice.architecture))
    (proof_keys   manual command optional)
    (next_action_keys mode write_only do_not_write))


  ; ─── EXTRACTION ARCHITECTURE DECISION SLICE ───────────────────────────────

  (packet extraction_architecture_decision_slice
    (trigger plan_architecture_decision_slice)
    (max_lines 160)
    (required
      run_dir
      slice
      slice_type
      implementation_allowed
      decision_id
      question
      current_owner
      proposed_owner
      reason_for_change
      rejected_options
      proof_to_accept
      architecture_guardrails
      next_action)
    (slice_type_value         architecture_decision)
    (implementation_allowed   false)
    (status_at_planning       slice_planned)
    (note
      "After this packet is written by plan_architecture_decision_slice,
       STATUS is slice_planned. Router sees slice_type=architecture_decision
       and emits READY_TO_REVIEW_DECISION. User starts fresh session and
       says: review the architecture decision slice. Router then routes
       to review_gate.")
    (decision_id
      (unique_per              architecture_decision_slice)
      (recorded_in_PROOF_LOG   on_pass)
      (consulted_by            ownership_change_gate)
      (note                    "use conceptual layer names in current_owner / proposed_owner"))
    (rejected_options
      (option
        (name   "option")
        (reason "why not")))
    (proof_to_accept
      (kinds test_assertion doc_reference path_reference))
    (architecture_guardrails
      "specific rules this decision must preserve")
    (forbid code_changes implement_step)
    (next_action_keys mode write_only do_not_write))


  ; ─── EXTRACTION FINAL CLOSEOUT ────────────────────────────────────────────

  (packet extraction_final_closeout
    (trigger final_closeout)
    (max_lines 200)
    (required
      run_dir
      phase
      project_shape
      required_outcomes
      proof_log_verification
      classification_to_implementation_trace
      blocking_items_resolution_log
      remaining_work_classification
      blocking_backlog_items
      optional_deferred_outcomes
      deferrals
      support_doc_sync
      next_action)

    (proof_log_verification_keys
      all_slices_passed
      proof_log_verified
      final_proof_rerun)

    (classification_to_implementation_trace_location
      "RUN_DIR/STATUS.md closeout_validation")

    (blocking_items_resolution_log
      (location "RUN_DIR/STATUS.md closeout_validation")
      (entry_keys
        resolution_id
        item_id
        required_outcome_blocked
        classification
        pass_number
        status)
      (status_values flagged resolved deferred)
      (initial_append_rule
        "When closeout appends a new entry, status MUST be flagged.
         resolved is set later by state_carry when a matching
         PROOF_LOG corrective slice is found.
         deferred is set by phase_contested_gate when user approves deferral.")
      (purpose "second-pass closeout reads prior log, marks resolved items via PROOF_LOG resolution_id match, then re-classifies"))

    (deferrals
      (entry_keys
        item_id
        approved_at
        approval_source
        reason)
      (purpose "user approved a previously contested item as deferred during phase_contested_gate"))

    (remaining_work_classification_keys
      optional
      explicit_deferred
      required_remaining
      failed)

    (support_doc_sync_keys
      AGENTS
      context_index
      active_run_state_fields_synced
      next_slice_cleanup)

    (terminal_state_derivation
      (rule
        "STATUS=complete after this packet writes.
         Outer phase_state is derived by phase_state_derivation:
         project_shape=single_phase → project_complete;
         project_shape=multi_phase + deferred_phases empty → project_complete;
         project_shape=multi_phase + deferred_phases nonempty → phase_sealed."))

    (next_action_keys mode write_only do_not_write))


  ; ─── PROOF LOG ENTRY ──────────────────────────────────────────────────────

  (proof_log_entry
    (required
      slice_number
      slice_name
      slice_type
      status
      proof
      reviewer_note)
    (slice_type_dependent_fields
      (standard              none_additional)
      (corrective            resolution_id why_prior_closeout_was_insufficient)
      (architecture_decision decision_id question approved_owner_change))
    (status_values
      passed_closing
      passed_with_debt)
    (lookup_rule
      "Any consumer (ownership_change_gate, final_closeout state_carry, etc.)
       that filters PROOF-LOG by status MUST accept both passed_closing and
       passed_with_debt. Filtering by bare 'passed' is invalid — that value
       does not exist in the status enum."))


  ; ─── FIELD CONTRACTS ──────────────────────────────────────────────────────

  (field_contracts

    (required_outcomes
      "Phase or slice outcomes that must be physically satisfied before
       closeout; cannot move to PHASE-BACKLOG without explicit user deferral.
       In multi_phase: lives in PHASE-MAP.md.
       In single_phase: lives in SLICE-LIST.md phase_intent section.")

    (optional_deferred_outcomes
      "Work that is optional, explicitly out of scope, or user-approved
       for later backlog.")

    (project_shape
      (required true)
      (type     enum)
      (values   single_phase multi_phase)
      (recorded_on STATUS_md)
      (set_at      create_slice_list)
      (purpose     "drives terminal state derivation at closeout and route through router"))

    (slice_type
      (required true)
      (type     enum)
      (values   standard corrective architecture_decision)
      (recorded_on NEXT_SLICE_md SLICE_LIST_md PROOF_LOG_md)
      (forbid   absent_on_planned_or_passed_slice))

    (resolution_id
      (required_when (slice_type corrective))
      (forbidden_when (slice_type standard | architecture_decision))
      (binds_to    STATUS.closeout_validation.blocking_items_resolution_log.entry)
      (purpose     "links corrective slice to the specific flagged blocking item it resolves"))

    (decision_id
      (required_when (slice_type architecture_decision))
      (forbidden_when (slice_type standard | corrective))
      (consulted_by ownership_change_gate)
      (purpose      "links approved architecture decision to subsequent standard slice"))

    (corrective_slice_reason
      "Why this slice exists after a reviewed, closing, or completed run
       was found not to satisfy required phase intent.")

    (user_review_reopen_reason
      "User review statement or summary that reopened a passed_closing,
       final_closeout, or complete run.")

    (blocking_backlog_items
      "Backlog records that block the named app goal and must be promoted
       into the current phase or explicitly deferred by the user.")

    (approved_phase_map_or_source_packet
      "Direct slice-list planning may use either an approved phase map
       (multi_phase) or inline phase_intent (single_phase). Both supply
       required_outcomes, non_negotiable_intent, and constraints.")

    (source_packet
      "Named source material used to plan the phase or slice. In
       standalone targets, this must distinguish active_local_source
       from historical_external_evidence. External source-repo paths
       must not be required unless the user explicitly requests
       source-repo reinspection.")

    (prior_closeout
      "Previous STATUS, PROOF-LOG, PHASE-BACKLOG, or closeout source
       that this plan carries forward.")

    (run_dir_validation
      "Evidence that the RUN_DIR is new for a new phase, or reused only
       because the task is explicit repair/corrective-slice work.")

    (architecture
      (required true)
      (type     record)
      (purpose  "architecture ownership proof required before slice proceeds")
      (gate     "slice must not be written without a complete architecture block"))

    (touched_spokes
      (required true)
      (type     list_of_strings)
      (purpose  "every spoke this slice touches — no silent touches")
      (forbid   empty_list))

    (layer_ownership
      (required true)
      (type     record_per_new_concept)
      (purpose  "explicit owner layer for every new concept introduced")
      (uses     conceptual_layer_names_from_project_layer_mapping)
      (forbid   omitting_concept_introduced_by_allowed_changes))

    (architecture_guardrails
      (required true)
      (type     list_of_strings)
      (purpose  "specific rules from architecture contract this slice must preserve")
      (forbid   generic_placeholder_text))

    (allowed_edits
      (required true)
      (type     list_of_paths)
      (uses     physical_layer_names_from_project_layer_mapping)
      (forbid   paths_under_forbidden_physical_folders))

    (forbidden_edits
      (required true)
      (type     list_of_paths_or_patterns)
      (uses     physical_layer_names_from_project_layer_mapping))

    (ownership_decision
      (required true)
      (type     record)
      (purpose  "explicit gate on whether ownership change was detected and handled")
      (rule
        (if (change_detected true AND approved false)
          → "architecture_decision_slice required before this slice may proceed")
        (if (change_detected true AND decision_slice missing)
          → "blocked — ownership change without decision record is forbidden")
        (if (change_detected false)
          → not_applicable_is_valid)))

    (implementation_allowed
      (required_when (slice_type architecture_decision))
      (value         false)
      (purpose       "architecture decision slices record a decision; they do not implement code"))

    (classification_to_implementation_trace
      "Closeout evidence that each required classification or slice outcome
       was physically implemented, deferred by explicit user decision, or
       classified as optional.")

    (blocking_items_resolution_log
      "Accumulating record under STATUS.closeout_validation that tracks
       blocking items flagged across closeout passes. Each entry has
       resolution_id, item_id, required_outcome_blocked, classification,
       pass_number, and status. Initial append MUST set status=flagged.
       Status moves flagged → resolved when a PROOF_LOG entry with
       slice_type=corrective, status in (passed_closing, passed_with_debt),
       and matching resolution_id is found by state_carry.
       Status may be set to deferred by phase_contested_gate.")

    (deferrals
      "Record under STATUS.closeout_validation of items the user explicitly
       approved as deferred during phase_contested_gate. Each entry has
       item_id, approved_at, approval_source, and reason. Allows the
       phase_contested → final_closeout exit without forcing a corrective slice.")

    (support_doc_sync
      "Closeout evidence that AGENTS.md, Planner/context-index.md, and other
       support docs that repeat active run state were updated or
       intentionally left to defer to STATUS.md.")

    (next_slice_cleanup
      "Closeout convention for the root NEXT-SLICE.md after archive:
       remove it, or mark it reviewed and set STATUS.active_slice_file to none."))


  ; ─── ORDERING ─────────────────────────────────────────────────────────────

  (ordering
    (phase_map
      goal phases move_list constraints leave_behind human_review next_action)
    (slice_list
      goal source_packet prior_closeout project_shape
      required_outcomes optional_deferred_outcomes
      slices constraints next_action)
    (single_phase_slice_list
      phase_intent goal source_packet project_shape
      slices constraints next_action)
    (next_slice
      goal source_packet run_dir_validation
      architecture inspect allowed_changes constraints proof next_action)
    (corrective_slice
      goal source_packet prior_closeout reopen_reason resolution_id
      architecture inspect allowed_changes constraints proof next_action)
    (architecture_decision_slice
      question current_owner proposed_owner reason_for_change
      rejected_options proof_to_accept architecture_guardrails
      decision_id implementation_allowed next_action)
    (final_closeout
      project_shape required_outcomes proof_log_verification
      classification_to_implementation_trace
      blocking_items_resolution_log
      remaining_work_classification
      blocking_backlog_items optional_deferred_outcomes
      deferrals support_doc_sync next_action))


  ; ─── DEFAULT CONSTRAINTS ──────────────────────────────────────────────────

  (default_constraints
    (do_not copy_whole_repo)
    (do_not write_target_repo_before_approved_phase_or_approved_single_phase_slice_list)
    (do_not migrate_javascript_by_default)
    (do_not redesign_ui)
    (do_not add_deployment)
    (do_not add_accounts)
    (do_not add_saved_deals)
    (do_not create_product_roadmap)
    (do_not create_forbidden_physical_folders_per_project_layer_mapping)))
```
