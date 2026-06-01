# Codex Router Planner — Unified

Status: v4. Replaces v3. This file folds in the first-run fixes:
F1 ordering (completed run dominates missing phase_map),
F2 (`plan_architecture_decision_slice` sets `slice_planned`, not `slice_review_needed`),
F3 (`ownership_change_gate` accepts `passed_closing` and `passed_with_debt`, not `passed`),
F4 (`blocking_items_resolution_log` entries are written with `(status flagged)`),
F5 (`project_layer_mapping` added; conceptual planner layers map to project-specific physical layer names),
F6 (`phase_initialized` bridges approved multi-phase PHASE-MAP to first slice-list creation before `project_shape` exists).

Two shape additions:

- `single_phase_project` path. A small feature with no multi-phase decomposition
  skips PHASE-MAP.md. Slice list embeds phase intent inline. Closeout pass
  routes directly to `project_complete`.
- `project_layer_mapping` section. Conceptual planner vocabulary
  (`domain`, `application`, `infrastructure`, `presentation`) maps to
  project-specific physical layer names. Replace `{{PROJECT_SLUG}}` and
  each `FILL_*` placeholder in the s-expression block below to match this
  repository; align with `AGENTS.md` layer and folder rules.

```lisp
(router_planner

  ; ─── PATHS ───────────────────────────────────────────────────────────────

  (paths
    (self         "Planner/contracts/codex-router-planner-unified.md")
    (schema       "Planner/contracts/codex-extraction-packet-schema-sexpr.md")
    (architecture "Planner/contracts/domain-spoke-architecture.md")
    (phase_map    "Planner/phase-map/PHASE-MAP.md"))


  ; ─── CONTRACT ─────────────────────────────────────────────────────────────

  (contract
    (one_session
      (one_mode)
      (one_legal_action))
    (memory
      (forbid    chat_memory)
      (authority disk_state))
    (mode_isolation
      (planning
        (forbid implementation))
      (implementation
        (forbid planning)
        (forbid review))
      (review
        (forbid product_code)
        (forbid next_slice_plan)))
    (writes
      (stop_after allowed_writes_complete))
    (intent
      (preserve non_negotiable_user_intent)
      (forbid   convert_required_phase_work_to_backlog_without_user_decision))
    (sources
      (standalone_target           uses_local_contracts_and_run_control)
      (external_source_repo_paths  historical_evidence_only)
      (override                    user_explicitly_requests_source_repo_reinspection))
    (compound_modes
      (forbid     (sequence plan implement review closeout))
      (allow_only explicit_automation_mode_declared))
    (doc_conflict
      (authority router_state_selected_RUN_DIR_then_STATUS_md)
      (action    repair_disagreeing_docs_before_continuing)))


  ; ─── ACTIVE RUN POINTER ───────────────────────────────────────────────────
  ; Per-run STATUS.md files are durable run records, not global active-state
  ; records. The active run must be resolved before STATUS fields are
  ; interpreted.

  (active_run_pointer
    (path "Planner/router-state.md")
    (required_for routed_work_after_first_run)
    (fields
      active_run_dir
      active_status
      active_phase
      updated)
    (authority_order
      explicit_user_instruction_this_session
      router_state_active_run_dir
      single_live_non_complete_run
      completed_history_only)
    (rule
      "Read router-state before any per-run STATUS.md. Only the selected run's
       STATUS.md may supply current_mode, active_slice_file, and next_action.")
    (completed_run_status_files
      historical_records_unless_explicitly_selected_for_repair_or_corrective_work))


  ; ─── PROJECT SHAPE ────────────────────────────────────────────────────────
  ; A project is either single_phase or multi_phase. The shape is normally
  ; recorded on STATUS.md at slice-list creation time. Multi-phase work can
  ; pass through phase_initialized after PHASE-MAP approval and before this
  ; field exists. Closeout consults the shape plus phase_map/inline intent to
  ; derive phase_sealed vs project_complete.

  (project_shape
    (values
      single_phase   ; no PHASE-MAP.md; slice list embeds phase intent inline
      multi_phase)   ; PHASE-MAP.md authority over multiple phases

    (recorded_on
      "RUN_DIR/STATUS.md project_shape field")

    (set_at
      create_slice_list)

    (pre_record_bootstrap
      phase_initialized)

    (legacy_fallback
      (rule "STATUS complete AND no project_shape AND no phase_map → treat as single_phase")
      (purpose "completed runs predating v4 do not have project_shape recorded")))


  ; ─── PHASE TIER ───────────────────────────────────────────────────────────

  (phase_states
    project_initiated   ; no phase_map, no completed run
    phase_designing     ; create_phase_map running or draft present
    phase_initialized   ; approved multi_phase phase_map, RUN_DIR live, no STATUS/project_shape yet
    phase_active        ; phase_map approved or single_phase active; RUN_DIR live
    phase_contested     ; phase-level question unresolved
    phase_sealed        ; closeout passed, deferred_phases remain (multi_phase only)
    project_complete)   ; closeout passed, no further phases

  (phase_state_derivation
    (computed_on every_router_invocation)
    (read
      phase_map_presence
      STATUS_value
      STATUS_project_shape
      phase_map.deferred_phases
      RUN_DIR_state)

    ; Completed-state derivations dominate (F1 fix)
    (project_complete
      ← STATUS complete
        AND (or
              (project_shape single_phase)
              (no phase_map AND no project_shape)   ; legacy fallback
              (project_shape multi_phase AND phase_map.deferred_phases empty)))

    (phase_sealed
      ← STATUS complete
        AND project_shape multi_phase
        AND phase_map.deferred_phases nonempty)

    (phase_contested
      ← STATUS phase_contested)

    (phase_initialized
      ← phase_map_approved
        AND RUN_DIR_live
        AND no_project_shape
        AND (or STATUS_missing STATUS_empty))

    (phase_active
      ← (or
          (project_shape single_phase AND RUN_DIR_live AND STATUS_not_complete_or_contested)
          (project_shape multi_phase AND phase_map_approved AND RUN_DIR_live AND STATUS_not_complete_or_contested)))

    (phase_designing
      ← phase_map_being_authored)

    (project_initiated
      ← no_phase_map AND no_completed_status))


  ; ─── SLICE TIER ───────────────────────────────────────────────────────────

  (slice_states
    needs_slice_list
    slice_list_draft
    needs_next_slice_plan
    slice_planned
    slice_active_incomplete
    slice_review_needed
    slice_repair_needed
    needs_corrective_slice_plan
    final_closeout
    complete)


  ; ─── SLICE TYPE ───────────────────────────────────────────────────────────

  (slice_type
    (values
      standard
      corrective
      architecture_decision)

    (recorded_on
      "RUN_DIR/NEXT-SLICE.md slice_type field"
      "RUN_DIR/SLICE-LIST.md slice entry slice_type field"
      "RUN_DIR/PROOF-LOG.md slice_type field on pass record")

    (set_at_planning_time
      (plan_next_slice                  standard | architecture_decision)
      (plan_corrective_slice            corrective)
      (plan_architecture_decision_slice architecture_decision))

    (preserved_through
      slice_active_incomplete
      slice_repair_needed
      slice_review_needed))


  ; ─── PHASE MAP ────────────────────────────────────────────────────────────

  (phase_map
    (path "Planner/phase-map/PHASE-MAP.md")
    (required_for multi_phase_project)
    (skipped_for  single_phase_project)

    (required_fields
      (required_outcomes      "non-negotiable observable conditions per phase")
      (non_negotiable_intent  "user vocabulary and rejected approaches")
      (constraints            "out-of-scope items")
      (deferred_phases        "ordered sequence of remaining phases"))

    (deferred_phase_entry
      (name             "human-readable phase name")
      (order            "integer; planning signal not enforcement")
      (prerequisite     "phase name or none")
      (reason_deferred  "why this is out of scope for the current phase"))

    (authority
      (initializes      create_slice_list)
      (consulted_by     plan_next_slice plan_corrective_slice final_closeout phase_contested_gate)
      (overridden_by    explicit_user_instruction_this_session)
      (deviation
        (record         reason_if_user_stated)
        (require_justification false))))

  (single_phase_intent_block
    (purpose "in single_phase projects, the slice list carries phase intent inline since no PHASE-MAP.md exists")
    (lives_in "RUN_DIR/SLICE-LIST.md phase_intent section")
    (required_fields
      required_outcomes
      non_negotiable_intent
      constraints)
    (consulted_by
      plan_next_slice
      plan_corrective_slice
      final_closeout
      phase_contested_gate))


  ; ─── RUN DIR AUTHORITY ────────────────────────────────────────────────────

  (run_dir_authority
    (tier_1 explicit_user_instruction_this_session)
    (tier_2 router_state_active_run_dir)
    (tier_3 single_live_non_complete_run)
    (tier_4 current_selected_STATUS_md_and_PROOF_LOG)
    (tier_5 phase_map_deferred_sequence)
    (tier_6 PHASE_BACKLOG_suggestions)

    (override
      (rule   tier_1_wins)
      (forbid defend_prior_deferred_sequence_against_current_instruction)
      (allow  explicit_new_phase_not_present_in_phase_backlog))

    (skip_for create_phase_map)

    (if_run_dir_missing
      (sources
        prompt_path
        router_state_active_run_dir
        source_assignment
        STATUS_next_action_run_dir
        phase_map_next_action_run_dir
        phase_map_recommended_first_run_dir
        single_live_run)
      (if_still_missing → need_run_dir))

    (completed_run
      (new_phase                       requires_new_run_dir)
      (same_run_dir_allowed_only_for   explicit_repair_or_corrective_slice))

    (validate_against router_state_selected_STATUS_and_user_review))


  ; ─── ARCHITECTURE CONTRACT ────────────────────────────────────────────────
  ; Conceptual ownership rules. Physical layer names come from
  ; project_layer_mapping below.

  (architecture_contract

    (layer_ownership
      (domain
        (owns "durable business meaning, invariants, product language, policies")
        (must_not_import
          application infrastructure presentation framework
          transport database browser queue vendor_sdk deployment))
      (application
        (owns "use case orchestration, request, result, spoke boundary")
        (uses ports_for_outside_capabilities)
        (must_not_import concrete_infrastructure presentation framework))
      (infrastructure
        (owns "concrete adapters, ports implementation, outside mechanisms")
        (must_not_own
          use_case_orchestration domain_invariants presentation_flow
          user_intent product_language))
      (presentation
        (owns
          routes form_parsing transport_validation view_models
          templates fragments browser_gestures formatting response_serialization)
        (must_not_own
          domain_invariants source_model_meaning business_policy
          calculation_policy durable_workflow_semantics
          application_use_case_decisions)))

    (dependency_direction
      (rule    dependencies_point_inward)
      (domain  ← application ← infrastructure)
      (domain  ← presentation via_application_boundary))

    (naming
      (must_reveal_at_least_one_of
        domain_object user_intent business_policy
        transformation_role source_boundary proof_role
        phase_or_slice_purpose)
      (forbidden_without_domain_qualification
        helpers utils services manager processor adapter handler common misc))

    (ownership_change_gate
      (triggers
        ownership_change
        source_data_ownership_change
        dependency_direction_change
        stack_direction_change)

      (response
        (if silent_change
          (action  block_slice)
          (write   none))
        (if approved_change
          (action  plan_architecture_decision_slice)
          (blocks  standard_slice)
          (until
            (record_present
              (in           PROOF_LOG)
              (slice_type   architecture_decision)
              (status_in    passed_closing passed_with_debt)   ; F3 fix
              (decision_id  matches_current_change)))))

      (lookup
        (source       PROOF_LOG)
        (filter       slice_type architecture_decision AND status_in passed_closing passed_with_debt)
        (purpose      "find prior approved decisions resolving the current change")))

    (planner_steps_before_writing_slice
      (step_1 identify_domain_concept_or_user_capability)
      (step_2 select_existing_spoke_or_propose_new_spoke)
      (step_3 state_layer_ownership_for_each_part_of_the_change
        (note "use conceptual layer names; physical writes resolve via project_layer_mapping"))
      (step_4 name_adapters_allowed_to_translate_data)
      (step_5 name_architecture_rules_this_slice_must_preserve)
      (step_6 define_proof_before_implementation)
      (step_7 mark_out_of_scope_temptations_explicitly)))


  ; ─── PROJECT LAYER MAPPING ────────────────────────────────────────────────
  ; The architecture_contract above uses conceptual layer names. Physical
  ; folder names are project-specific. Architecture gates use conceptual
  ; names; allowed_edits, forbidden_edits, and file paths use physical
  ; names per the active project's mapping. Forbidden physical folder
  ; names protect projects whose AGENTS.md disallows certain layer folders.

  (project_layer_mapping
    (purpose
      "Translate conceptual planner vocabulary to physical layer names.")

    (active_project {{PROJECT_SLUG}})

    ({{PROJECT_SLUG}}
      (conceptual_to_physical
        (domain          FILL_PHYSICAL_DOMAIN_LAYER)
        (application     FILL_PHYSICAL_APPLICATION_MAPPING)
        (infrastructure  FILL_PHYSICAL_INFRASTRUCTURE)
        (presentation    FILL_PHYSICAL_PRESENTATION))

      (physical_only
        (bootstrap
          (owns "wires concrete adapters to use cases")
          (note "not a planner layer; physical-only")))

      (forbidden_physical_folders
        FILL_FORBIDDEN_PHYSICAL_FOLDER_ATOMS)

      (notes
        (mapping_notes
          "Document how conceptual application/infrastructure/presentation
           responsibilities map to real folders or packages in this repo."))

      (source_of_truth
        "project_layer_mapping block in this contract, filled during Planner
         adoption and explained by Planner/AGENTS.md. Repository root
         AGENTS.md may defer to Planner/AGENTS.md or echo durable repo-local
         guardrails, but it is not an active Planner run state source."))

    (planner_uses_conceptual_names_in
      layer_ownership_fields
      architecture_guardrails
      architecture_decision_slice_records
      ownership_change_gate_descriptions)

    (planner_uses_physical_names_in
      allowed_edits
      forbidden_edits
      file_paths
      touched_spokes_when_spoke_is_a_folder)

    (router_uses_mapping_to
      verify_planner_writes_do_not_create_forbidden_physical_folders
      translate_conceptual_layer_to_physical_path_for_proof_commands))


  ; ─── ROUTER ───────────────────────────────────────────────────────────────
  ; One invocation: read disk and user request, dispatch one mode or
  ; emit one next_action. First matching branch wins.

  (router
    (read
      active_run_pointer
      selected_RUN_DIR
      phase_map_presence
      STATUS_md_from_selected_RUN_DIR
      STATUS_project_shape
      NEXT_SLICE_slice_type
      run_dir_state
      user_request)

    (derive phase_state via phase_state_derivation)

    ; Phase-tier dispatch — completed states checked first (F1 fix)

    (if (phase_state project_complete)
      (cond
        ((user_says intent_unmet)         → user_review_reopen)
        ((user_says repair_or_corrective) → user_review_reopen)
        (else                              → emit RUN_COMPLETE)))

    (if (phase_state phase_sealed)
      (cond
        ((user_says intent_unmet)         → user_review_reopen)
        ((user_says repair_or_corrective) → user_review_reopen)
        (else                              → emit NEED_NEW_PHASE_RUN_DIR)))

    (if (phase_state phase_contested)
      → phase_contested_gate)

    ; Phase authoring — only after completed states ruled out

    (if (or (and (no phase_map) (no completed_status))
            (user_says create_phase_map))
      (cond
        ((user_says single_phase_project) → create_slice_list_single_phase)
        ((user_says small_feature)        → create_slice_list_single_phase)
        ((source_present AND user_says create_slice_list AND user_signals_no_phase_plan)
                                           → create_slice_list_single_phase)
        (else                              → create_phase_map)))

    ; Multi-phase bootstrap: PHASE-MAP exists before RUN_DIR/STATUS records project_shape.

    (if (phase_state phase_initialized)
      (cond
        (source_present → create_slice_list)
        (else            → emit NEED_SOURCE)))

    ; Slice-tier dispatch (phase_state phase_active)

    (if (phase_state phase_active)
      (cond_on STATUS

        (needs_slice_list
          (if source_present  → create_slice_list)
          (else                → emit NEED_SOURCE))

        (slice_list_draft      → approve_or_revise_slice_list)

        (needs_next_slice_plan → plan_next_slice)

        (slice_planned
          (case (NEXT_SLICE.slice_type)
            (standard
              (if (user_says implement) → implement_slice)
              (else                      → emit READY_TO_IMPLEMENT))
            (corrective
              (if (user_says implement) → implement_slice)
              (else                      → emit READY_TO_IMPLEMENT_CORRECTIVE))
            (architecture_decision
              (if (user_says review)    → review_gate)
              (else                      → emit READY_TO_REVIEW_DECISION))))

        (slice_active_incomplete
          (if (user_says resume) → resume_slice)
          (else
            (case (NEXT_SLICE.slice_type)
              (standard    → emit READY_TO_RESUME)
              (corrective  → emit READY_TO_RESUME_CORRECTIVE))))

        (slice_review_needed
          (if (user_says review) → review_gate)
          (else                   → emit READY_TO_REVIEW))

        (slice_repair_needed
          (if (user_says repair) → repair_active_slice)
          (else                  → emit READY_TO_REPAIR_ACTIVE_SLICE))

        (needs_corrective_slice_plan → plan_corrective_slice)

        (final_closeout              → final_closeout)))

    (else → emit NEED_SOURCE_OR_REPAIR))


  ; ─── PHASE CONTESTED GATE ─────────────────────────────────────────────────

  (phase_contested_gate
    (read STATUS PROOF_LOG SLICE_LIST phase_map_or_inline_intent closeout_validation)

    (present_to_user
      (show    remaining_work_items)
      (show    required_outcomes_from_phase_map_or_inline_intent)
      (require explicit_classification_before_proceeding))

    (classify_each_remaining_item

      (required_unmet
        (verify against_required_outcomes)
        → (set_STATUS needs_corrective_slice_plan))

      (optional_or_out_of_scope
        (verify ruled_out_or_prior_user_decision)
        → backlog_eligible
        → (set_STATUS final_closeout))

      (user_approved_deferral_of_previously_contested_item
        (record approval in closeout_validation.deferrals)
        → (set_STATUS final_closeout))

      (new_capability_not_in_original_scope
        → new_phase_needed
        (forbid  same_run_dir)
        (suggest next_run_dir from_deferred_sequence_or_user_choice)
        (record  closeout_note "phase complete; new capability moved to new phase")
        → (set_STATUS complete))

      (documents_disagree
        (authority STATUS_md_plus_active_RUN_DIR)
        (action    repair_disagreeing_docs)
        → re_present_for_classification))

    (forbid
      proceed_to_slice_work_before_all_items_classified
      silently_routing_to_run_state_repair_needed
      ask_user_to_justify_overriding_prior_deferred_sequence))


  ; ─── REVIEW GATE ──────────────────────────────────────────────────────────

  (review_gate
    (derived_from NEXT_SLICE.slice_type)

    (slice_context

      (standard
        (verify
          code_proof
          docs_updated
          cleanup
          git_state
          required_outcomes_from_phase_map_or_inline_intent
          architecture_ownership_preserved
          touched_spokes_match_allowed_edits
          layer_ownership_not_silently_changed
          physical_writes_respect_project_layer_mapping))

      (corrective
        (require
          reopen_reason
          why_prior_closeout_was_insufficient
          resolution_id)
        (verify
          resolution_id_matches_blocking_item_in_closeout_validation
          corrective_reason_against_required_outcomes
          code_proof
          architecture_ownership_preserved
          physical_writes_respect_project_layer_mapping))

      (architecture_decision
        (require
          question
          current_owner
          proposed_owner
          reason_for_change
          rejected_options
          proof_to_accept)
        (verify
          decision_record_complete
          architecture_contract_consistency
          implementation_allowed_is_false
          no_code_changes_present
          conceptual_layer_names_used_in_record)))

    (classify_outcome

      (passed_closing
        (record
          (append  PROOF_LOG)
          (archive NEXT_SLICE)
          (remove_or_mark_root_reviewed))
        (proof_log_fields
          (slice_type    inherited_from_slice)
          (resolution_id if_corrective)
          (decision_id   if_architecture_decision))
        (route
          (case (NEXT_SLICE.slice_type)
            (architecture_decision → (set_STATUS needs_next_slice_plan))
            (standard
              (if more_unpassed_slices → (set_STATUS needs_next_slice_plan))
              (if no_unpassed_slices    → (set_STATUS final_closeout)))
            (corrective              → (set_STATUS final_closeout)))))

      (passed_with_debt
        (record
          (append      PROOF_LOG)
          (archive     NEXT_SLICE)
          (remove_or_mark_root_reviewed)
          (record_debt SLICE_LIST with_classification_and_reason))
        (route (same_as passed_closing)))

      (partial
        (forbid pass_record)
        → (set_STATUS slice_repair_needed))

      (failed
        (forbid pass_record)
        → (set_STATUS slice_repair_needed))

      (invalidated
        (forbid pass_record)
        → phase_contested_gate)

      (scope_drift
        (forbid pass_record)
        → phase_contested_gate))

    (forbid product_code next_slice_plan))


  ; ─── USER REVIEW REOPEN ───────────────────────────────────────────────────

  (user_review_reopen
    (require reopen_reason)
    (read    STATUS SLICE_LIST PHASE_BACKLOG PROOF_LOG phase_map_or_inline_intent)
    (record  reopen_reason)

    (classify_reopen_reason

      (unmet_required_phase_intent
        (verify against_required_outcomes)
        → (set_STATUS needs_corrective_slice_plan))

      (unclear_required_vs_optional
        (require explicit_user_classification)
        (cond
          (required → (set_STATUS needs_corrective_slice_plan))
          (optional → backlog_eligible → (set_STATUS final_closeout))
          (new_work → new_phase_needed (forbid same_run_dir))))

      (run_state_documents_disagree
        (authority STATUS_md)
        (action    repair_disagreeing_docs)
        → phase_contested_gate))

    (forbid
      final_closeout
      run_complete
      next_phase_plan
      product_code
      proceed_without_explicit_classification_when_unclear))


  ; ─── PLANNING MODES ───────────────────────────────────────────────────────

  (create_phase_map
    (read    source_material)
    (inspect source_files_needed_for_claims)
    (write
      (path "Planner/phase-map/PHASE-MAP.md")
      (required_fields
        required_outcomes
        non_negotiable_intent
        constraints
        deferred_phases))
    (apply extraction_rules
      (finish              "move already-working behavior into cleaner target home")
      (phase_count         2..4)
      (default_phase_count 3)
      (max_lines           140)
      (forbid              product_roadmap ux_redesign deployment_plan copy_whole_repo))
    (forbid RUN_DIR STATUS SLICE_LIST NEXT_SLICE product_code)
    stop)

  (create_slice_list
    (project_shape multi_phase)
    (require
      RUN_DIR
      run_dir_not_complete
      approved_phase_map)
    (read source approved_phase_map schema)
    (require_fields
      source_packet
      prior_closeout
      required_outcomes
      non_negotiable_intent)
    (write "RUN_DIR/SLICE-LIST.md" "RUN_DIR/STATUS.md")
    (record project_shape multi_phase on STATUS)
    (set_STATUS slice_list_draft)
    (forbid NEXT_SLICE product_code)
    stop)

  (create_slice_list_single_phase
    (project_shape single_phase)
    (purpose "small feature with no multi-phase decomposition; phase intent lives inline in slice list")
    (require
      RUN_DIR
      run_dir_not_complete
      source_material
      (no phase_map OR phase_map_explicitly_skipped))

    (read source schema)

    (require_inline_phase_intent
      required_outcomes
      non_negotiable_intent
      constraints)

    (write "RUN_DIR/SLICE-LIST.md" "RUN_DIR/STATUS.md")

    (slice_list_must_contain
      (phase_intent_section
        required_outcomes
        non_negotiable_intent
        constraints)
      (slices
        (each slice_keys_per_schema)))

    (record project_shape single_phase on STATUS)
    (set_STATUS slice_list_draft)
    (forbid NEXT_SLICE product_code PHASE_MAP_writes)
    stop)

  (approve_or_revise_slice_list
    (read SLICE_LIST)
    (cond
      (revised  (update SLICE_LIST))
      (approved (set_STATUS needs_next_slice_plan)))
    (forbid NEXT_SLICE product_code)
    stop)

  (plan_next_slice
    (require
      RUN_DIR
      (STATUS needs_next_slice_plan)
      source_packet
      required_outcomes_from_phase_map_or_inline_intent)
    (read STATUS SLICE_LIST schema phase_map_or_inline_intent PROOF_LOG project_layer_mapping)

    (apply architecture_contract
      (require
        touched_spokes
        layer_ownership            ; conceptual names
        architecture_guardrails
        allowed_edits              ; physical names per project_layer_mapping
        forbidden_edits)           ; physical names per project_layer_mapping
      (check ownership_change_gate)
      (check no_writes_create_forbidden_physical_folders))

    (cond
      ((ownership_change_detected
        AND (no approved_decision_in_PROOF_LOG))
        (action plan_architecture_decision_slice)
        (blocks standard_slice))

      (else
        (select first_unpassed_slice)
        (write
          "RUN_DIR/NEXT-SLICE.md"
          "RUN_DIR/STATUS.md"
          "RUN_DIR/SLICE-LIST.md")
        (record slice_type standard)
        (set_STATUS slice_planned)
        (forbid product_code PROOF_LOG later_slice_plan)
        stop)))

  (plan_architecture_decision_slice
    (purpose "record an ownership change decision before any standard slice may proceed")
    (require
      RUN_DIR
      (STATUS needs_next_slice_plan)
      ownership_change_detected)
    (read STATUS SLICE_LIST schema phase_map_or_inline_intent architecture project_layer_mapping)

    (write
      "RUN_DIR/NEXT-SLICE.md"
      "RUN_DIR/STATUS.md"
      "RUN_DIR/SLICE-LIST.md")

    (next_slice_fields
      (slice_type             architecture_decision)
      (implementation_allowed false)
      (decision_id            generate_unique_id)
      (question               "decision to resolve")
      (current_owner          "current conceptual layer or spoke")
      (proposed_owner         "new conceptual layer or spoke")
      (reason_for_change      "pressure or evidence")
      (rejected_options       "list of options and rejection reasons")
      (proof_to_accept        "test, doc, or path proof")
      (architecture_guardrails "specific rules this decision must preserve"))

    (set_STATUS slice_planned)                ; F2 fix
    (note "router sees slice_planned + slice_type=architecture_decision and emits READY_TO_REVIEW_DECISION")
    (forbid product_code later_slice_plan)
    stop)

  (plan_corrective_slice
    (require
      RUN_DIR
      reopen_reason
      source_packet
      prior_closeout
      required_outcomes_from_phase_map_or_inline_intent
      blocking_backlog_items)
    (read STATUS SLICE_LIST PHASE_BACKLOG schema phase_map_or_inline_intent closeout_validation project_layer_mapping)

    (apply architecture_contract
      (require touched_spokes layer_ownership architecture_guardrails)
      (check   ownership_change_gate)
      (check   no_writes_create_forbidden_physical_folders))

    (resolution_id
      (source STATUS.closeout_validation.blocking_items_resolution_log)
      (rule   each_corrective_slice_binds_to_one_flagged_blocking_item))

    (select unmet_required_phase_intent_only)
    (write
      "RUN_DIR/NEXT-SLICE.md"
      "RUN_DIR/STATUS.md"
      "RUN_DIR/SLICE-LIST.md")
    (record slice_type    corrective)
    (record resolution_id from_blocking_items_resolution_log)
    (set_STATUS slice_planned)
    (forbid optional_backlog next_phase_plan product_code PROOF_LOG)
    stop)


  ; ─── IMPLEMENTATION MODES ─────────────────────────────────────────────────

  (implement_slice
    (read    NEXT_SLICE)
    (require (slice_type standard | corrective))
    (forbid_for
      (slice_type architecture_decision)
      (reason     "decision slices have implementation_allowed=false; they go straight to review"))
    (follow  NEXT_SLICE.allowed_changes)
    (verify  writes_respect_project_layer_mapping)
    (forbid  planner PROOF_LOG next_slice_plan)

    (cond
      (incomplete
        (set_NEXT_SLICE active_incomplete)
        (set_STATUS     slice_active_incomplete)
        stop)
      (complete
        (append         implementation_handback)
        (set_NEXT_SLICE review_needed)
        (set_STATUS     slice_review_needed)
        stop)))

  (resume_slice
    (read    NEXT_SLICE)
    (require (slice_type standard | corrective))
    (follow  mid_slice_resume_note)
    (apply   same_rules_as implement_slice))

  (repair_active_slice
    (read     NEXT_SLICE)
    (follow   review_result)
    (repair   current_slice_only)
    (preserve slice_type)
    (verify   writes_respect_project_layer_mapping)
    (set_NEXT_SLICE review_needed)
    (set_STATUS     slice_review_needed)
    (forbid   planner PROOF_LOG next_slice_plan)
    stop)


  ; ─── FINAL CLOSEOUT ───────────────────────────────────────────────────────

  (final_closeout
    (read
      STATUS
      STATUS_project_shape
      PROOF_LOG
      SLICE_LIST
      phase_map_or_inline_intent
      (optional prior_closeout_validation))

    (state_carry
      (read STATUS.closeout_validation.blocking_items_resolution_log)
      (for_each_prior_entry
        (lookup PROOF_LOG
          (where slice_type corrective
                 AND status_in passed_closing passed_with_debt
                 AND resolution_id matches))
        (if_found (set entry.status resolved)))
      (purpose "second-pass closeout does not re-fire blocking items already resolved by corrective slice"))

    (verify
      all_slices_passed_or_debt_explicitly_recorded
      PROOF_LOG_present_and_complete)

    (check_required_outcomes
      (rule    required_outcomes_dominate_blocking_classification)
      (against required_outcomes_from_phase_map_or_inline_intent)
      (against current_disk_state_post_resolution))

    (classify_remaining_work

      (required_outcomes_satisfied

        (case_a nothing_remaining
          → (write_closeout)
          → (set_STATUS complete))

        (case_b optional_or_out_of_scope
          (verify ruled_out_or_prior_user_decision)
          → (write PHASE_BACKLOG
              (record_first backlog_records with_source_reason_suggested_run_dir)
              (record_after phase_lessons max_1_line))
          → (write_closeout)
          → (set_STATUS complete)))

      (required_outcomes_unsatisfied

        (case_c blocking_backlog_item
          → (append_to STATUS.closeout_validation.blocking_items_resolution_log
              (entry
                (resolution_id            generate_unique_id)
                (item_id                  from_PHASE_BACKLOG_or_inline)
                (required_outcome_blocked reference)
                (classification           blocking)
                (pass_number              current_closeout_pass)
                (status                   flagged)))            ; F4 fix
          → (set_STATUS needs_corrective_slice_plan)
          (forbid       complete))

        (case_d required_but_unmet_unclear
          → phase_contested_gate
          (forbid complete))

        (case_e ambiguous
          → phase_contested_gate
          (forbid complete)
          (forbid silently_classify_as_optional))))

    (write_closeout_validation
      (path "RUN_DIR/STATUS.md closeout_validation")
      (fields
        required_outcomes
        proof_log_verification
        classification_to_implementation_trace
        blocking_items_resolution_log
        deferrals
        support_doc_sync
        next_slice_cleanup))

    (support_doc_sync
      (record_in "RUN_DIR/STATUS.md closeout_validation.support_doc_sync")
      (rule
        "Record which support docs were checked. Do not mutate support docs
         to keep active run state synchronized; active Planner run state
         belongs in Planner/router-state.md and the selected RUN_DIR/STATUS.md.")
      (allowed_support_doc_writes
        (planner_router_state_md
          "Only when the active-run pointer, active_status, active_phase,
           updated date, or notes must change.")
        (planner_context_index_md
          "Only for stable Planner kit navigation, read-order, or topology
           changes; never for transient active run identity, current_mode,
           active_slice_file, or next_action.")
        (planner_AGENTS_md
          "Forbidden during closeout for run tracking. Allowed only by
           explicit user-approved durable Planner guardrail changes outside
           active run state.")
        (root_AGENTS_md
          "Forbidden during Planner closeout for run tracking. Root AGENTS.md
           may contain repo-local operational facts or a durable deferral to
           Planner/AGENTS.md, but must not be synchronized from active run state.")))

    (cleanup_root_next_slice
      (if root_NEXT_SLICE_exists_after_archive
        (action remove_or_mark_reviewed)
        (set    STATUS.active_slice_file none)))

    (note
      "STATUS=complete after this mode. Outer phase_state is derived by
       phase_state_derivation: project_shape=single_phase → project_complete;
       project_shape=multi_phase + deferred_phases empty → project_complete;
       project_shape=multi_phase + deferred_phases nonempty → phase_sealed.")

    (forbid next_phase_plan)
    stop)


  ; ─── OUTPUTS ──────────────────────────────────────────────────────────────

  (outputs

    (need_run_dir
      "NEED_RUN_DIR: choose one RUN_DIR from Planner/slice-runs/<run-name>.")

    (need_source
      "NEED_SOURCE: provide source material or a phase-map packet.")

    (need_source_or_repair
      "NEED_SOURCE_OR_REPAIR: provide source or repair run state before continuing.")

    (need_new_phase_run_dir
      "NEED_NEW_PHASE_RUN_DIR: this phase is sealed. Do not reuse the completed RUN_DIR.
       Consulting deferred_phases in Planner/phase-map/PHASE-MAP.md for suggested next RUN_DIR.
       If explicit user instruction names a different RUN_DIR, use that instead.")

    (ready_to_implement
      "READY_TO_IMPLEMENT: RUN_DIR/NEXT-SLICE.md is planned (slice_type=standard).
       Start a fresh session and say: implement the active slice.")

    (ready_to_implement_corrective
      "READY_TO_IMPLEMENT_CORRECTIVE: RUN_DIR/NEXT-SLICE.md is planned (slice_type=corrective).
       Start a fresh session and say: implement the corrective slice.")

    (ready_to_review_decision
      "READY_TO_REVIEW_DECISION: RUN_DIR/NEXT-SLICE.md is an architecture decision slice.
       Planning-only — no code to implement. Start a fresh session and say:
       review the architecture decision slice.")

    (ready_to_resume
      "READY_TO_RESUME: RUN_DIR/NEXT-SLICE.md is active-incomplete (slice_type=standard).
       Start a fresh session and say: resume the active slice.")

    (ready_to_resume_corrective
      "READY_TO_RESUME_CORRECTIVE: RUN_DIR/NEXT-SLICE.md is active-incomplete (slice_type=corrective).
       Start a fresh session and say: resume the corrective slice.")

    (ready_to_review
      "READY_TO_REVIEW: RUN_DIR/NEXT-SLICE.md is review_needed.
       A planning, implementation, or repair request must not run review_gate.
       Start a fresh session and say: review the active slice.")

    (ready_to_repair_active_slice
      "READY_TO_REPAIR_ACTIVE_SLICE: repair the current slice in a fresh session.
       slice_type is preserved through repair.")

    (run_complete
      "RUN_COMPLETE: all approved slices passed, closeout complete.
       In single_phase_project: project complete.
       In multi_phase_project: project complete because phase_map.deferred_phases is empty."))


  ; ─── HARD STOPS ───────────────────────────────────────────────────────────

  (hard_stops
    (phase_map_does_not_create_run_control)
    (slice_list_does_not_create_next_slice)
    (next_slice_does_not_implement)
    (planning_request_does_not_run_review_gate)
    (implementation_does_not_review)
    (review_does_not_plan_next_slice)
    (closeout_does_not_plan_next_phase)
    (phase_contested_gate_does_not_silently_resolve)
    (ambiguous_remaining_work_does_not_proceed_to_closeout)
    (ownership_change_does_not_proceed_without_approved_architecture_decision_slice)
    (architecture_decision_slice_does_not_implement_code)
    (architecture_decision_slice_does_not_skip_review)
    (corrective_slice_without_resolution_id_does_not_close_blocking_item)
    (closeout_does_not_re_fire_blocking_items_already_resolved_in_prior_pass)
    (closeout_does_not_append_blocking_item_without_status_flagged)
    (prior_deferred_sequence_does_not_block_explicit_user_instruction)
    (router_does_not_alias_handler_names)
    (router_does_not_route_completed_status_to_create_phase_map)
    (single_phase_project_does_not_write_PHASE_MAP_md)
    (phase_initialized_does_not_require_project_shape_before_create_slice_list)
    (planner_does_not_create_physical_folders_listed_as_forbidden_in_project_layer_mapping)
    (proof_log_status_lookup_does_not_use_bare_passed)
    (support_docs_do_not_repeat_or_sync_active_run_state)
    (AGENTS_md_is_guardrails_only_not_run_state))


  ; ─── QUALITY GATES ────────────────────────────────────────────────────────

  (quality_gates

    (source_packets_distinguish active_local_source historical_external_evidence)

    (slice_lists_include
      required_outcomes
      optional_deferred_outcomes
      source_packet
      prior_closeout
      non_negotiable_user_intent
      slice_type
      (when_single_phase phase_intent_section))

    (required_outcomes_cannot_move_to_closeout_backlog_without_explicit_user_deferral)
    (backlog_item_blocking_named_phase_goal_promotes_to_current_phase_or_requires_user_approval)
    (flag_thin_skeleton_slice_when_phase_goal_requires_physical_architecture)
    (inspect_layer_responsibilities_not_only_init_markers)
    (classification_to_implementation_trace_required_at_closeout)
    (unresolved_required_work_blocks_final_closeout)
    (do_not_make_standalone_target_planning_depend_on_disposable_source_repo)
    (validate_run_dir_against_active_STATUS)
    (do_not_reuse_completed_run_dir_for_new_phase)

    (closeout
      (required_outcomes_dominate_blocking_classification)
      (validates_against required_outcomes_from_phase_map_or_inline_intent as_primary_authority)
      (state_carries_blocking_items_resolution_log_across_passes)
      (initial_blocking_entry_writes_status_flagged))

    (architecture_fields_required_in_every_planned_slice
      touched_spokes
      layer_ownership_conceptual_names
      architecture_guardrails
      allowed_edits_physical_names
      forbidden_edits_physical_names
      slice_type)

    (architecture_decision_slice
      (writes_only            decision_record)
      (implementation_allowed false)
      (skips                  implement_step)
      (status_at_planning     slice_planned)
      (proof_log_records      decision_id_for_lookup_by_ownership_change_gate))

    (corrective_slice
      (resolution_id_required)
      (binds_to specific_flagged_blocking_item_from_closeout_validation))

    (project_layer_mapping
      (consulted_at_planning_time)
      (forbidden_physical_folders_never_created)
      (architecture_uses_conceptual_names)
      (writes_use_physical_names))

    (project_shape
      (recorded_at_slice_list_creation)
      (multi_phase_bootstrap_routes_through_phase_initialized)
      (consulted_at_closeout_for_outer_state_derivation)
      (legacy_completed_runs_without_record_treated_as_single_phase))

    (contracts_versioned_in_target_repo_for_routed_work)))
```
