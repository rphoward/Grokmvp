# SLICE-LIST — cursor-landing-p5

Phase **P5 — Indexing & ignore files**.

**Authority:** [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) P5 · [SPEC-ADDENDUM-indexing-ignore.md](../../intake/SPEC-ADDENDUM-indexing-ignore.md) · [SPEC-SEED §8 P5](../../intake/SPEC-SEED-cursor-landing.md) · [dual-publish architecture](../../.cursor/plans/dual-publish-architecture.md) (reference — Lisp ship only; do not edit factory or `cursor-landing/cursor-landing/`).

```lisp
(extraction_slice_list
  (run_dir "Planner/slice-runs/cursor-landing-p5")
  (phase "P5 — Indexing & ignore files")
  (project_shape multi_phase)
  (source_packet "Planner/intake/SPEC-SEED-cursor-landing.md + Planner/intake/SPEC-ADDENDUM-indexing-ignore.md")
  (prior_closeout "Planner/slice-runs/cursor-landing-p4/STATUS.md — final_closeout 2026-05-24; P5 reopened per deferred_phases")

  (goal
    (finish_line "Lisp ship product: baseline .cursorindexingignore, trim append cap 8, post-append read once, Q14 .cursorignore policy, plain Phase 3 closeout, teaching UX without mdc bloat; check-parens + validate-lisp-bundle exit 0.")
    (done_proof "Five slices in PROOF-LOG with passed_closing or passed_with_debt; PHASE-MAP P5 outcomes 1–6 satisfied; deferred_phases empty → project_complete.")
    (slice_count 5)
    (required_outcomes
      (ro-1-baseline-cursorindexingignore)
      (ro-2-scan-trim-indexing-noise)
      (ro-3-q14-dual-host-cursorignore)
      (ro-4-phase3-plain-closeout)
      (ro-5-teaching-ux-no-mdc-ignore-bloat)
      (ro-6-lisp-bundle-proof))
    (optional_deferred_outcomes
      (optional-path-read "addendum optional: one targeted read under scan-appended path — implementer may skip unless dogfood needs it")
      (post-init-index-refresh "slice 2 post-append read; slice 4 closeout new-chat + background line — see addendum index-refresh addendum"))
    (non_negotiable_user_intent
      "P5 edits only github-publish-lisp/cursor-landing-skill/** and lisp verify scripts when manifest needs it; do not edit factory root SKILL.md, references/scan-report.schema.json, github-publish/, cursor-landing/cursor-landing/; do not auto-edit target .gitignore; port semantics to pseudo-Lisp spine per dual-publish plan; never blind-copy factory markdown over Lisp SKILL.md."))

  (constraints
    (layer_mapping "P5 override: application = github-publish-lisp/cursor-landing-skill/SKILL.md; domain = .../references/; infrastructure = .../assets/; presentation = README OVERVIEW install troubleshooting under lisp tree")
    (forbidden_resync_rituals "no repo-wide glob or grep to force codebase reindex; no SDK resync API")
    (allowed_edits
      "github-publish-lisp/cursor-landing-skill/**"
      "github-publish-lisp/check-parens.py"
      "github-publish-lisp/validate-lisp-bundle.py"
      "github-publish-lisp/lisp_bundle_checks.py")
    (forbidden_edits
      "SKILL.md at factory root"
      "references/scan-report.schema.json"
      "github-publish/**"
      "cursor-landing/cursor-landing/**"
      "target .gitignore auto-edit"
      "Planner/** except this RUN_DIR")
    (proof_style "per slice: check-parens.py; closeout: validate-lisp-bundle.py exit 0; record in PROOF-LOG.md"))

  (slices
    (slice
      (number 1)
      (name baseline-indexing-template-phase2)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "github-publish-lisp/cursor-landing-skill/assets/cursorindexingignore.baseline.template"
        "github-publish-lisp/cursor-landing-skill/SKILL.md")
      (done
        "cursorindexingignore.baseline.template exists with commented canonical baseline; Lisp SKILL Phase 2 documents write .cursorindexingignore at target root from template append-only when present; full Phase 2 order ends write baseline then append trim paths then read once — read implemented in slice 2 after trim append")
      (required_outcomes (ro-1-baseline-cursorindexingignore)))

    (slice
      (number 2)
      (name scan-trim-indexing-noise)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect
        "github-publish-lisp/cursor-landing-skill/references/scan-checklist.md"
        "github-publish-lisp/cursor-landing-skill/references/examples/scan-report-example.md"
        "github-publish-lisp/cursor-landing-skill/references/SCAN-REPORT-SCHEMA.md"
        "github-publish-lisp/cursor-landing-skill/SKILL.md")
      (done
        "Phase 0 does not echo baseline in scan_report; trim_candidates indexing_noise append_indexing_ignore cap 8; example scan-report shows pattern; SKILL Phase 2 appends trim paths to .cursorindexingignore then read target-root .cursorindexingignore once (completes ro-1 index nudge); optional single read under one scan-appended path only if needed")
      (required_outcomes (ro-1-baseline-cursorindexingignore ro-2-scan-trim-indexing-noise)))

    (slice
      (number 3)
      (name q14-question-bank-dual-host)
      (slice_type standard)
      (status passed_closing)
      (passed 2026-05-26)
      (depends 2)
      (inspect
        "github-publish-lisp/cursor-landing-skill/references/question-bank.md"
        "github-publish-lisp/cursor-landing-skill/assets/cursorignore.dual-host.template"
        "github-publish-lisp/cursor-landing-skill/references/MERGE-TO-RULES.md"
        "github-publish-lisp/cursor-landing-skill/SKILL.md")
      (done
        "Q14 plain wording when GEMINI.md or .agent/ plus AGENTS.md; keep-both uses cursorignore.dual-host.template append-only; sub-ask CLAUDE.md in .cursorignore when keep-both; Cursor-only skips dual-host block still writes .cursorindexingignore; Cursor-only may add .cursorignore only for scan/grill never-show-Agent paths e.g. tracked secrets; MERGE-TO-RULES reflects .cursorignore policy")
      (required_outcomes (ro-3-q14-dual-host-cursorignore)))

    (slice
      (number 4)
      (name phase3-plain-closeout)
      (slice_type standard)
      (status passed_closing)
      (passed 2026-05-26)
      (depends 3)
      (inspect
        "github-publish-lisp/cursor-landing-skill/SKILL.md"
        "github-publish-lisp/cursor-landing-skill/references/MERGE-TO-RULES.md")
      (done
        "Phase 3 closeout chat only: plain English what was set up; whether user keeps another AI tool on repo; new Cursor chat when .cursorignore written or when fresh @ search matters after indexing-ignore changes; proof command unchanged; one line ignore helps editor features not full security tools may still read files; one line search refresh is background; no skill jargon; no new repo doc unless user asks")
      (required_outcomes (ro-4-phase3-plain-closeout)))

    (slice
      (number 5)
      (name p5-proof-lisp-bundle)
      (slice_type standard)
      (status passed_closing)
      (active_slice_file "Planner/slice-runs/cursor-landing-p5/NEXT-SLICE.md")
      (depends 1 2 3 4)
      (inspect
        "github-publish-lisp/cursor-landing-skill/BUNDLE-MANIFEST.md"
        "github-publish-lisp/cursor-landing-skill/references/troubleshooting.md"
        "github-publish-lisp/cursor-landing-skill/assets/conduct.template.mdc"
        "github-publish-lisp/cursor-landing-skill/assets/project-proof.template.mdc"
        "github-publish-lisp/check-parens.py"
        "github-publish-lisp/validate-lisp-bundle.py"
        "Planner/slice-runs/cursor-landing-p5/PROOF-LOG.md")
      (done
        "troubleshooting.md one line ignore vs security plus Cursor ignore-file docs link; conduct.template.mdc and project-proof.template.mdc have no new ignore-teaching paragraphs; BUNDLE-MANIFEST and lisp_bundle_checks REQUIRED_ASSETS list cursorindexingignore.baseline.template; check-parens and validate-lisp-bundle exit 0; PROOF-LOG complete for slices 1–4; GIT-SHIP checklist satisfied (git remote verified in skill repo)")
      (required_outcomes (ro-5-teaching-ux-no-mdc-ignore-bloat ro-6-lisp-bundle-proof)))

  (next_action
    (mode final_closeout)
    (active_slice none)
    (slice_5_passed_closing 2026-05-26)
    (slice_5_planned 2026-05-26)
    (slice_4_passed_closing 2026-05-26)
    (slice_4_planned 2026-05-26)
    (slice_3_passed_closing 2026-05-26)
    (slice_3_planned 2026-05-26)
    (slice_2_passed_closing 2026-05-26)
    (slice_list_created 2026-05-25)
    (slice_list_revised 2026-05-25)
    (slice_list_approved 2026-05-25)
    (fidelity_recheck "SPEC-ADDENDUM + SPEC-SEED §8 — read-after-trim, mdc negative check, Q14 sub-ask")))
```

