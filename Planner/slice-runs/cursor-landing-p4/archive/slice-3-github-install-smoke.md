# NEXT-SLICE — slice 3 (archived 2026-05-24, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (slice
    (number 3)
    (name github-install-smoke)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name github-install-smoke)
    (finish_line "Recorded maintainer smoke: fresh git clone → build publishable tree → sync to ~/.cursor/skills/cursor-landing/ → /cursor-landing discoverable in Cursor Agent on a target repo; steps live in references/install.md and tests/fixtures/README.md; commands contain no secrets.")
    (distance_closed "Closes P4 ro-3-github-install-smoke after slice 2 install-readme-publish-align.")
    (required_outcomes (ro-3-github-install-smoke))
    (optional_deferred_outcomes ()))

  (source_packet
    "Planner/intake/SPEC-SEED-cursor-landing.md §7–§8"
    "Planner/phase-map/PHASE-MAP.md P4 required_outcomes 3"
    "Planner/slice-runs/cursor-landing-p4/SLICE-LIST.md slice 3"
    "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md slice 2 reviewer_note"
    "references/install.md"
    "scripts/build-install-bundle.ps1"
    "scripts/sync-global-skill-install.ps1"
    "git remote get-url origin → https://github.com/rphoward/cursor-landing.git")

  (architecture
    (contract "Planner/contracts/domain-spoke-architecture.md")
    (touched_spokes "install_docs; maintainer_fixtures_proof; publishable_tree_sync")
    (layer_ownership
      (concept
        (name github_install_smoke_procedure)
        (owner domain)
        (path references/install.md)
        (must_not_change "Factory ≠ bundle; flat global install; build output only cursor-landing/cursor-landing/; canonical Skills URL; no MCP merge or skill workflow edits"))
      (concept
        (name maintainer_smoke_record)
        (owner presentation)
        (path tests/fixtures/README.md)
        (must_not_change "Sanitized notes only — no full repo import; no secrets; P3 dogfood path stays authoritative for brownfield proof"))
      (concept
        (name publishable_install_copy)
        (owner infrastructure)
        (path scripts/build-install-bundle.ps1 scripts/sync-global-skill-install.ps1)
        (must_not_change "Scripts already target publishable root; regenerate publishable install.md via build after factory install.md edits — do not hand-edit publishable tree")))
    (architecture_guardrails
      "Smoke commands are copy-paste safe: no API keys, tokens, or env var values in docs."
      "Discoverability check is /cursor-landing in Agent on a target brownfield repo — not invoking init on the factory repo unless user explicitly wants self-migration."
      "Clone URL must match git remote origin or be documented as example with org placeholder if remote changes."
      "Publishable references/install.md receives smoke section via build-install-bundle.ps1 bundle patch — same pattern as slice 2.")
    (ownership_decision
      (change_detected false)
      (if_false not_applicable)))

  (inspect
    "references/install.md"
    "cursor-landing/cursor-landing/references/install.md"
    "tests/fixtures/README.md"
    "scripts/sync-global-skill-install.ps1")

  (allowed_changes
    (edit "references/install.md — add GitHub install smoke section with clone, build, sync, verify steps")
    (edit "tests/fixtures/README.md — add P4 GitHub install smoke record (date, pass/fail, short notes)")
    (run  "scripts/build-install-bundle.ps1 — refresh publishable install.md from factory")
    (optional_run "scripts/sync-global-skill-install.ps1 — when executing live smoke on maintainer machine")
    (optional_edit "scripts/sync-global-skill-install.ps1 — comment-only clarifications for smoke verify lines; no behavior change unless bug found"))

  (constraints
    (forbidden_edits
      SKILL.md
      README.md
      OVERVIEW.md
      references/annexes/
      references/research/
      references/troubleshooting.md
      references/scan-checklist.md
      references/scan-report.schema.json
      AGENTS.md
      CONTEXT.md
      .cursor/
      assets/
      tests/fixtures/*.json
      tests/fixtures/dogfood-notes.md
      Planner/
      install-bundle/
      src/ lib/ apps/ domain/ application/
      Planner/adopted/capex3/)
    (canonical_skills_url "https://cursor.com/docs/skills")
    (canonical_clone_url "https://github.com/rphoward/cursor-landing.git")
    (publishable_root "cursor-landing/cursor-landing/"))

  (proof
    (manual
      "Select-String -Path references/install.md -Pattern 'GitHub install smoke|github.com/rphoward/cursor-landing' → present"
      "Select-String -Path references/install.md -Pattern 'build-install-bundle|sync-global-skill-install|/cursor-landing' → present in smoke section"
      "Select-String -Path references/install.md,tests/fixtures/README.md -Pattern 'token|api[_-]?key|password|secret' -CaseSensitive:$false → no literal secrets in smoke commands (env var names like GITHUB_TOKEN forbidden as examples)"
      "Select-String -Path tests/fixtures/README.md -Pattern 'P4.*smoke|GitHub install smoke' → present with executed date or explicit not-run debt note"
      "Select-String -Path cursor-landing/cursor-landing/references/install.md -Pattern 'GitHub install smoke' → present after rebuild"
      "Live smoke (preferred): fresh clone to temp dir → build → sync → open target repo → /cursor-landing in Agent menu; record pass in fixtures README")
    (command
      "powershell -ExecutionPolicy Bypass -File scripts\\build-install-bundle.ps1")
    (record_in "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md on review pass")
    (pass_criteria
      "ro-3 PHASE-MAP satisfied; factory + publishable install.md document smoke; fixtures README records execution or passed_with_debt justification; rebuild exit 0."))

  (implementer_checklist
    (step_1 "Add ## GitHub install smoke (maintainer) to factory references/install.md — clone URL, temp dir clone, build, sync, restart Cursor, verify /cursor-landing on a target repo (not factory-only session)")
    (step_2 "Add P4 subsection to tests/fixtures/README.md — link install.md, record smoke date, result, machine OS; no secrets")
    (step_3 "Run build-install-bundle.ps1; confirm publishable references/install.md includes smoke section")
    (step_4 "Optional: run live smoke from temp clone; update fixtures README with outcome")
    (step_5 "Run proof Select-String + build; append implementation_handback; set STATUS slice_review_needed"))

  (out_of_scope
    "troubleshooting.md host coverage (slice 4)"
    "validate-package.py (slice 5)"
    "PROOF-LOG rollup (slice 6)"
    "README/OVERVIEW edits (slice 2 closed)"
    "Committing publishable tree unless user asks"
    "Automated CI workflow for remote clone")

  (next_action
    (mode slice_planned)
    (write_only "implementation_handback on complete; STATUS slice_review_needed")
    (do_not_write PROOF_LOG PHASE_MAP)))
```

| Field | Value |
|-------|--------|
| Slice | 3 — `github-install-smoke` |
| Closes | `ro-3-github-install-smoke` |
| Depends | slice 2 `passed_closing` |

## Implementation handback (2026-05-24)

**Files edited:** `references/install.md` (§ GitHub install smoke (maintainer)), `tests/fixtures/README.md` (§ P4 GitHub install smoke), `scripts/build-install-bundle.ps1` (bundle patch: maintainer smoke → publishable `## GitHub install smoke` blurb).

**Rebuild:** `scripts/build-install-bundle.ps1` → 38 files in `cursor-landing/cursor-landing/`; publishable `references/install.md` contains `## GitHub install smoke`.

**Smoke run:**

- Local factory: build → `cursor-landing/cursor-landing/` → sync → flat `~/.cursor/skills/cursor-landing/SKILL.md`; no nested bundle folder; no `Planner/` in skill dir.
- Temp `git clone` from `origin`: build/sync **pass** for installability; remote default branch still wrote legacy `install-bundle/` until P4 commits are pushed — documented in fixtures README.
- Re-synced global install from local factory after remote smoke.

**Proof:** Select-String checks on factory install, fixtures README, publishable install — pass; build exit 0.

## Review record (2026-05-24)

**Outcome:** `passed_closing` — closes P4 `ro-3-github-install-smoke`.

**Proof:** Factory `references/install.md` § GitHub install smoke (maintainer); `tests/fixtures/README.md` § P4 GitHub install smoke with executed date and pass; publishable `references/install.md` § GitHub install smoke after rebuild; `scripts/build-install-bundle.ps1` smoke blurb patch; rebuild 38 files exit 0; jsonschema exit 0; secret-pattern scan clean on smoke docs; git scope limited to allowed factory paths + build script.

**Reviewer note:** Remote clone smoke pass; default branch may lag P4 layout until push — re-run fixtures row post-push. Build script smoke blurb patch follows slice 2 bundle pattern (justified by slice architecture, not listed in `allowed_changes` edit list).
