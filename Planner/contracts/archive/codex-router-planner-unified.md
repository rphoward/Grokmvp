# Codex Router Planner — Unified

Status: rewrite. Replaces codex-session-router-sexpr-experimental.md
and codex-repo-slice-planner-sexpr-experimental.md.

```lisp
(router_planner

  ; ─── PATHS ───────────────────────────────────────────────────────────────

  (paths
    (self    "Planner/contracts/codex-router-planner-unified.md")
    (schema  "Planner/contracts/codex-extraction-packet-schema-sexpr.md")
    (arch    "Planner/contracts/domain-spoke-architecture.md"))


  ; ─── CONTRACT ─────────────────────────────────────────────────────────────
  ; Rules that apply to every session regardless of mode.

  (contract
    (one_session_one_mode)
    (one_legal_action_per_session)
    (do_not_use_chat_memory)
    (do_not_implement_code_in_planning_modes)
    (do_not_plan_in_implementation_modes)
    (do_not_review_in_implementation_modes)
    (stop_after_allowed_writes)
    (preserve_non_negotiable_user_intent)
    (standalone_target_uses_local_contracts_and_run_control)
    (external_source_repo_paths_are_historical_evidence_only
      (unless user_explicitly_requests_source_repo_reinspection))
    (compound_plan_implement_review_closeout_forbidden
      (unless explicit_automation_mode_declared))
    (do_not_convert_required_phase_work_to_backlog_without_user_decision)
    (when_docs_disagree
      (authority STATUS_md_plus_active_RUN_DIR wins)
      (repair_disagreeing_docs_before_continuing)))


  ; ─── PHASE TIER ───────────────────────────────────────────────────────────
  ; The phase tier sits above the slice tier.
  ; Phase states describe where a phase is in its lifecycle.
  ; Slice states describe where the current slice is inside an open phase.
  ; A phase must be explicitly open before slice states apply.

  (phase_states
    phase_designing          ; create_phase_map running, no RUN_DIR yet
    phase_open               ; RUN_DIR active, slice machine running inside
    phase_contested          ; phase-level question unresolved, slice work blocked
    phase_closing            ; final_closeout running
    phase_complete           ; closeout passed, RUN_DIR sealed
    phase_sequence_pending)  ; NEED_NEW_PHASE_RUN_DIR, ordered deferred list available


  ; ─── SLICE TIER ───────────────────────────────────────────────────────────
  ; Slice states only apply when phase_state is phase_open.

  (slice_states
    needs_slice_list
    slice_list_draft
    needs_next_slice_plan
    slice_planned
    slice_active_incomplete
    slice_review_needed
    slice_repair_needed)


  ; ─── RUN DIR AUTHORITY ────────────────────────────────────────────────────
  ; Explicit user instruction always beats a prior plan.
  ; The deferred sequence is a suggestion surface, not a gate.

  (run_dir_authority
    (tier_1 explicit_user_instruction_this_session)
    (tier_2 current_STATUS_md_and_PROOF_LOG)
    (tier_3 phase_map_deferred_sequence)
    (tier_4 PHASE_BACKLOG_suggestions)

    (when_tier_1_present
      (accept_override_without_requiring_user_justification)
      (record deviation_from_prior_sequence with_reason_if_user_stated))

    (when_tier_3_conflicts_with_tier_1
      (tier_1_wins)
      (do_not_defend_prior_deferred_sequence_against_current_instruction))

    (skip_for create_phase_map)

    (if_run_dir_missing
      (sources
        prompt_path
        source_assignment
        STATUS_next_action_run_dir
        phase_map_next_action_run_dir
        phase_map_recommended_first_run_dir
        single_live_run)
      (if_still_missing → need_run_dir))

    (completed_run
      (new_phase_requires_new_run_dir)
      (same_run_dir_allowed_only_for explicit_repair_or_corrective_slice))

    (validate_against active_STATUS_and_user_review))


  ; ─── PHASE MAP ────────────────────────────────────────────────────────────
  ; The phase map is a living authority across the full phase sequence,
  ; not only at initialization. final_closeout validates against it.

  (phase_map_structure
    (required_outcomes     "non-negotiable observable conditions for phase completion")
    (non_negotiable_intent "user vocabulary and rejected approaches to preserve")
    (constraints           "what is explicitly ruled out of scope")

    (deferred_phases
      ; Ordered sequence decided at design time.
      ; order and prerequisite are planning signals, not enforcement gates.
      ; Explicit user instruction this session overrides sequence.
      (phase
        (name        "example: stabilize domain model")
        (order       1)
        (prerequisite none)
        (reason_deferred "out of scope for current phase"))
      (phase
        (name        "example: add persistence layer")
        (order       2)
        (prerequisite "stabilize-domain-model-run-dir")))

    (authority
      (initializes    create_slice_list)
      (consulted_by   final_closeout phase_contested plan_next_slice)
      (overridden_by  explicit_user_instruction_this_session with_deviation_record)))


  ; ─── ARCHITECTURE CONTRACT ────────────────────────────────────────────────
  ; These rules are enforcement gates, not documentation.
  ; A planner that cannot satisfy these gates must not write a slice.
  ; Full rule prose lives in domain-spoke-architecture.md.

  (architecture_contract

    (layer_ownership_rules
      (domain
        (owns   "durable business meaning, invariants, product language, policies")
        (must_not_import
          "application, infrastructure, presentation, framework,
           transport, database, browser, queue, vendor SDK, deployment"))
      (application
        (owns   "use case orchestration, request, result, spoke boundary")
        (uses   "ports for outside capabilities")
        (must_not_import "concrete infrastructure, presentation, framework"))
      (infrastructure
        (owns   "concrete adapters, ports implementation, outside mechanisms")
        (must_not_own
          "use case orchestration, domain invariants, presentation flow,
           user intent, product language"))
      (presentation
        (owns
          "routes, form parsing, transport validation, view models,
           templates, fragments, browser gestures, formatting,
           response serialization")
        (must_not_own
          "domain invariants, source model meaning, business policy,
           calculation policy, durable workflow semantics,
           application use case decisions")))

    (dependency_direction
      (rule "dependencies point inward")
      (domain ← application ← infrastructure)
      (domain ← presentation via application boundary))

    (naming_rules
      (must_reveal_at_least_one_of
        domain_object user_intent business_policy
        transformation_role source_boundary proof_role phase_or_slice_purpose)
      (forbidden_without_domain_qualification
        helpers utils services manager processor adapter handler common misc))

    (ownership_change_gate
      (triggers
        (ownership_change)
        (source_data_ownership_change)
        (dependency_direction_change)
        (stack_direction_change))
      (response
        (if silent_change → forbidden_block_slice)
        (if approved_change → architecture_decision_slice_required_before_implementation)))

    (planner_steps_before_writing_slice
      (step_1 "identify domain concept or user capability")
      (step_2 "select existing spoke or propose new spoke")
      (step_3 "state layer ownership for each part of the change")
      (step_4 "name adapters allowed to translate data")
      (step_5 "name architecture rules this slice must preserve")
      (step_6 "define proof before implementation")
      (step_7 "mark out-of-scope temptations explicitly")))


  ; ─── MODE DETECTION ───────────────────────────────────────────────────────
  ; Reads phase_state first, then slice_state, then user request.
  ; First matching rule wins.

  (mode_detection

    ; Phase-level signals
    ((source_names create_phase_map)                            create_phase_map)
    ((phase_state phase_designing)                              create_phase_map)

    ((source_names create_slice_list)                           create_slice_list)
    ((phase_state missing source_present)                       create_slice_list)
    ((STATUS needs_slice_list source_present)                   create_slice_list)
    ((STATUS needs_slice_list)                                  need_source)

    ((STATUS slice_list_draft)                                  approve_or_revise_slice_list)

    ; Phase complete — route based on what comes next
    ((phase_state phase_complete user_review_says_intent_unmet) user_review_reopen)
    ((phase_state phase_complete user_says repair_or_corrective) user_review_reopen)
    ((phase_state phase_complete source_present)                need_new_phase_run_dir)
    ((phase_state phase_complete user_says create_slice_list)   need_new_phase_run_dir)
    ((phase_state phase_complete user_says plan_next_slice)     need_new_phase_run_dir)
    ((phase_state phase_complete)                               run_complete)

    ; Phase contested — classification required before anything else
    ((phase_state phase_contested)                              phase_contested_gate)
    ((STATUS run_state_repair_needed)                           phase_contested_gate)

    ; Slice-level signals (phase_state must be phase_open)
    ((STATUS needs_next_slice_plan)                             plan_next_slice)
    ((STATUS slice_planned user_says implement)                 implement_active_slice)
    ((STATUS slice_planned)                                     ready_to_implement)
    ((STATUS slice_active_incomplete user_says resume)          resume_active_slice)
    ((STATUS slice_active_incomplete)                           ready_to_resume)
    ((STATUS slice_review_needed)                               review_gate)
    ((STATUS slice_repair_needed user_says repair)              repair_active_slice)
    ((STATUS slice_repair_needed)                               ready_to_repair_active_slice)

    ; Corrective slice signals
    ((STATUS needs_corrective_slice_plan)                       plan_corrective_slice)
    ((STATUS corrective_slice_planned user_says implement)      implement_corrective_slice)
    ((STATUS corrective_slice_planned)                          ready_to_implement_corrective_slice)
    ((STATUS corrective_slice_active_incomplete user_says resume) resume_corrective_slice)
    ((STATUS corrective_slice_active_incomplete)                ready_to_resume_corrective_slice)
    ((STATUS corrective_slice_review_needed)                    review_gate)

    ; Closeout
    ((STATUS final_closeout user_review_says_intent_unmet)      user_review_reopen)
    ((STATUS final_closeout)                                    final_closeout)
    ((STATUS complete)                                          run_complete)

    (else need_source_or_repair))


  ; ─── PHASE CONTESTED GATE ─────────────────────────────────────────────────
  ; Replaces run_state_repair_needed as a catch-all.
  ; This is a hard stop. No slice work proceeds until classification resolves.

  (phase_contested_gate
    (read STATUS PROOF_LOG SLICE_LIST phase_map)

    (present_to_user
      (show remaining_work_items)
      (show required_outcomes_from_phase_map)
      (require explicit_classification_before_proceeding))

    (classify_each_remaining_item
      (required_unmet
        (verify against_phase_map_required_outcomes)
        → needs_corrective_slice_plan)

      (optional_or_explicitly_out_of_scope
        (verify ruled_out_in_phase_map_or_by_prior_user_decision)
        → backlog_eligible
        → phase_closing)

      (new_capability_not_in_original_phase
        → new_phase_needed
        (forbid same_run_dir)
        (suggest next_run_dir from deferred_sequence or user_choice))

      (documents_disagree_about_classification
        (authority STATUS_md_plus_active_RUN_DIR wins)
        (repair_disagreeing_docs)
        (re_present_for_classification)))

    (forbid
      proceeding_to_slice_work_before_all_items_classified
      silently_routing_to_run_state_repair_needed
      asking_user_to_justify_overriding_prior_deferred_sequence))


  ; ─── REVIEW GATE ──────────────────────────────────────────────────────────
  ; Single parameterized gate for all slice types.
  ; slice_context is the only thing that differs between standard,
  ; repair, and corrective entry paths.

  (review_gate
    (slice_context
      (standard)
      (repair)
      (corrective
        (require reopen_reason)
        (require why_prior_closeout_was_insufficient)
        (verify corrective_reason_against_phase_map_required_outcomes)))

    (verify
      proof
      docs
      cleanup
      git_state
      required_outcomes_from_phase_map
      architecture_ownership_preserved
      touched_spokes_match_allowed_edits
      layer_ownership_not_silently_changed)

    (classify_outcome
      (passed_closing
        (record (append PROOF_LOG) (archive NEXT_SLICE) (remove_or_mark_root_reviewed))
        (route
          (if more_unpassed_slices  → (set_STATUS needs_next_slice_plan))
          (if no_unpassed_slices    → (set_STATUS final_closeout))))

      (passed_with_debt
        (record (append PROOF_LOG) (archive NEXT_SLICE) (remove_or_mark_root_reviewed))
        (record_debt SLICE_LIST with_classification_and_reason)
        (route
          (if more_unpassed_slices  → (set_STATUS needs_next_slice_plan))
          (if no_unpassed_slices    → (set_STATUS final_closeout))))

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
    (read STATUS SLICE_LIST PHASE_BACKLOG PROOF_LOG phase_map)
    (record reopen_reason)

    (classify_reopen_reason
      (unmet_required_phase_intent
        (verify against_phase_map_required_outcomes)
        → (set_STATUS needs_corrective_slice_plan))

      (unclear_required_vs_optional
        (require explicit_user_classification
          (if required    → (set_STATUS needs_corrective_slice_plan))
          (if optional    → backlog_eligible → phase_closing)
          (if new_work    → new_phase_needed (forbid same_run_dir))))

      (run_state_documents_disagree
        (authority STATUS_md wins)
        (require repair_disagreeing_docs_before_continuing)
        → phase_contested_gate))

    (forbid
      final_closeout run_complete next_phase_plan product_code
      proceeding_without_explicit_classification_when_unclear))


  ; ─── PLANNING MODES ───────────────────────────────────────────────────────

  (create_phase_map
    (phase_state_set phase_designing)
    (read source_material)
    (inspect source_files_needed_for_claims)
    (write phase_map_file
      (required_fields
        required_outcomes
        non_negotiable_intent
        constraints
        deferred_phases))
    (apply extraction_rules
      (finish "move already-working behavior into cleaner target home")
      (phase_count 2..4)
      (default_phase_count 3)
      (max_lines 140)
      (forbid product_roadmap ux_redesign deployment_plan copy_whole_repo))
    (forbid RUN_DIR STATUS SLICE_LIST NEXT_SLICE product_code)
    stop)

  (create_slice_list
    (phase_state_set phase_open)
    (require RUN_DIR)
    (require run_dir_not_complete)
    (read source approved_phase_map_or_source_packet schema)
    (require source_packet prior_closeout required_outcomes non_negotiable_intent)
    (write "RUN_DIR/SLICE-LIST.md" "RUN_DIR/STATUS.md")
    (set_STATUS slice_list_draft)
    (forbid NEXT_SLICE product_code)
    stop)

  (approve_or_revise_slice_list
    (read SLICE_LIST)
    (if revised (update SLICE_LIST))
    (if approved (set_STATUS needs_next_slice_plan))
    (forbid NEXT_SLICE product_code)
    stop)

  (plan_next_slice
    (require RUN_DIR)
    (require STATUS needs_next_slice_plan)
    (require source_packet required_outcomes)
    (read STATUS SLICE_LIST schema phase_map)

    (apply architecture_contract
      (require
        (touched_spokes        "name every spoke this slice touches")
        (layer_ownership
          (for_each_new_concept
            (owns        "layer that owns this concept")
            (must_not_change "layer boundary not in scope")))
        (architecture_guardrails "specific rules this slice must preserve")
        (allowed_edits  "explicit path list")
        (forbidden_edits "explicit path or behavior list"))
      (check ownership_change_gate)
      (if ownership_change_detected_and_not_approved
        → architecture_decision_slice_required
        (forbid implementation_slice)))

    (select first_unpassed_slice)
    (write "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (set_STATUS slice_planned)
    (forbid product_code PROOF_LOG later_slice_plan)
    stop)

  (plan_corrective_slice
    (require RUN_DIR reopen_reason)
    (require source_packet prior_closeout required_outcomes blocking_backlog_items)
    (read STATUS SLICE_LIST PHASE_BACKLOG schema phase_map)

    (apply architecture_contract
      (require
        (touched_spokes)
        (layer_ownership)
        (architecture_guardrails))
      (check ownership_change_gate))

    (select unmet_required_phase_intent_only)
    (write "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (set_STATUS corrective_slice_planned)
    (forbid optional_backlog next_phase_plan product_code PROOF_LOG)
    stop)


  ; ─── IMPLEMENTATION MODES ─────────────────────────────────────────────────
  ; implement and resume share identical write rules.
  ; slice_type (standard or corrective) sets the review path.

  (implement_slice
    (slice_type standard | corrective)
    (read NEXT_SLICE)
    (follow NEXT_SLICE allowed_changes)
    (forbid planner PROOF_LOG next_slice_plan)
    (if incomplete
      (set_NEXT_SLICE active_incomplete)
      (set_STATUS
        (if standard    slice_active_incomplete)
        (if corrective  corrective_slice_active_incomplete))
      stop)
    (if complete
      (append implementation_handback)
      (set_NEXT_SLICE review_needed)
      (set_STATUS
        (if standard    slice_review_needed)
        (if corrective  corrective_slice_review_needed))
      stop))

  (resume_slice
    (slice_type standard | corrective)
    (read NEXT_SLICE)
    (follow mid_slice_resume_note)
    (same_rules_as implement_slice))

  (repair_active_slice
    (read NEXT_SLICE)
    (follow review_result)
    (repair_current_slice_only)
    (set_NEXT_SLICE review_needed)
    (set_STATUS slice_review_needed)
    (forbid planner PROOF_LOG next_slice_plan)
    stop)


  ; ─── FINAL CLOSEOUT ───────────────────────────────────────────────────────
  ; Closes the phase, not just the last slice.
  ; Validates against phase_map required_outcomes as primary authority.

  (final_closeout
    (phase_state_set phase_closing)
    (read STATUS PROOF_LOG SLICE_LIST phase_map)

    (verify
      (all_slices_passed_or_debt_explicitly_recorded)
      (PROOF_LOG_present_and_complete)
      (required_outcomes_from_phase_map_physically_satisfied)
      (classification_to_implementation_trace_in STATUS_closeout_validation))

    (classify_remaining_work
      (nothing_remaining
        → write_closeout → (set_STATUS complete))

      (optional_or_explicitly_out_of_scope
        (verify ruled_out_in_phase_map_or_prior_user_decision)
        → (write PHASE_BACKLOG
            (record_first backlog_records with_source_reason_suggested_run_dir)
            (record_after phase_lessons max_1_line
              (or contract_notes max_5_lines if_done_state_affected)))
        → write_closeout → (set_STATUS complete))

      (blocking_backlog_item
        → (set_STATUS needs_corrective_slice_plan)
        (forbid complete))

      (required_but_unmet
        → phase_contested_gate
        (forbid complete))

      (ambiguous
        → phase_contested_gate
        (forbid complete)
        (forbid silently_classifying_as_optional)))

    (write STATUS closeout_validation
      (fields
        required_outcomes
        proof_log_verification
        classification_to_implementation_trace
        blocking_backlog_items
        support_doc_sync
        next_slice_cleanup))

    (sync_project_support_docs_that_repeat_active_run_state AGENTS context_index)

    (if root_NEXT_SLICE_exists_after_archive
      (remove_or_mark_reviewed)
      (set_STATUS active_slice_file none))

    (phase_state_set phase_complete)
    (set_STATUS complete)
    (forbid next_phase_plan)
    stop)


  ; ─── OUTPUTS ──────────────────────────────────────────────────────────────

  (outputs
    (need_run_dir
      "NEED_RUN_DIR: choose one RUN_DIR from docs/slice-runs/<run-name>.")
    (need_source
      "NEED_SOURCE: provide source material or a phase-map packet.")
    (ready_to_implement
      "READY_TO_IMPLEMENT: RUN_DIR/NEXT-SLICE.md is planned.
       Start a fresh session and say: implement the active slice.")
    (ready_to_resume
      "READY_TO_RESUME: RUN_DIR/NEXT-SLICE.md is active-incomplete.
       Start a fresh session and say: resume the active slice.")
    (ready_to_repair_active_slice
      "READY_TO_REPAIR_ACTIVE_SLICE: repair the current slice in a fresh session.")
    (ready_to_implement_corrective_slice
      "READY_TO_IMPLEMENT_CORRECTIVE_SLICE: RUN_DIR/NEXT-SLICE.md is a corrective slice.
       Start a fresh session and say: implement the corrective slice.")
    (ready_to_resume_corrective_slice
      "READY_TO_RESUME_CORRECTIVE_SLICE: RUN_DIR/NEXT-SLICE.md is active-incomplete.
       Start a fresh session and say: resume the corrective slice.")
    (need_new_phase_run_dir
      "NEED_NEW_PHASE_RUN_DIR: this phase is complete. Do not reuse the completed RUN_DIR.
       Consulting deferred_phases sequence in phase_map for suggested next RUN_DIR.
       If explicit user instruction names a different RUN_DIR, use that instead.")
    (need_source_or_repair
      "NEED_SOURCE_OR_REPAIR: provide source or repair run state before continuing.")
    (run_complete
      "RUN_COMPLETE: all approved slices passed, closeout complete, phase sealed."))


  ; ─── HARD STOPS ───────────────────────────────────────────────────────────

  (hard_stops
    (phase_map_does_not_create_run_control)
    (slice_list_does_not_create_next_slice)
    (next_slice_does_not_implement)
    (implementation_does_not_review)
    (review_does_not_plan_next_slice)
    (closeout_does_not_plan_next_phase)
    (phase_contested_gate_does_not_silently_resolve)
    (ambiguous_remaining_work_does_not_proceed_to_closeout)
    (ownership_change_does_not_proceed_without_architecture_decision_slice)
    (prior_deferred_sequence_does_not_block_explicit_user_instruction))


  ; ─── QUALITY GATES ────────────────────────────────────────────────────────

  (quality_gates
    (source_packets_distinguish active_local_source historical_external_evidence)
    (slice_lists_include
      required_outcomes optional_deferred_outcomes
      source_packet prior_closeout non_negotiable_user_intent)
    (required_outcomes_cannot_move_to_closeout_backlog_without_explicit_user_deferral)
    (backlog_item_blocking_named_phase_goal_promotes_to_current_phase_or_requires_user_approval)
    (flag_thin_skeleton_slice_when_phase_goal_requires_physical_architecture)
    (inspect_layer_responsibilities_not_only_init_markers)
    (classification_to_implementation_trace_required_at_closeout)
    (unresolved_required_work_blocks_final_closeout)
    (do_not_make_standalone_target_planning_depend_on_disposable_source_repo)
    (validate_run_dir_against_active_STATUS)
    (do_not_reuse_completed_run_dir_for_new_phase)
    (final_closeout_validates_against_phase_map_required_outcomes_as_primary_authority)
    (architecture_fields_required_in_every_planned_slice
      touched_spokes layer_ownership architecture_guardrails allowed_edits forbidden_edits)
    (contracts_versioned_in_target_repo_for_routed_work)))
```