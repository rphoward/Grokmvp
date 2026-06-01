# Codex Extraction Packet Schema — S-Expression Experimental

Status: experimental schema for extraction planning packets.

```lisp
(packet_schema
  (domain extraction)
  (meaning "move already-working behavior from mixed source repo to cleaner target home with minimal behavior change")

  (atom_rules
    (keys lowercase_snake_case)
    (enum_values lowercase_snake_case)
    (quote paths labels sentences)
    (forbid reasoning_trace generic_roadmap_prose))

  (packet extraction_phase_map
    (trigger create_phase_map)
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
    (goal_keys source target finish_line done_proof phase_count move_to_target_after required_outcomes optional_deferred_outcomes non_negotiable_user_intent)
    (phase_keys number name repo depends proof_claim done required_outcomes deferred_outcomes)
    (next_action_keys mode run_dir source write_only do_not_write))

  (packet extraction_slice_list
    (trigger create_slice_list)
    (max_lines 160)
    (required
      run_dir
      phase
      goal
      source_packet
      prior_closeout
      required_outcomes
      optional_deferred_outcomes
      slices
      constraints
      next_action)
    (goal_keys finish_line done_proof slice_count required_outcomes optional_deferred_outcomes non_negotiable_user_intent)
    (slice_keys number name status depends inspect done required_outcomes blocking_backlog_items corrective_slice_reason)
    (next_action_keys mode write_only do_not_write))

  (packet extraction_next_slice
    (trigger plan_next_slice)
    (max_lines 180)
    (required
      run_dir
      slice
      goal
      source_packet
      architecture
      inspect
      allowed_changes
      constraints
      proof
      next_action)
    (goal_keys name finish_line distance_closed required_outcomes optional_deferred_outcomes corrective_slice_reason user_review_reopen_reason)
    (optional run_dir_validation inspect_first)
    (architecture
      (contract
        "Planner/contracts/domain-spoke-architecture.md")
      (touched_spokes
        "spoke name — list every spoke this slice touches")
      (layer_ownership
        (concept
          (name          "concept name")
          (owner         domain | application | infrastructure | presentation)
          (must_not_change
            "layer boundary not in scope for this slice")))
      (architecture_guardrails
        "specific rule this slice must preserve")
      (ownership_decision
        (change_detected   true | false)
        (if_true
          (approved        true | false)
          (decision_slice  "path to architecture_decision_slice or pending"))
        (if_false
          not_applicable)))
    (inspect_keys inspect inspect_first)
    (proof_keys manual command optional)
    (next_action_keys mode write_only do_not_write))

  (packet extraction_final_closeout
    (trigger final_closeout)
    (max_lines 180)
    (required
      run_dir
      phase
      required_outcomes
      proof_log_verification
      classification_to_implementation_trace
      remaining_work_classification
      blocking_backlog_items
      optional_deferred_outcomes
      support_doc_sync
      next_action)
    (proof_log_verification_keys all_slices_passed proof_log_verified final_proof_rerun)
    (classification_to_implementation_trace_location "RUN_DIR/STATUS.md closeout_validation")
    (remaining_work_classification_keys optional explicit_deferred required_remaining failed)
    (support_doc_sync_keys AGENTS context_index active_run_state_fields_synced next_slice_cleanup)
    (next_action_keys mode write_only do_not_write))

  (field_contracts
    (required_outcomes "Phase or slice outcomes that must be physically satisfied before closeout; they cannot be moved to PHASE-BACKLOG without explicit user deferral.")
    (optional_deferred_outcomes "Work that is optional, explicitly out of scope, or user-approved for later backlog.")
    (corrective_slice_reason "Why this slice exists after a reviewed, closing, or completed run was found not to satisfy required phase intent.")
    (user_review_reopen_reason "User review statement or summary that reopened a passed_closing, final_closeout, or complete run.")
    (blocking_backlog_items "Backlog records that block the named app goal and must be promoted into the current phase or explicitly deferred by the user.")
    (approved_phase_map_or_source_packet "Direct slice-list planning may use either an approved phase map or a source packet that supplies run_dir, prior_closeout, required_outcomes, optional_deferred_outcomes, constraints, and non_negotiable_user_intent.")
    (source_packet "Named source material used to plan the phase or slice. In standalone targets, this must distinguish active_local_source from historical_external_evidence, and external source-repo paths must not be required unless the user explicitly requests source-repo reinspection.")
    (prior_closeout "Previous STATUS, PROOF-LOG, PHASE-BACKLOG, or closeout source that this plan carries forward.")
    (run_dir_validation "Evidence that the RUN_DIR is new for a new phase, or reused only because the task is explicit repair/corrective-slice work.")
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
      (forbid   "omitting a concept introduced by allowed_changes"))
    (architecture_guardrails
      (required true)
      (type     list_of_strings)
      (purpose  "specific rules from architecture contract this slice must preserve")
      (forbid   generic_placeholder_text))
    (ownership_decision
      (required true)
      (type     record)
      (purpose  "explicit gate on whether ownership change was detected and handled")
      (rule
        (if change_detected_true_and_approved_false
          → "architecture_decision_slice required before this slice may proceed")
        (if change_detected_true_and_decision_slice_missing
          → "blocked — ownership change without decision record is forbidden")
        (if change_detected_false
          → not_applicable_is_valid)))
    (classification_to_implementation_trace "Closeout evidence that each required classification or slice outcome was physically implemented, deferred by explicit user decision, or classified as optional.")
    (support_doc_sync "Closeout evidence that AGENTS.md, Planner/context-index.md, and other support docs that repeat active run state were updated or intentionally left to defer to STATUS.md.")
    (next_slice_cleanup "Closeout convention for the root NEXT-SLICE.md after archive: remove it, or mark it reviewed and set STATUS.active_slice_file to none."))

  (ordering
    (phase_map goal phases move_list constraints leave_behind human_review next_action)
    (slice_list goal source_packet prior_closeout required_outcomes optional_deferred_outcomes slices constraints next_action)
    (next_slice goal source_packet run_dir_validation architecture inspect allowed_changes constraints proof next_action)
    (final_closeout required_outcomes proof_log_verification classification_to_implementation_trace remaining_work_classification blocking_backlog_items optional_deferred_outcomes support_doc_sync next_action))

  (default_constraints
    (do_not copy_whole_repo)
    (do_not write_target_repo_before_approved_phase)
    (do_not migrate_javascript_by_default)
    (do_not redesign_ui)
    (do_not add_deployment)
    (do_not add_accounts)
    (do_not add_saved_deals)
    (do_not create_product_roadmap)))
```
