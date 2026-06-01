# PROOF-LOG — cursor-landing-p4

Record one row per slice after review. Status must be `passed_closing` or `passed_with_debt` (not `passed`).

| slice | name | slice_type | status | proof | reviewer_note |
|-------|------|------------|--------|-------|---------------|
| 1 | publishable-tree-scaffold | standard | passed_closing | build → `cursor-landing/cursor-landing/` (38 files); jsonschema on publishable paths exit 0; no Planner/.cursor in tree; BUNDLE-MANIFEST flat-install docs | Sync still calls `build-install-bundle.ps1` by name; factory `references/install.md` → slice 2; commit publishable tree when ready |
| 2 | install-readme-publish-align | standard | passed_closing | Factory install/README/OVERVIEW + build script bundle patches; publishable trio copy-flat only; rebuild 38 files; jsonschema exit 0 | Deprecated `install-bundle/` note in factory install only; publishable tree untracked; slice 3 smoke narrative |
| 3 | github-install-smoke | standard | passed_closing | Factory install.md § GitHub install smoke; fixtures README P4 record; build script smoke blurb patch; rebuild 38 files exit 0; jsonschema exit 0; Select-String proof pass | Remote default branch may lag P4 layout until push — re-run fixtures row post-push. Build script patch follows slice 2 bundle pattern. |
| 4 | troubleshooting-hosts-coverage | standard | passed_closing | § Install path mistakes + § Other AI tools (scan only); INDEX cross-link; factory/publishable troubleshooting SHA256 match; build 38 files; jsonschema exit 0 | Review fixed build link `../install.md` → `install.md`. Publishable tree untracked. |
| 5 | validate-package-script | standard | passed_closing | `scripts/validate-package.py`; build 38 files; validate exit 0; factory `--root .` exit 1; `.cursor` leak exit 1; BUNDLE-MANIFEST + fixtures README docs | Multiline SKILL description check is line-based; publishable tree untracked. Slice 6 closeout rollup. |
| 6 | p4-proof-and-closeout-prep | standard | passed_closing | Schema exit 0 (review re-run); build 38 files; validate exit 0; § P4 closeout proof outcomes 1–6; link pass OK (7-file scope, 83 links); CONTEXT no `(to add)`; PHASE-BACKLOG out-of-map + phase_lessons; fixtures § P4 maintainer proof; rows 1–5 unchanged; scope PROOF-LOG + PHASE-BACKLOG + fixtures README + STATUS only (2026-05-24 review) | Closes ro-6; all six slices passed; ready for `final_closeout` → `project_complete` |

**Prior phase:** [cursor-landing-p3 PROOF-LOG](../cursor-landing-p3/PROOF-LOG.md) — dogfood on `C:\Projects\Kbupgrade - Copy (4)`; fixtures in [tests/fixtures/](../../../tests/fixtures/).

**Schema command** (factory, from repo root):

```bash
python -c "import json,jsonschema; jsonschema.validate(json.load(open('tests/fixtures/scan-report-example.json')), json.load(open('references/scan-report.schema.json')))"
```

**Validate package** (publishable root only):

```bash
python scripts/validate-package.py
```

Publishable root: `cursor-landing/cursor-landing/` (see [SLICE-LIST.md](SLICE-LIST.md) slice 1).

## P4 closeout proof (maintainer)

Maps [PHASE-MAP.md](../../phase-map/PHASE-MAP.md) P4 `required_outcomes` 1–6 to slices and evidence. Closes **ro-6** (maintainer proof note). Publishable tree remains **untracked** in git unless the user commits it separately.

| Outcome | Slice | Evidence |
|---------|-------|----------|
| 1 Publishable tree scaffold | 1 `publishable-tree-scaffold` | `scripts/build-install-bundle.ps1` + `sync-global-skill-install.ps1` → `cursor-landing/cursor-landing/` (38 files); `BUNDLE-MANIFEST.md`; no `Planner/` or factory `.cursor/` in bundle (slice 1 row) |
| 2 README/OVERVIEW/install accurate | 2 `install-readme-publish-align` | Factory install/README/OVERVIEW + publishable copy-flat; deprecated `install-bundle/` note factory-only (slice 2 row) |
| 3 GitHub install smoke | 3 `github-install-smoke` | [tests/fixtures/README.md](../../../tests/fixtures/README.md) § P4 GitHub install smoke; factory `references/install.md` § GitHub install smoke (slice 3 row) |
| 4 Troubleshooting new hosts | 4 `troubleshooting-hosts-coverage` | § Install path mistakes + § Other AI tools; INDEX cross-link; factory/publishable troubleshooting match (slice 4 row) |
| 5 validate-package.py | 5 `validate-package-script` | `scripts/validate-package.py` exit 0 on publishable root; fixtures § P4 validate-package; factory `--root .` negative checks (slice 5 row) |
| 6 Maintainer proof note | 6 `p4-proof-and-closeout-prep` | This section + [tests/fixtures/README.md](../../../tests/fixtures/README.md) § P4 maintainer proof |

### Re-run commands (P4)

| Check | Command / scope | Result (2026-05-24 implement slice 6) |
|-------|-----------------|----------------------------------------|
| Schema | `python -c "import json,jsonschema; jsonschema.validate(json.load(open('tests/fixtures/scan-report-example.json')), json.load(open('references/scan-report.schema.json')))"` | exit 0 |
| Build | `scripts\build-install-bundle.ps1` | exit 0 → `cursor-landing/cursor-landing/` (**38** files) |
| Validate package | `python scripts/validate-package.py` | exit 0 (`cursor-landing/cursor-landing/`) |
| Link pass | Relative `href` in README, OVERVIEW, CONTEXT, AGENTS.md, `references/install.md`, `references/troubleshooting.md`, `references/annexes/INDEX.md` | **83** links checked, **zero** broken; no README fixes |
| `(to add)` grep | `CONTEXT.md` (read-only) | zero matches |
| PROOF-LOG rows 1–5 | Status column | all `passed_closing` (row text unchanged) |

### Out of phase map

| Item | Notes |
|------|-------|
| Automated repo scanner | Until dogfood proves need — [PHASE-BACKLOG.md](PHASE-BACKLOG.md) |
| Team MCP merge templates | User-invoked only — not merged by default |
| Deep monorepo scan depth | Deferred |
| Re-publishing GitHub issues from PRD | Optional tracker work — not blocking closeout |

After `final_closeout` with empty `deferred_phases` → **project_complete**.
