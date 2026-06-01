# SLICE-LIST — cursor-landing-p4

Phase **P4 — Publish & install path**. Authority: [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) phase order 4 (final), [SPEC-SEED](../../intake/SPEC-SEED-cursor-landing.md) §7–§8.

```lisp
(extraction_slice_list
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (phase "P4 — Publish & install path")
  (project_shape multi_phase)
  (source_packet "Planner/intake/SPEC-SEED-cursor-landing.md")
  (prior_closeout "Planner/slice-runs/cursor-landing-p3/STATUS.md — final_closeout 2026-05-24; phase_sealed")

  (goal
    (finish_line "Close P4: cursor-landing/cursor-landing/ publishable tree built by factory scripts; factory + publishable README/OVERVIEW/install aligned; GitHub install smoke recorded; troubleshooting covers P1 hosts; validate-package.py runs on publishable root.")
    (done_proof "Six slices in PROOF-LOG with passed_closing or passed_with_debt; PHASE-MAP P4 outcomes 1–6 satisfied; deferred_phases empty → project_complete.")
    (slice_count 6)
    (required_outcomes
      (ro-1-publishable-tree-scaffold)
      (ro-2-readme-overview-install-accurate)
      (ro-3-github-install-smoke)
      (ro-4-troubleshooting-new-hosts)
      (ro-5-validate-package-py)
      (ro-6-maintainer-proof-note))
    (optional_deferred_outcomes
      (automated-repo-scanner "out of phase map — PHASE-BACKLOG")
      (team-mcp-merge-templates "user-invoked only"))
    (non_negotiable_user_intent
      "Skill-only product; sole publishable path cursor-landing/cursor-landing/; excludes Planner/, factory .cursor/, factory CONTEXT/AGENTS, tests/, docs/, research PDFs; global install ~/.cursor/skills/cursor-landing/ flat; no src/ lib/ apps/ domain/ application/ trees; P3 dogfood C:\\Projects\\Kbupgrade - Copy (4) — sanitized notes in tests/fixtures/ only."))

  (constraints
    (layer_mapping "SPEC-SEED §7 — references/ domain, SKILL.md application, assets/ scripts/ infrastructure, README OVERVIEW presentation")
    (forbidden_edits src lib apps domain application)
    (forbidden_planner_adopted "Planner/adopted/capex3/ — reference-only unless explicit fix")
    (publishable_root "cursor-landing/cursor-landing/ — sole output; retire repo-root install-bundle/ as build destination in slice 1")
    (proof_style "build/sync scripts + validate-package.py exit 0 on publishable root + link pass; record in PROOF-LOG.md per slice"))

  (slices
    (slice
      (number 1)
      (name publishable-tree-scaffold)
      (slice_type standard)
      (status passed_closing)
      (depends none)
      (inspect
        "cursor-landing/cursor-landing/"
        "cursor-landing/cursor-landing/BUNDLE-MANIFEST.md"
        "scripts/build-install-bundle.ps1"
        "scripts/sync-global-skill-install.ps1")
      (done
        "cursor-landing/cursor-landing/ populated by build script; BUNDLE-MANIFEST.md at publishable root; build/sync scripts target publishable path only; legacy install-bundle/ no longer build output; exclusions enforced; flat ~/.cursor/skills/cursor-landing/ documented")
      (required_outcomes (ro-1-publishable-tree-scaffold)))

    (slice
      (number 2)
      (name install-readme-publish-align)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect
        "README.md"
        "OVERVIEW.md"
        "references/install.md"
        "cursor-landing/cursor-landing/README.md"
        "cursor-landing/cursor-landing/OVERVIEW.md"
        "cursor-landing/cursor-landing/references/install.md")
      (done
        "Factory + cursor-landing/cursor-landing/ copies agree: clone → scripts/build-install-bundle.ps1 → sync to ~/.cursor/skills/cursor-landing/; factory root ≠ bundle; canonical Skills URL; no install-bundle/ as install target")
      (required_outcomes (ro-2-readme-overview-install-accurate)))

    (slice
      (number 3)
      (name github-install-smoke)
      (slice_type standard)
      (status passed_closing)
      (depends 2)
      (inspect
        "references/install.md"
        "cursor-landing/cursor-landing/references/install.md"
        "tests/fixtures/README.md"
        "scripts/sync-global-skill-install.ps1")
      (done
        "Recorded smoke: fresh tree → build publishable tree → sync → /cursor-landing discoverable (install.md or fixtures README); no secrets in commands")
      (required_outcomes (ro-3-github-install-smoke)))

    (slice
      (number 4)
      (name troubleshooting-hosts-coverage)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect
        "references/troubleshooting.md"
        "cursor-landing/cursor-landing/references/troubleshooting.md"
        "references/annexes/INDEX.md"
        "references/annexes/kiro.md"
        "references/annexes/augment-intent.md"
        "references/annexes/amp.md")
      (done
        "troubleshooting.md covers nested-folder mistake, factory vs global install, project skills paths, Kiro/Intent/Amp scan-only hosts with verify-locally notes")
      (required_outcomes (ro-4-troubleshooting-new-hosts)))

    (slice
      (number 5)
      (name validate-package-script)
      (slice_type standard)
      (status passed_closing)
      (depends 1)
      (inspect
        "scripts/validate-package.py"
        "cursor-landing/cursor-landing/BUNDLE-MANIFEST.md"
        "tests/fixtures/README.md")
      (done
        "scripts/validate-package.py validates cursor-landing/cursor-landing/ only; exit 0 on clean tree; required files, SKILL frontmatter, forbidden leaks checked")
      (required_outcomes (ro-5-validate-package-py)))

    (slice
      (number 6)
      (name p4-proof-and-closeout-prep)
      (slice_type standard)
      (status passed_closing)
      (depends 1 2 3 4 5)
      (inspect
        "Planner/slice-runs/cursor-landing-p4/PROOF-LOG.md"
        "Planner/slice-runs/cursor-landing-p4/PHASE-BACKLOG.md"
        "tests/fixtures/README.md")
      (done
        "PROOF-LOG complete for slices 1–5; P4 outcomes 1–6 trace table; build/validate/schema commands noted; PHASE-BACKLOG out-of-map deferrals; fixtures README P4 subsection")
      (required_outcomes (ro-6-maintainer-proof-note)))

  (next_action
    (mode complete)
    (active_slice none)
    (active_slice_file none)
    (all_slices_passed true)
    (closeout final_closeout_passed 2026-05-24)
    (slice_list_created 2026-05-24)
    (slice_list_approved 2026-05-24)
    (slice_1_passed_closing 2026-05-24)
    (slice_2_passed_closing 2026-05-24)
    (slice_3_passed_closing 2026-05-24)
    (slice_4_passed_closing 2026-05-24)
    (slice_5_passed_closing 2026-05-24)
    (slice_6_passed_closing 2026-05-24)))
```

| # | Slice | Closes |
|---|--------|--------|
| 1 | publishable-tree-scaffold | ro-1 — `cursor-landing/cursor-landing/`; repoint build/sync off `install-bundle/` |
| 2 | install-readme-publish-align | ro-2 — factory + publishable install docs |
| 3 | github-install-smoke | ro-3 — recorded GitHub → install smoke |
| 4 | troubleshooting-hosts-coverage | ro-4 — troubleshooting + P1 hosts |
| 5 | validate-package-script | ro-5 — `validate-package.py` on publishable root |
| 6 | p4-proof-and-closeout-prep | ro-6 → **project_complete** |

## Slice 1 scope (decided)

**Publishable story:** `cursor-landing/cursor-landing/` only. Slice 1 repoints `scripts/build-install-bundle.ps1` and `scripts/sync-global-skill-install.ps1` to that path and moves `BUNDLE-MANIFEST.md` under the publishable root. Repo-root `install-bundle/` is legacy output — remove from build or document as deprecated after migration.