| # | Slice | Closes |
|---|--------|--------|
| 1 | baseline-indexing-template-phase2 | ro-1 partial — **passed_closing** 2026-05-26 |
| 2 | scan-trim-indexing-noise | ro-1 complete (post-append `read`) + ro-2 — **passed_closing** 2026-05-26 |
| 3 | q14-question-bank-dual-host | ro-3 — **passed_closing** 2026-05-26 |
| 4 | phase3-plain-closeout | ro-4 — **passed_closing** 2026-05-26 |
| 5 | p5-proof-lisp-bundle | ro-5, ro-6 — **passed_closing** 2026-05-26 → **final_closeout** → `project_complete` |

## Slice scope (decided)

**P5 edit scope:** `github-publish-lisp/cursor-landing-skill/**` (+ parent verify scripts if manifest/checks need updates).

**Git push scope (after P5):** nested repo **`github-publish-lisp/cursor-landing-skill/` only** — not factory root, not parent `github-publish-lisp/`. See [GIT-SHIP.md](GIT-SHIP.md).

**Phase 2 order (addendum):** write baseline → append `trim_candidates` paths → **`read` `.cursorindexingignore` once** — slices **1** then **2**; do not `read` before trim append.

**Slice 1:** `assets/cursorindexingignore.baseline.template` + Lisp `SKILL.md` Phase 2 write step only.

**Slice 2:** scan-checklist, example, schema + SKILL append/trim + post-append `read`.

**Not in scope:** factory `SKILL.md`, `github-publish/`, `cursor-landing/cursor-landing/`, target `.gitignore`, repo-wide glob/grep resync.
