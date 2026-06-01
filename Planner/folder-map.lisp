;;; folder-map.lisp
;;; Dependency tree rooted at the v4 unified router/planner contract.
;;; Generated 2026-05-17
;;;
;;; Grammar:
;;;   (node "path" :role <role> :kind <kind> :children ( ... ))
;;;
;;;   :role  — what this node is to its parent
;;;            root | declared-path | runtime-state | scaffold |
;;;            steering | gate | source | handoff | archive | group
;;;   :kind  — surface form
;;;            contract | normative | runtime | stub | md | dir |
;;;            archived | implied

(node "Planner/contracts/codex-router-planner-unified.md"
  :role  root
  :kind  contract
  :version v4
  :summary "router decision tree · phase tier · slice tier · review/closeout · hard stops"
  :children (

    ;; ── declared in (paths …) at top of the contract ───────────────────────
    (group "paths" :role group :children (
      (node "Planner/contracts/codex-extraction-packet-schema-sexpr.md"
        :role declared-path :kind normative
        :as schema
        :purpose "s-expression packet shapes for slice-list, next-slice, corrective, decision, closeout")
      (node "Planner/contracts/domain-spoke-architecture.md"
        :role declared-path :kind normative
        :as architecture
        :purpose "ownership · dependency direction · naming · spoke vocabulary")
      (node "Planner/phase-map/PHASE-MAP.md"
        :role declared-path :kind runtime
        :as phase_map
        :purpose "required outcomes · deferred phases · non-negotiable intent"
        :children (
          (node "Planner/phase-map/PHASE-MAP.stub.md"
            :role scaffold :kind stub
            :purpose "template copied to PHASE-MAP.md at create_phase_map")))))

    ;; ── active run resolution (active_run_pointer + run_dir_authority) ─────
    (group "active-run" :role group :children (
      (node "Planner/router-state.md"
        :role runtime-state :kind runtime
        :as active_run_pointer
        :tier 2
        :fields (active_run_dir active_status active_phase updated))

      (node "Planner/slice-runs/"
        :role group :kind dir
        :purpose "RUN_DIR base — one subdir per run"
        :children (
          (node "Planner/slice-runs/_template/"
            :role scaffold :kind dir
            :purpose "copied to a fresh RUN_DIR at run creation"
            :children (
              (node "SLICE-LIST.stub.md"  :role scaffold :kind stub)
              (node "STATUS.md"           :role runtime-state :kind runtime
                :fields (current_mode active_slice_file next_action project_shape closeout_validation))

              ;; implied per-run artifacts — written by router modes, not in repo
              (node "NEXT-SLICE.md"       :role runtime-state :kind implied
                :fields (slice_type implementation_allowed decision_id resolution_id allowed_edits forbidden_edits))
              (node "PROOF-LOG.md"        :role runtime-state :kind implied
                :fields (slice_type status decision_id resolution_id)
                :statuses (passed_closing passed_with_debt))
              (node "PHASE-BACKLOG"       :role runtime-state :kind implied
                :purpose "deferred items recorded at final_closeout")))))))

    ;; ── steering kit consumed in the read-order ───────────────────────────
    (group "steering-kit" :role group :children (
      (node "Planner/AGENTS.md"
        :role steering :kind md
        :read-order 4
        :purpose "precedence vs root AGENTS.md · architecture echo · write boundaries")
      (node "Planner/context-index.md"
        :role steering :kind md
        :read-order 3
        :purpose "greenfield read order for the portable kit")
      (node "Planner/contracts/README.md"
        :role steering :kind md
        :read-order 5
        :purpose "v4 contract index · pointers to schema / architecture / handoff")))

    ;; ── phase-map kit ─────────────────────────────────────────────────────
    (group "phase-map-kit" :role group :children (
      (node "Planner/phase-map/README.md" :role steering :kind md)
      (node "Planner/contracts/phase_map_review_prompt.md"
        :role gate :kind normative
        :purpose "chat-only validation gate consumed before PHASE-MAP approval")
      (node "Planner/phase-map/validation/" :role group :kind dir :children (
        (node "README.md" :role steering :kind md)
        (node ".gitkeep"  :role scaffold :kind misc)))))

    ;; ── intake (source packet for create_phase_map / create_slice_list) ───
    (group "intake" :role group :children (
      (node "Planner/intake/SPEC-SEED.stub.md"
        :role source :kind stub
        :purpose "replace with real spec or source-packet reference before planning")))

    ;; ── handoff & archive ─────────────────────────────────────────────────
    (group "handoff-and-archive" :role group :children (

      (node "Planner/contracts/router-planner-v4-handoff.md"
        :role handoff :kind md
        :purpose "v3 → v4 transition notes (F1–F6 fixes)")

      (node "Planner/contracts/archive/" :role archive :kind dir
        :status superseded
        :children (
          (node "Codex Router Planner — Unified.md"                         :kind archived)
          (node "codex-router-planner-unified.md"                           :kind archived)
          (node "codex-extraction-packet-schema-sexpr.md"                   :kind archived)
          (node "codex-repo-slice-planner-sexpr-experimental.md"            :kind archived)
          (node "codex-session-router-sexpr-experimental.md"                :kind archived)
          (node "capex3-unified-upgrade-prompt.md"                          :kind archived)
          (node "schema-additions-next-slice-architecture.md"               :kind archived)
          (node "schema-additions-next-slice-architecture_1.md"             :kind archived)
          (node "planner update prompt.md"                                   :kind archived)
          (node "Install-RouterPlanner, needs all files and a docs directory in new project preexisting" :kind archived)
          (node "It's almost portable, change some repo stuff for each project.md" :kind archived)
          (node "README.md"                                                  :kind archived)
          (node "files.zip"                                                  :kind archived)
          (node "files/" :role group :kind dir :children (
            (node "codex-router-planner-unified.md"        :kind archived)
            (node "codex-extraction-packet-schema-sexpr.md" :kind archived)
            (node "router-planner-v4-handoff.md"           :kind archived)
            (node "v4-file-authority-map.mmd"              :kind archived))))))))
)
