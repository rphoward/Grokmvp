# CapEx3 Router Planner — Unified Contract Upgrade Prompt

Do not execute the router.
Do not run any router mode.
Do not edit product code.
Do not create RUN_DIR files, NEXT-SLICE.md, or PROOF-LOG.md.
This is a docs-only contract edit.

---

## Context

The prior router and planner were two files that evolved separately into a
patchwork. This prompt installs a unified replacement and the schema additions
that complete it. The key structural changes are:

- Two files become one unified contract.
- Phase tier is now explicit above the slice tier.
- run_state_repair_needed is replaced by phase_contested_gate, a hard
  classification gate that requires explicit user decision before routing.
- Architecture rules are embedded as S-expression enforcement clauses, not
  referenced as Markdown prose. Markdown is read as documentation. S-expressions
  are read as instructions.
- run_dir_authority establishes an explicit priority hierarchy. Explicit user
  instruction this session always beats a prior deferred sequence.
- deferred_phases in the phase map carry order and prerequisite, but are a
  planning signal not a gate. User instruction overrides without requiring
  justification.
- review_gate is a single parameterized gate for all slice types. slice_context
  is the only entry difference between standard, repair, and corrective.
- Architecture fields are required in every planned slice via the schema.

---

## Files To Write

### 1. Install the unified contract

Write this file in full exactly as provided:

  Planner/contracts/codex-router-planner-unified.md

Source: the unified contract provided in this session.

This file replaces both:
  Planner/contracts/codex-session-router-sexpr-experimental.md
  Planner/contracts/codex-repo-slice-planner-sexpr-experimental.md

Do not delete the old files yet. Add a deprecation header to each:

  ; DEPRECATED — superseded by codex-router-planner-unified.md
  ; Retained for reference only. Do not route against this file.

### 2. Update the schema

File: Planner/contracts/codex-extraction-packet-schema-sexpr.md

Apply these changes:

a) Update the field ordering for extraction_next_slice:

   (next_slice
     goal
     source_packet
     run_dir_validation
     architecture
     inspect
     allowed_changes
     constraints
     proof
     next_action)

b) Add the architecture block as a required field in extraction_next_slice:

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

c) Add field_contracts for the five new fields:

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

### 3. Confirm domain-spoke-architecture.md is present

  Planner/contracts/domain-spoke-architecture.md

This file must exist as a local contract. It is referenced by the architecture
block in every planned slice. If not present, copy from the source provided
in this session. Do not modify its content. It is a reusable project-agnostic
rule set. Project-specific terms belong only inside sections labeled Example.

---

## Style Rules

Match the existing S-expression style throughout:
- lowercase_snake_case atoms
- quoted paths, labels, and sentences
- no reasoning trace in output
- no generic roadmap prose

---

## Verification Steps

After writing, verify docs only:

1. Search codex-router-planner-unified.md for:
   architecture, touched_spokes, layer_ownership, architecture_guardrails,
   ownership_decision, phase_contested, phase_states under the PHASE TIER section, run_dir_authority,
   deferred_phases, review_gate
   Confirm each is present as a structural clause, not a comment.

2. Search codex-extraction-packet-schema-sexpr.md for:
   architecture, touched_spokes, layer_ownership, architecture_guardrails,
   ownership_decision
   Confirm each appears in both the packet definition and field_contracts.

3. Confirm extraction_next_slice ordering places architecture before inspect.

4. Confirm deprecated headers are present on both old files.

5. Confirm domain-spoke-architecture.md exists at the expected path.

6. Report:
   - files changed
   - files created
   - files deprecated
   - any field in the unified contract that references the schema but
     has no corresponding field_contract entry
   - any unresolved ambiguity

---

## Hard Stops

Do not proceed if any of the following are true:

- The unified contract file was not provided in this session.
- domain-spoke-architecture.md cannot be located.
- Any required field in extraction_next_slice would be left without
  a corresponding field_contract entry after this edit.
- Any mode in the unified contract references a file path that does
  not exist and cannot be created by this prompt.
