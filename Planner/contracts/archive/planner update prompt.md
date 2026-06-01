Update the CapEx3 router/planner contracts to integrate the domain-spoke architecture rules into slice planning.

Do not execute the router. Do not run a router mode. This is a docs-only contract edit.

Read first:
- Planner/contracts/codex-session-router-sexpr-experimental.md
- Planner/contracts/codex-repo-slice-planner-sexpr-experimental.md
- Planner/contracts/codex-extraction-packet-schema-sexpr.md

Goal:
Make every planned slice carry explicit architecture ownership. Planning a slice does not grant permission to bypass architecture.

Required edits:
1. Create a target-local architecture contract:
   Planner/contracts/domain-spoke-architecture.md

   Use the reusable domain-spoke architecture instruction from:
   C:\Project\rental_capex2\docs\general-skill-design\domain-spoke-architecture.md

   Copy/adapt it into CapEx3 as a local contract. Keep it project-agnostic except for clearly marked examples. Preserve pseudo-Lisp records.

2. Update Planner/contracts/codex-repo-slice-planner-sexpr-experimental.md.

   Add planner quality gates requiring:
   - read the target-local domain-spoke contract for create_phase_map, create_slice_list, plan_next_slice, and plan_corrective_slice
   - planning a slice does not grant permission to bypass architecture
   - every planned slice must name architecture contract, touched spokes, layer ownership, architecture_guardrails, and ownership decision
   - unclear ownership requires an architecture decision slice
   - architecture decision slices are planning-only
   - silent ownership changes are forbidden

3. Update Planner/contracts/codex-extraction-packet-schema-sexpr.md.

   In packet extraction_next_slice:
   - add architecture to the required fields
   - add architecture_keys with:
     contract
     touched_spokes
     layer_ownership
     architecture_guardrails
     ownership_decision

   Add field_contracts for:
   - architecture
   - contract
   - touched_spokes
   - layer_ownership
   - architecture_guardrails
   - ownership_decision

   Update ordering so next_slice includes architecture before inspect:
   (next_slice goal source_packet run_dir_validation architecture inspect allowed_changes constraints proof next_action)

4. Keep router edits minimal. Only change codex-session-router-sexpr-experimental.md if needed to point at the new target-local architecture contract. Do not change mode behavior.

5. Use lowercase_snake_case atoms and quoted paths/labels/sentences, matching the existing S-expression style.

6. Verify docs only:
   - Search the three router/planner/schema files for architecture, ownership, layer_ownership, touched_spokes, and domain_spoke.
   - Run a diff check if available.
   - Report changed files and any unresolved ambiguity.

Do not edit product code.
Do not create RUN_DIR files.
Do not create NEXT-SLICE.md.
Do not update PROOF-LOG.md.
Do not write to C:\Project\rental_capex2.
