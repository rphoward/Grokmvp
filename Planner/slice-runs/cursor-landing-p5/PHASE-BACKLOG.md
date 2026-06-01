# PHASE-BACKLOG — cursor-landing-p5

P5 in-scope items from [SPEC-ADDENDUM-indexing-ignore.md](../../intake/SPEC-ADDENDUM-indexing-ignore.md). **Factory vs GitHub ship:** [GIT-SHIP.md](GIT-SHIP.md). Out-of-map deferrals carried from P4 closeout.

## In scope this phase (planned)

| item_id | description | slice | status |
|---------|-------------|-------|--------|
| baseline-cursorindexingignore | template + Phase 2 write step (append-only) | 1 | passed_closing |
| scan-trim-indexing-noise | trim cap 8; SKILL append trim + post-append `read` once | 2 | passed_closing |
| q14-dual-host | question-bank Q14 + `.cursorignore` policy | 3 | passed_closing |
| phase3-plain-closeout | Plain English Phase 3 chat gate | 4 | passed_closing |
| teaching-ux-mdc | no ignore paragraphs in conduct/project-proof templates | 5 | passed_closing |
| troubleshooting-ignore-line | One line + Cursor docs link | 5 | passed_closing |
| lisp-bundle-proof | check-parens + validate-lisp-bundle; BUNDLE-MANIFEST | 5 | passed_closing |

## Out of phase map (unchanged)

| item | note |
|------|------|
| Automated repo scanner | Until dogfood proves need |
| Team MCP merge templates | User-invoked only |
| Deep monorepo scan depth | Deferred |
| Post-init index refresh | **In scope slice 2 + 4** — post-append `read`; closeout new-chat/background — [addendum §](../../intake/SPEC-ADDENDUM-indexing-ignore.md#addendum-to-this-addendum-index-refresh-only) |
| Optional path read | One file under scan-appended path — optional per addendum | — | optional |
| Re-publishing GitHub issues from PRD | Optional |

## P5 non-goals (enforce per slice)

- Factory root `SKILL.md`, `github-publish/`, `cursor-landing/cursor-landing/`
- Blind-copy factory markdown over Lisp `SKILL.md`
- Baseline globs inside Phase 0 `(scan_report …)` chat blob
- Auto-edit target `.gitignore`
- Repo-wide glob/grep resync rituals

## Prior phase proof commands (reference only — not P5 slice proof)

Markdown bundle (P4): `python scripts/validate-package.py` on `cursor-landing/cursor-landing/`.  
Factory schema: `AGENTS.md` jsonschema one-liner.

**P5 closeout proof:**

```powershell
python github-publish-lisp/check-parens.py
python github-publish-lisp/validate-lisp-bundle.py
```
