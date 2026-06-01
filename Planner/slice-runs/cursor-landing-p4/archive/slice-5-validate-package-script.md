# NEXT-SLICE — slice 5 (archived 2026-05-24, passed_closing)

```lisp
(extraction_next_slice
  (run_dir "Planner/slice-runs/cursor-landing-p4")
  (slice
    (number 5)
    (name validate-package-script)
    (slice_type standard))
  (slice_type standard)

  (goal
    (name validate-package-script)
    (finish_line "Add scripts/validate-package.py that validates cursor-landing/cursor-landing/ only (default path, overridable); exit 0 on a clean post-build tree; checks required files per BUNDLE-MANIFEST, SKILL YAML frontmatter, forbidden factory leaks, and jsonschema on publishable example + schema; document command in BUNDLE-MANIFEST (via build patch) and tests/fixtures/README.md.")
    (distance_closed "Closes P4 ro-5-validate-package-py after slices 1–4 passed_closing.")
    (required_outcomes (ro-5-validate-package-py))
    (optional_deferred_outcomes ()))

  (review
    (date 2026-05-24)
    (outcome passed_closing)
    (proof
      "scripts/validate-package.py; build 38 files; validate-package exit 0 default + --root; factory --root . exit 1; .cursor leak exit 1; BUNDLE-MANIFEST + fixtures README document command; scope limited to script + build heredoc + fixtures README")))
```

| Field | Value |
|-------|--------|
| Slice | 5 — `validate-package-script` |
| Closes | `ro-5-validate-package-py` |

## Implementation handback (2026-05-24)

**Created:** `scripts/validate-package.py` — required files, annexes, assets, forbidden path walk, SKILL frontmatter, jsonschema; `--root` override; rejects factory root when `Planner/` present.

**Edited:** `scripts/build-install-bundle.ps1` — BUNDLE-MANIFEST Verify section lists `python scripts/validate-package.py`.

**Edited:** `tests/fixtures/README.md` — § P4 validate-package with commands.

## Review record (2026-05-24)

**Outcome:** `passed_closing` — closes P4 `ro-5-validate-package-py`.

**Proof:** Re-ran `build-install-bundle.ps1` → 38 files; `python scripts/validate-package.py` exit 0 (default and `--root cursor-landing/cursor-landing`); `--root .` exit 1 (factory guard); temp copy with `.cursor/` segment exit 1; publishable `BUNDLE-MANIFEST.md` and `tests/fixtures/README.md` document validator; no forbidden slice edits (factory SKILL/install/troubleshooting untouched).

**Reviewer note:** Frontmatter parser treats multiline `description: >-` as non-empty via first line only — acceptable for v1; publishable tree still untracked. Next: plan slice 6 `p4-proof-and-closeout-prep`.
