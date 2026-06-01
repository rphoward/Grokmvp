# Codex Repo Slice Planner — S-Expression Experimental

Status: experimental planner. Use only when explicitly requested.

```lisp
(planner
  (schema "Planner/contracts/codex-extraction-packet-schema-sexpr.md")

  (contract
    (write_planning_artifacts_only)
    (do_not_implement_code)
    (do_not_review_code)
    (one_mode_one_packet)
    (stop_after_allowed_writes)
    (preserve_non_negotiable_user_intent)
    (prefer_target_local_source_packets_for_standalone_repos)
    (external_repo_paths_are_historical_evidence_not_active_dependencies_unless_user_explicitly_requests_source_repo_reinspection)
    (do_not_convert_required_phase_work_to_backlog_without_user_decision))

  (packet_selection
    ((migration_type extraction) extraction_packets)
    (else stop_unsupported_migration_type))

  (extraction_rules
    (finish "move already-working behavior into cleaner target home")
    (phase_count 2..4)
    (default_phase_count 3)
    (max_phase_map_lines 140)
    (order goal phases_or_slices constraints leave_behind next_action)
    (forbid product_roadmap ux_redesign deployment_plan accounts saved_deals copy_whole_repo))

  (modes
    (create_phase_map
      (packet extraction_phase_map)
      (write phase_map_file)
      (path source_named_path_or "docs/architecture-intake/<short-topic>-phase-map.md")
      (read source_material)
      (inspect source_files_needed_for_claims)
      (forbid RUN_DIR STATUS SLICE_LIST NEXT_SLICE product_code))

    (create_slice_list
      (packet extraction_slice_list)
      (require RUN_DIR approved_phase_map_or_source_packet)
      (require run_dir_not_complete)
      (require source_packet prior_closeout required_outcomes non_negotiable_user_intent)
      (write "RUN_DIR/SLICE-LIST.md" "RUN_DIR/STATUS.md")
      (set_status slice_list_draft)
      (forbid NEXT_SLICE product_code))

    (plan_next_slice
      (packet extraction_next_slice)
      (require RUN_DIR approved_slice_list)
      (require status needs_next_slice_plan)
      (require source_packet required_outcomes)
      (select first_unpassed_slice)
      (write "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
      (forbid product_code PROOF_LOG later_slice_plan))

    (plan_corrective_slice
      (packet extraction_next_slice)
      (require RUN_DIR user_review_reopen_reason approved_or_challenged_slice_list)
      (require source_packet prior_closeout required_outcomes blocking_backlog_items)
      (select unmet_required_phase_intent)
      (write "RUN_DIR/NEXT-SLICE.md" "RUN_DIR/STATUS.md" "RUN_DIR/SLICE-LIST.md")
      (set_status corrective_slice_planned)
      (forbid optional_backlog next_phase_plan product_code PROOF_LOG))

    (final_closeout
      (packet extraction_final_closeout)
      (require RUN_DIR approved_slice_list proof_log required_outcomes)
      (require classification_to_implementation_trace)
      (write "RUN_DIR/STATUS.md" "RUN_DIR/PHASE-BACKLOG.md")
      (write project_support_docs_if_they_repeat_active_run_state)
      (forbid next_phase_plan product_code)))

  (quality_gates
    (source_packets_distinguish active_local_source historical_external_evidence)
    (slice_lists_include required_outcomes optional_deferred_outcomes source_packet prior_closeout non_negotiable_user_intent)
    (required_outcomes_cannot_move_to_closeout_backlog_without_explicit_user_deferral)
    (backlog_item_blocking_named_app_goal_promote_to_current_phase_or_require_user_approval)
    (flag_thin_skeleton_slice_when_phase_goal_requires_physical_architecture)
    (inspect_layer_responsibilities_not_only_init_markers)
    (classification_to_implementation_trace_required)
    (if_classification_says infrastructure_presentation_bootstrap_then_later_slice_must_move_split_or_mark_unresolved_required_work)
    (unresolved_required_work_blocks_final_closeout)
    (run_dir_suggestion_from current_closeout current_backlog source_packet)
    (do_not_make_standalone_target_planning_depend_on_disposable_source_repo)
    (validate_run_dir_against_active_status)
    (do_not_reuse_completed_run_dir_for_new_phase)
    (reuse_completed_or_closing_run_dir_only_for_explicit_repair_or_corrective_slice)
    (if_AGENTS_context_index_backlog_source_packet_run_control_disagree use_active_RUN_DIR_STATUS_plus_user_review_then_repair_docs)
    (final_closeout_records_classification_to_implementation_trace_in_STATUS_closeout_validation)
    (final_closeout_syncs_context_index_and_AGENTS_if_they_repeat_current_run_state)
    (NEXT_SLICE_cleanup_convention archive_then_remove_root_or_mark_reviewed_and_set_STATUS_active_slice_file_none)
    (contracts_are_versioned_in_target_repo_for_capex3_routed_work))

  (format_rules
    (lowercase_snake_case_atoms)
    (quote paths_labels_sentences)
    (constraints_middle)
    (next_action_last)
    (no_reasoning_trace)
    (no_generic_roadmap_prose)))
```
