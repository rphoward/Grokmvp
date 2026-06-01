# Schema Additions — codex-extraction-packet-schema-sexpr.md
# Add these to the extraction_next_slice packet definition.
# These are additions only — all existing fields are preserved.

; ─── UPDATED FIELD ORDERING ───────────────────────────────────────────────
; architecture moves in before inspect

(next_slice
  goal
  source_packet
  run_dir_validation
  architecture          ; NEW — required before inspect
  inspect
  allowed_changes
  constraints
  proof
  next_action)


; ─── ARCHITECTURE BLOCK ───────────────────────────────────────────────────
; Required in every extraction_next_slice packet.
; A slice without a complete architecture block must not be written.

(architecture
  (contract
    "Planner/contracts/domain-spoke-architecture.md")

  (touched_spokes
    "spoke name — list every spoke this slice touches")

  (layer_ownership
    ; One entry per new concept introduced by this slice.
    (concept
      (name          "concept name")
      (owner         domain | application | infrastructure | presentation)
      (must_not_change
        "layer boundary explicitly not in scope for this slice")))

  (architecture_guardrails
    ; Specific rules from the architecture contract this slice must preserve.
    "rule — one per line")

  (ownership_decision
    (change_detected   true | false)
    (if_true
      (approved        true | false)
      (decision_slice  "path to architecture_decision_slice or pending"))
    (if_false
      not_applicable)))


; ─── FIELD CONTRACTS ──────────────────────────────────────────────────────
; Add these to the existing field_contracts block.

(field_contracts

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
        → not_applicable_is_valid))))
