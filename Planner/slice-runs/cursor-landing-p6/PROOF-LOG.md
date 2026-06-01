# PROOF-LOG — cursor-landing-p6

| slice | name | slice_type | status | proof | reviewer_note |
|-------|------|------------|--------|-------|---------------|
| 1 | ignore-marked-blocks-idempotency | standard | passed_closing | `check-parens.py` exit 0; SKILL `replace_managed_block` + markers; templates BEGIN/END; no `append_template_lines_only`; step_2 cap 8 + `skip_if` unchanged; v3 diff: SKILL + 2 templates only | ro-1 closed; MERGE/troubleshooting → slice 2 |
| 2 | merge-troubleshooting-reinit-note | standard | passed_closing | `check-parens.py` exit 0; MERGE Q14/Phase 2/Phase 3 bullet 7 + verify re-init rows; troubleshooting re-run line; SKILL `re_run_safe_when` only; conduct/safety templates unchanged for ignore teaching | ro-2 closed; question-bank + MDC-RULES-FORMAT still say append-only for baseline/dual-host — follow-up optional; v3 repo commit per GIT-SHIP |
| 3 | proof-double-init-v3-push | standard | passed_closing | validate-lisp-bundle + check-parens exit 0 (review re-run); PROOF-LOG § P6 Run 1/2 idempotency; v3-test skill; GIT-SHIP `9732b30`; optional Q14/MDC in push | ro-3 closed; optional Kbupgrade live ×2 spot-check; → final_closeout |

## P6 closeout proof (slice 3)

Recorded **2026-05-26** (implement). Slice 3 **passed_closing** at review 2026-05-26.

### Skill source (guardrail)

Copied factory ship tree to test skills folder (not stale global `cursor-landing`):

```text
%USERPROFILE%\.cursor\skills\cursor-landing-v3-test\
```

Source: `C:\Project\cursor-landing\github-publish-lisp\cursor-landing-skill\` per [REVIEW-BEFORE-PUSH.md](../../../github-publish-lisp/REVIEW-BEFORE-PUSH.md) § Install test.

### Manual double-init scenario

| Field | Value |
|-------|--------|
| **Scenario** | Q14 `keep_both`; full Phase 2 ignore path (indexing + dual-host `.cursorignore`) twice on same repo |
| **Proof target** | Disposable temp repo (managed-block simulation aligned with P6 `SKILL.md` step_1 / `phase_2_route` cursorignore) |
| **Kbupgrade dogfood** | `C:\Projects\Kbupgrade - Copy (4)` available per [dogfood-notes.md](../../../tests/fixtures/dogfood-notes.md); no `.cursorindexingignore` / `.cursorignore` at implement time — full `/cursor-landing` ×2 left for human spot-check with v3-test skill if desired |

**Run 1**

- `.cursorindexingignore`: `created` from baseline template (markers + body)
- `.cursorignore`: `created` from dual-host template
- Inside baseline block: `node_modules/` count **1**
- Inside dual-host block: `AGENTS.md` line count **1**
- Trim simulation: appended `tmp/p6-noise-a/`, `tmp/p6-noise-b/` outside managed block semantics (append-only paths)

**Run 2**

- `.cursorindexingignore`: `replaced_managed_block` (markers present; no second baseline block)
- `.cursorignore`: `replaced_managed_block`
- Inside baseline block: `node_modules/` count still **1** (no duplicate baseline globs)
- Inside dual-host block: `AGENTS.md` line count still **1**
- File SHA256 prefixes unchanged after Run 2 (`indexing` `4bcf59c8160a`, `cursorignore` `22095a0f7fab`) — replace-in-place, not append duplicate template body

**Temp proof path (implement session):** `C:\Users\rphow.LITTLESPARK\AppData\Local\Temp\cursor-landing-p6-proof-7jsgq4b1` (ephemeral; removed on reboot)

**Optional reference alignment (same implement):** `question-bank.md` Q14 keep_both + `MDC-RULES-FORMAT.md` Phase 2 preamble — managed-block wording (was append-only).

### Validators

```powershell
cd C:\Project\cursor-landing
python github-publish-lisp/check-parens.py
python github-publish-lisp/validate-lisp-bundle.py
```

| Command | Exit | Date |
|---------|------|------|
| check-parens.py | 0 | 2026-05-26 |
| validate-lisp-bundle.py | 0 | 2026-05-26 |

### Git ship

See [GIT-SHIP.md](GIT-SHIP.md): slice 3 implement `9732b30`; post-review thermo `2f76641` on `origin/main` → cursor-landing-v3 (2026-05-26). Factory validator CI `0dbf3d5` on `origin/main`.

### Closeout re-run (final_closeout 2026-05-26)

| Command | Exit |
|---------|------|
| check-parens.py | 0 |
| validate-lisp-bundle.py | 0 |
| factory jsonschema (AGENTS.md) | 0 |

No fresh commits at closeout — both repos clean and synced with origin.
