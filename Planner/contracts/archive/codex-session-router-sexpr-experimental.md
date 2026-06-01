# Codex Session Router — S-Expression Experimental

Status: experimental router. Use only when explicitly requested.

```lisp
(router
  (paths
    (self "Planner/contracts/codex-session-router-sexpr-experimental.md")
    (planner "Planner/contracts/codex-repo-slice-planner-sexpr-experimental.md")
    (schema "Planner/contracts/codex-extraction-packet-schema-sexpr.md"))

  (contract
    (one_session_one_mode)
    (do_not_use_chat_memory)
    (read_planner_only_for create_phase_map create_slice_list approve_or_revise_slice_list plan_next_slice plan_corrective_slice final_closeout)
    (edit_code_only_in implement_active_slice resume_active_slice repair_active_slice implement_corrective_slice resume_corrective_slice)
    (one_legal_router_action_per_session)
    (standalone_target_uses_local_contracts_and_run_control)
    (external_source_repo_paths_are_historical_evidence_not_active_dependencies_unless_user_explicitly_requests_source_repo_reinspection)
    (compound_plan_implement_review_closeout_forbidden_unless_explicit_automation_mode_exists))

  (status_values
    needs_slice_list
    slice_list_draft
    needs_next_slice_plan
    slice_planned
    slice_active_incomplete
    slice_review_needed
    slice_repair_needed
    run_state_repair_needed
    needs_corrective_slice_plan
    corrective_slice_planned
    corrective_slice_active_incomplete
    corrective_slice_review_needed
    final_closeout
    complete)

  (run_dir
    (skip_for create_phase_map)
    (sources prompt_path source_assignment next_action_run_dir phase_backlog_suggested_run_dir phase_map_next_action_run_dir phase_map_recommended_first_run_dir single_live_run)
    (if_missing need_run_dir)
    (completed_run next_phase_requires_new_run_dir)
    (completed_or_closing_run_user_review_reopen keep_same_run_dir_only_for_repair_or_corrective_slice)
    (suggest_new_run_dir_from PHASE_BACKLOG phase_map_next_action phase_map_human_review)
    (if_suggestion_found output_need_new_phase_run_dir_with_suggestion)
    (validate_against_active_status_and_user_review))

  (mode_detection
    ((status complete user_review_says_phase_intent_unmet) user_review_reopen)
    ((status complete user_says repair_or_corrective_slice) user_review_reopen)
    ((status complete source_present) need_new_phase_run_dir_with_suggestion)
    ((status complete user_says create_slice_list) need_new_phase_run_dir_with_suggestion)
    ((status complete user_says plan_next_slice) need_new_phase_run_dir_with_suggestion)
    ((status complete user_asks next_phase) need_new_phase_run_dir_with_suggestion)
    ((source_names create_phase_map) create_phase_map)
    ((source_names create_slice_list) create_slice_list)
    ((status_missing source_present) create_slice_list)
    ((status_missing) need_source)
    ((status needs_slice_list source_present) create_slice_list)
    ((status needs_slice_list) need_source)
    ((status slice_list_draft) approve_or_revise_slice_list)
    ((status needs_next_slice_plan) plan_next_slice)
    ((status slice_planned user_says implement) implement_active_slice)
    ((status slice_planned) ready_to_implement)
    ((status slice_active_incomplete user_says resume) resume_active_slice)
    ((status slice_active_incomplete) ready_to_resume)
    ((status slice_review_needed) review_finished_slice)
    ((status slice_repair_needed user_says repair) repair_active_slice)
    ((status slice_repair_needed) ready_to_repair_active_slice)
    ((status passed_closing user_review_says_phase_intent_unmet) user_review_reopen)
    ((status final_closeout user_review_says_phase_intent_unmet) user_review_reopen)
    ((status run_state_repair_needed) need_source_or_repair)
    ((status needs_corrective_slice_plan) plan_corrective_slice)
    ((status corrective_slice_planned user_says implement) implement_corrective_slice)
    ((status corrective_slice_planned) ready_to_implement_corrective_slice)
    ((status corrective_slice_active_incomplete user_says resume) resume_corrective_slice)
    ((status corrective_slice_active_incomplete) ready_to_resume_corrective_slice)
    ((status corrective_slice_review_needed) review_corrective_slice)
    ((status final_closeout) final_closeout)
    ((status complete) run_complete)
    (else need_source_or_repair))

  (writes
    (create_phase_map phase_map_file)
    (create_slice_list "RUN_DIR/SLICE-LIST.md" "RUN_DIR/STATUS.md")
    (plan_next_slice "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (implement_active_slice allowed_changes "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (resume_active_slice allowed_changes "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (review_finished_slice "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md" "RUN_DIR/PROOF-LOG.md" "RUN_DIR/archive/")
    (repair_active_slice allowed_changes "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (user_review_reopen "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md" "RUN_DIR/PHASE-BACKLOG.md")
    (plan_corrective_slice "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (implement_corrective_slice allowed_changes "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (resume_corrective_slice allowed_changes "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
    (review_corrective_slice "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md" "RUN_DIR/PROOF-LOG.md" "RUN_DIR/archive/")
    (final_closeout "RUN_DIR/STATUS.md" "RUN_DIR/PHASE-BACKLOG.md" project_support_docs_if_they_repeat_active_run_state))

  (workflows
    (create_phase_map
      (read source planner schema)
      (write phase_map_file)
      (forbid RUN_DIR STATUS SLICE_LIST NEXT_SLICE product_code)
      stop)

    (create_slice_list
      (require RUN_DIR)
      (require run_dir_not_complete)
      (read source approved_phase_map_or_source_packet planner schema)
      (write SLICE_LIST STATUS)
      (set_status slice_list_draft)
      (forbid NEXT_SLICE product_code)
      stop)

    (approve_or_revise_slice_list
      (read SLICE_LIST)
      (if revised (read planner) (update SLICE_LIST))
      (if approved (set_status needs_next_slice_plan))
      (forbid NEXT_SLICE product_code)
      stop)

    (plan_next_slice
      (require RUN_DIR)
      (require status needs_next_slice_plan)
      (read STATUS SLICE_LIST planner schema)
      (write NEXT_SLICE)
      (set_status slice_planned)
      (mark_slice planned)
      (forbid product_code PROOF_LOG)
      stop)

    (implement_active_slice
      (read NEXT_SLICE)
      (follow NEXT_SLICE)
      (forbid planner PROOF_LOG next_slice_plan)
      (if incomplete (set_next_slice active_incomplete) (set_status slice_active_incomplete) stop)
      (if complete (set_next_slice review_needed) (append implementation_handback) (set_status slice_review_needed) stop))

    (resume_active_slice
      (read NEXT_SLICE)
      (follow mid_slice_resume_note)
      (same_rules_as implement_active_slice))

    (review_finished_slice
      (read STATUS SLICE_LIST NEXT_SLICE)
      (verify proof docs cleanup git_state)
      (verify required_outcomes_from_phase_goal)
      (classify passed_closing passed_with_debt partial failed invalidated scope_drift)
      (if required_outcome_unmet (classify partial) (set_status slice_repair_needed) (forbid pass_record))
      (if passed_closing_or_passed_with_debt (append PROOF_LOG) (set_next_slice reviewed) (archive NEXT_SLICE) (remove_or_mark_root_NEXT_SLICE_reviewed))
      (if another_unpassed_slice (set_status needs_next_slice_plan))
      (if no_unpassed_slice (set_status final_closeout))
      (if partial_or_failed (set_status slice_repair_needed) (forbid pass_record))
      (if invalidated_or_scope_drift (set_status run_state_repair_needed) (forbid pass_record))
      (forbid product_code next_slice_plan)
      stop)

    (repair_active_slice
      (read NEXT_SLICE)
      (follow review_result)
      (repair_current_slice_only)
      (set_next_slice review_needed)
      (set_status slice_review_needed)
      (forbid planner PROOF_LOG next_slice_plan)
      stop)

    (user_review_reopen
      (require user_review_reopen_reason)
      (read STATUS SLICE_LIST PHASE_BACKLOG PROOF_LOG)
      (record user_review_reopen_reason)
      (classify run_state_repair_needed needs_corrective_slice_plan scope_decision_needed)
      (if unmet_required_phase_intent (set_status needs_corrective_slice_plan))
      (if unclear_required_vs_optional (set_status run_state_repair_needed))
      (forbid final_closeout run_complete next_phase_plan product_code)
      stop)

    (plan_corrective_slice
      (require RUN_DIR user_review_reopen_reason)
      (read STATUS SLICE_LIST PHASE_BACKLOG planner schema source_packet prior_closeout)
      (select unmet_required_phase_intent_only)
      (write NEXT_SLICE)
      (update SLICE_LIST corrective_slice)
      (set_status corrective_slice_planned)
      (forbid optional_backlog next_phase_plan product_code PROOF_LOG)
      stop)

    (implement_corrective_slice
      (read NEXT_SLICE)
      (follow corrective_slice_allowed_changes)
      (if incomplete (set_next_slice active_incomplete) (set_status corrective_slice_active_incomplete) stop)
      (if complete (set_next_slice review_needed) (append implementation_handback) (set_status corrective_slice_review_needed) stop))

    (resume_corrective_slice
      (read NEXT_SLICE)
      (follow mid_slice_resume_note)
      (same_rules_as implement_corrective_slice))

    (review_corrective_slice
      (read STATUS SLICE_LIST NEXT_SLICE PROOF_LOG)
      (verify corrective_slice_reason)
      (verify why_prior_closeout_was_not_sufficient)
      (verify required_outcomes_from_phase_goal)
      (classify passed_closing partial failed invalidated scope_drift)
      (if passed_closing (append PROOF_LOG) (set_next_slice reviewed) (archive NEXT_SLICE) (remove_or_mark_root_NEXT_SLICE_reviewed))
      (if required_outcomes_now_satisfied (set_status final_closeout))
      (if partial_or_failed (set_status slice_repair_needed) (forbid pass_record))
      (if invalidated_or_scope_drift (set_status run_state_repair_needed) (forbid pass_record))
      (forbid product_code next_slice_plan)
      stop)

    (final_closeout
      (verify all_slices_passed_or_debt_recorded)
      (verify PROOF_LOG)
      (verify required_outcomes_from_phase_goal_physically_satisfied)
      (verify classification_to_implementation_trace_in_STATUS_closeout_validation)
      (if required_outcome_deferred (set_status run_state_repair_needed) (forbid complete) stop)
      (if blocking_backlog_item_exists (set_status needs_corrective_slice_plan) (forbid complete) stop)
      (classify_remaining_work new_phase deferred failed)
      (if required_remaining_work (set_status run_state_repair_needed) (forbid PHASE_BACKLOG_optional_deferral complete) stop)
      (if optional_or_explicitly_out_of_scope_deferred (write PHASE_BACKLOG backlog_records_first with_source_reason_suggested_run_dir_first_inspect_proof_boundary))
      (write STATUS closeout_validation with_required_outcomes_proof_log_classification_trace_blocking_backlog_items_final_proof)
      (sync_project_support_docs_that_repeat_active_run_state AGENTS context_index)
      (if root_NEXT_SLICE_exists_after_archive (remove_or_mark_reviewed_and_set_STATUS_active_slice_file_none))
      (if lesson_no_done_state_impact (append PHASE_BACKLOG phase_lesson_after_backlog_records max_1_line))
      (if lesson_clarifies_or_changes_done_state (append PHASE_BACKLOG contract_note_after_backlog_records max_5_lines))
      (set_status complete)
      (forbid next_phase_plan)
      stop))

  (outputs
    (need_run_dir "NEED_RUN_DIR: choose one RUN_DIR from docs/slice-runs/<run-name>.")
    (need_source "NEED_SOURCE: provide source material or a phase-map packet.")
    (ready_to_implement "READY_TO_IMPLEMENT: RUN_DIR/NEXT-SLICE.md is planned; start a fresh session and say implement the active slice.")
    (ready_to_resume "READY_TO_RESUME: RUN_DIR/NEXT-SLICE.md is active-incomplete; start a fresh session and say resume the active slice.")
    (ready_to_repair_active_slice "READY_TO_REPAIR_ACTIVE_SLICE: repair the current slice in a fresh session.")
    (ready_to_implement_corrective_slice "READY_TO_IMPLEMENT_CORRECTIVE_SLICE: RUN_DIR/NEXT-SLICE.md is a corrective slice; start a fresh session and say implement the corrective slice.")
    (ready_to_resume_corrective_slice "READY_TO_RESUME_CORRECTIVE_SLICE: RUN_DIR/NEXT-SLICE.md is active-incomplete; start a fresh session and say resume the corrective slice.")
    (need_new_phase_run_dir "NEED_NEW_PHASE_RUN_DIR: use a new RUN_DIR and previous closeout or phase backlog as source.")
    (need_new_phase_run_dir_with_suggestion "NEED_NEW_PHASE_RUN_DIR: do not reuse the completed RUN_DIR. If PHASE-BACKLOG.md, phase_map.next_action.run_dir, or phase_map.human_review.recommended_first_run_dir suggests a next RUN_DIR, offer that path and cite the source; otherwise ask the user to choose docs/slice-runs/<new-phase-name>.")
    (need_source_or_repair "NEED_SOURCE_OR_REPAIR: provide source or repair run state before continuing.")
    (run_complete "RUN_COMPLETE: all approved slices passed and closeout is complete."))

  (hard_stops
    (phase_map_does_not_create_run_control)
    (slice_list_does_not_create_next_slice)
    (next_slice_does_not_implement)
    (implementation_does_not_review)
    (review_does_not_plan_next_slice)
    (closeout_does_not_plan_next_phase))

  (coordination_rules
    (required_phase_outcomes_cannot_be_silently_converted_to_backlog_debt)
    (blocking_backlog_items_promote_to_current_slice_list_or_require_user_deferral)
    (only_optional_or_explicitly_out_of_scope_work_may_enter_phase_backlog_at_closeout)
    (run_dir_suggestions_must_cite_current_closeout_backlog_or_source_packet)
    (source_packet_must_distinguish_active_local_source_from_historical_external_evidence)
    (preserve_user_vocabulary preferred_layer_names rejected_layer_names non_negotiable_intent)
    (when_docs_disagree active_RUN_DIR_STATUS_plus_user_review_wins_then_repair_docs)
    (final_closeout_syncs_support_docs_if_they_repeat_state)
    (classification_to_implementation_trace_lives_in_STATUS_closeout_validation)
    (NEXT_SLICE_cleanup_convention archive_then_remove_root_or_mark_reviewed_and_set_active_slice_file_none)
    (contracts_are_versioned_in_target_repo_for_capex3_routed_work)
    (parallel_future_note slices_need_disjoint_write_sets_explicit_ownership_review_aggregation_and_proof_boundaries)))
```
