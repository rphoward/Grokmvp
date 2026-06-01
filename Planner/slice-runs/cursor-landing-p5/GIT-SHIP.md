# Git ship — factory repo vs Lisp product repo (P5)

Personal reference: **factory monorepo** and **what users install from GitHub** are not the same Git root. Git “wants” one repo per push; this project has three trees — only one is the public ship product.

## Three trees (do not conflate)

| Tree | Path in factory | Git? | Role |
|------|-----------------|------|------|
| Factory | `cursor-landing/` repo root | Yes (main) | `SKILL.md`, `references/`, `Planner/`, P1–P4 markdown bundle work |
| Markdown publish | `cursor-landing/cursor-landing/`, `github-publish/` | Usually **no** separate push | Built markdown install; P4 lane — **not** P5 edit target |
| **Lisp ship product** | `github-publish-lisp/cursor-landing-skill/` | **Yes — nested `.git`** | Push to **cursor-landing-v3** only |
| **Frozen v2** | [docs/archive/cursor-landing-v2-ship-reference.md](../../../docs/archive/cursor-landing-v2-ship-reference.md) | GitHub only | Not a second folder under `github-publish-lisp/` |

Detail: [.cursor/plans/dual-publish-architecture.md](../../../.cursor/plans/dual-publish-architecture.md).

## Two meanings of “ship”

| Meaning | Where | What you do |
|---------|--------|-------------|
| **P5 edit scope** | `github-publish-lisp/cursor-landing-skill/**` plus parent `check-parens.py`, `validate-lisp-bundle.py`, `lisp_bundle_checks.py` | Change skill + validators in **factory** checkout |
| **Git push scope** | **`github-publish-lisp/cursor-landing-skill/` only** | `cd` there; `git status`; `git push` — **not** the parent `github-publish-lisp/` folder as repo root |

Validators live in the **parent** folder on purpose: they are maintainer tools, not copied into the install bundle ([BUNDLE-MANIFEST.md](../../../github-publish-lisp/cursor-landing-skill/BUNDLE-MANIFEST.md)).

## Verify (factory checkout, before push)

```powershell
cd C:\Project\cursor-landing
python github-publish-lisp/check-parens.py
python github-publish-lisp/validate-lisp-bundle.py
```

Both exit `0`. After P5 slice 1+, ensure `lisp_bundle_checks.REQUIRED_ASSETS` and `BUNDLE-MANIFEST.md` list `assets/cursorindexingignore.baseline.template`.

## Push (skill repo only)

```powershell
cd C:\Project\cursor-landing\github-publish-lisp\cursor-landing-skill
git remote -v
git status
git push origin main
```

Checklist: [github-publish-lisp/REVIEW-BEFORE-PUSH.md](../../../github-publish-lisp/REVIEW-BEFORE-PUSH.md).

- **Dev remote:** [cursor-landing-v3](https://github.com/rphoward/cursor-landing-v3) (per REVIEW-BEFORE-PUSH).
- **Live product:** [cursor-landing-v2](https://github.com/rphoward/cursor-landing-v2) — do not push P5 WIP there until you intend a release.

Install docs in the v3 bundle point at [cursor-landing-v3](https://github.com/rphoward/cursor-landing-v3) for dev; v2 remains the frozen public release until you tag v3.

## What not to ship

- Factory root `Planner/`, `.cursor/`, root `SKILL.md` — stay in factory repo only.
- Parent `github-publish-lisp/*.py` — run from factory; not inside the skill GitHub repo.
- `cursor-landing/cursor-landing/` — separate markdown bundle; not the Lisp GitHub product.

## P5 closeout (slice 5)

Record in PROOF-LOG: validators exit 0; `git remote -v` checked in skill repo; manifest lists new assets; optional note which remote was pushed.
