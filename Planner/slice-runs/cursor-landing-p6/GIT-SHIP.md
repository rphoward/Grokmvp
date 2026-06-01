# Git ship — P6 (same rules as P5)

**Push root:** `github-publish-lisp/cursor-landing-skill/` → [cursor-landing-v3](https://github.com/rphoward/cursor-landing-v3)

**Do not** push factory monorepo for Lisp product changes unless user asks separately.

## Verify (factory checkout)

```powershell
cd C:\Project\cursor-landing
python github-publish-lisp/check-parens.py
python github-publish-lisp/validate-lisp-bundle.py
```

## Push (skill repo only)

```powershell
cd C:\Project\cursor-landing\github-publish-lisp\cursor-landing-skill
git status
git add -A
git commit -m "P6: idempotent Phase 2 ignore managed blocks"
git push origin main
```

Adjust commit message to match actual slice scope when pushing.

**Before manual double-init:** copy ship tree to a test skills folder per [REVIEW-BEFORE-PUSH.md](../../github-publish-lisp/REVIEW-BEFORE-PUSH.md) — do not proof against stale `~/.cursor/skills/cursor-landing/`.

## Push record

| Field | Value |
|-------|--------|
| Remote | `origin https://github.com/rphoward/cursor-landing-v3.git` (fetch/push) |
| Branch | `main` |
| **HEAD (closeout)** | `2f76641ffb43b7cdaba9fe906cec34e63b1b5550` — refactor: dedupe managed-block policy; marker CI; doc alignment (thermo post slice 3 review) |
| Prior P6 ship | `9732b30b488dd3a813dd5e5ae857c897b1c1adaf` — P6: idempotent Phase 2 ignore managed blocks |
| Pushed | 2026-05-26 (origin `main` up to date at closeout; working tree clean) |
| Notes | P6 slices 1–3 + thermo: SKILL.md, ignore templates, MERGE-TO-RULES, troubleshooting, question-bank Q14, MDC-RULES-FORMAT |

## Factory monorepo (validator CI only)

| Field | Value |
|-------|--------|
| Repo | `C:\Project\cursor-landing` |
| Commit | `0dbf3d5` — slice 3 review and thermo nuke fixes (`lisp_bundle_checks.py`, `validate-lisp-bundle.py` marker checks) |
| Closeout | 2026-05-26 — clean working tree; on `origin/main`; no additional push required |
