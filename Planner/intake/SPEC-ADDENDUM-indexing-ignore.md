# SPEC addendum — P5 indexing & ignore files (Cursor Landing)

**Status:** Grill closeout 2026-05-25. Feeds **P5** on PHASE-MAP. Parent seed: [SPEC-SEED-cursor-landing.md](SPEC-SEED-cursor-landing.md).

## Goal

When `/cursor-landing` runs on a brownfield repo, the **Lisp ship product** (`github-publish-lisp/cursor-landing-skill/`) sets up Cursor so codebase search and chat waste less effort on build output, installed packages, and similar clutter. The repo gets a root **`.cursorindexingignore`** (canonical baseline). Users get a **short plain-language summary in chat** at the end of init—not a new repo doc unless they ask.

Success order: **search quality first**, then **smaller Agent context**, then **reduce accidental exposure of secrets** (ignore files are not a vault—see Cursor docs).

## Non-goals (P5)

- Do **not** edit factory root `SKILL.md`, `references/scan-report.schema.json`, `github-publish/`, or `cursor-landing/cursor-landing/` in P5.
- Do **not** copy factory markdown over `github-publish-lisp/cursor-landing-skill/SKILL.md` (pseudo-Lisp spine stays Lisp). Port **semantics** only. See [.cursor/plans/dual-publish-architecture.md](../../.cursor/plans/dual-publish-architecture.md).
- Do **not** list baseline ignore globs inside the Phase 0 `(scan_report …)` chat blob.
- Do **not** auto-edit target `.gitignore`.
- **No SDK resync:** programmatic clear/reindex of IDE codebase sync is **not** exposed on `@cursor/sdk` or Cloud Agents REST (see [Post-init index refresh](#post-init-index-refresh-best-effort) below).

## Ship target (only paths to change in P5)

```text
github-publish-lisp/cursor-landing-skill/**
github-publish-lisp/check-parens.py          ; if script changes needed
github-publish-lisp/validate-lisp-bundle.py  ; if manifest/checks need new asset
```

**Verify before P5 closeout:**

```powershell
python github-publish-lisp/check-parens.py
python github-publish-lisp/validate-lisp-bundle.py
```

Both exit `0`.

**P5 layer note for slices:** For this phase only, treat **application** as `github-publish-lisp/cursor-landing-skill/SKILL.md`, not factory root `SKILL.md`.

## Behavior (definitive)

### Always (every normal Phase 2 init)

1. Write **`.cursorindexingignore`** at **target repo root** from new asset **`assets/cursorindexingignore.baseline.template`** (commented baseline; **append-only** if file already exists).
2. **Best-effort index nudge (same session):** After the write (and any append from `trim_candidates`), **`read` target-root `.cursorindexingignore` once** — see [Post-init index refresh](#post-init-index-refresh-best-effort). Do **not** repo-wide `glob` / `grep` to “resync.”
3. **Phase 3 closeout (chat only):** Plain English—what was set up; whether they still use another AI tool on the repo; **open a new Cursor chat** when a **`.cursorignore`** was written for dual-host setup **or** when they care about fresh `@` / codebase search after indexing-ignore changes; proof command unchanged; one line that ignore files help Cursor’s editor features but are **not** full security (tools/terminal may still read files). **No skill jargon** in closeout.

### Phase 0 scan (Lisp product)

- Do **not** echo the baseline pattern list in `(scan_report …)`.
- At most **8** repo-specific paths via existing **`trim_candidates`**:
  - `type_id`: `indexing_noise`
  - `suggested_action`: `append_indexing_ignore`
- Phase 2 appends those paths to `.cursorindexingignore`.

### `.cursorignore` (short policy file)

| Grill choice | Action |
|--------------|--------|
| **Keep another tool** on this repo (see Q14 below) | Merge **`assets/cursorignore.dual-host.template`** append-only: `AGENTS.md`, `GEMINI.md`, `**/GEMINI.md`, `.agent/`; optional `CLAUDE.md` if sub-ask yes. |
| **Cursor as main tool** | **Skip** dual-host `.cursorignore` block. Still write `.cursorindexingignore`. Add `.cursorignore` lines only for scan/grill “never show Agent” paths (e.g. tracked secrets). |

### Rules (`.mdc`) and teaching UX

- **Below the surface:** canonical work in ignore files; minimal chat weight.
- **Do not** add ignore teaching paragraphs to `conduct.mdc` or `project-proof.mdc` (root file presence is enough breadcrumb).
- **troubleshooting.md:** one line on ignore vs security + link [Cursor ignore file](https://cursor.com/docs/reference/ignore-file).

### Grill Q14 (replace current wording in Lisp `question-bank.md`)

Ask when scan shows `GEMINI.md` or `.agent/` plus `AGENTS.md`:

> Will you keep using **another AI tool or IDE** on this repo (same `AGENTS.md` / `GEMINI.md` files), or is **Cursor** your main place to work?
>
> - **Keep both:** We leave those files for the other tool. Cursor gets its own rules under `.cursor/rules/`. We add a small **`.cursorignore`** so Cursor does not treat those root files as its instructions. After setup, **open a new Cursor chat** once.
> - **Cursor only:** We set up Cursor rules and glossary; we do **not** add that `.cursorignore` block unless you still need certain files hidden from Cursor.

Sub-ask only when **keep both:** also list `CLAUDE.md` in `.cursorignore`? (yes / no)

## Post-init index refresh (best effort)

**Background:** Early P5 notes called for “post-init index resync” after writing ignore files. That assumed a Cursor SDK or script API to clear and rebuild IDE **codebase sync** (semantic index for `@` search). **`@cursor/sdk` and Cloud Agents REST have no such endpoint** — agents can run tools and prompts only; indexing stays inside the IDE client.

**What we do instead (ship product, maintainer-facing):**

| Step | Action | Why |
|------|--------|-----|
| 1 | After Phase 2 finishes `.cursorindexingignore`, **`read` that file once** | Confirms the write; lowest-noise filesystem touch; may correlate with indexer noticing the change (undocumented, version-dependent). |
| 2 | **Do not** require `glob **/*`, repo-wide `grep`, or similar “resync rituals” | High noise, token cost, hook friction; not a supported reindex API. |
| 3 | **Phase 3 closeout:** one plain line that search refresh is **background**; for best `@` results after ignore changes, **start a new chat** | Reliable UX; matches dual-host `.cursorignore` guidance. |

**Optional validation (same session only):** If scan appended a specific path (e.g. a build output dir), a **single** `read` on one small file under that path is acceptable to sanity-check inclusion — not a tree scan.

**Lisp `SKILL.md` port:** Add the post-write `read` to Phase 2 order (after ignore merge, before Phase 3). Keep closeout wording user-facing; do not mention SDK, Merkle trees, or tool names in Phase 3 chat.

**Not guaranteed:** Same-chat `@` codebase search may stay stale until the IDE finishes background sync. Treat the `read` nudge as **best effort**, not a substitute for a real resync API.

## Suggested P5 slices (planner)

| Order | Slice | Outcome |
|-------|-------|---------|
| 1 | Baseline template + Phase 2 merge | `cursorindexingignore.baseline.template`; Lisp `SKILL.md` Phase 2 order |
| 2 | Scan + trim_candidates | `scan-checklist.md`, example `scan-report`, schema pseudo-Lisp if needed; cap 8 |
| 3 | Q14 + question-bank | Lisp grill text; MERGE/troubleshooting touches |
| 4 | Phase 3 closeout gate | Plain-language template in SKILL or MERGE closeout; post-write `read` in Phase 2 per [Post-init index refresh](#post-init-index-refresh-best-effort) |
| 5 | P5 proof | `check-parens.py` + `validate-lisp-bundle.py`; update `BUNDLE-MANIFEST.md` if new asset |

Every slice: **`allowed_edits`** only under ship target paths above.

## Planner session prompt (copy when ready)

```text
P5 is approved. Create or update the phase map from SPEC-SEED-cursor-landing.md plus Planner/intake/SPEC-ADDENDUM-indexing-ignore.md. Open a new run Planner/slice-runs/cursor-landing-p5/. Every slice: only github-publish-lisp/cursor-landing-skill/** (and lisp verify scripts if needed). Do not edit factory markdown SKILL.md or the markdown publish tree.
```

## Traceability

| Grill decision | Where it lands |
|----------------|----------------|
| Always `.cursorindexingignore` | Baseline template + Phase 2 |
| 2b canonical baseline in file | `assets/cursorindexingignore.baseline.template` |
| 6b capped scan deltas | `trim_candidates` in scan-checklist + example |
| 7a closeout | Phase 3 chat only |
| Q5 minimal mdc pointers | No new conduct bullets by default |
| Cursor-only vs keep both | Q14 + `.cursorignore` rules above |
| Post-init resync (SDK) unavailable | [Post-init index refresh](#post-init-index-refresh-best-effort); implementer checklist [Addendum to this addendum](#addendum-to-this-addendum-index-refresh-only) |
| Index-refresh addendum (2026-05-26) | Slice 1 Phase 2 `read`; slice 4 closeout new-chat / background line |

## Addendum to this addendum (index refresh only)

**Supersedes:** P5 drafts that required **post-init index resync** via Cursor SDK or an external script. That API does not exist; this block is the authoritative substitute.

| Old requirement | Replacement |
|-----------------|---------------|
| Programmatic clear/rebuild of IDE codebase sync | **Unavailable** on `@cursor/sdk` and Cloud Agents REST |
| Same-session action after ignore writes | Phase 2: **`read` target-root `.cursorindexingignore` once** after write and `trim_candidates` append |
| Reliable `@` / codebase search after ignore changes | Phase 3 closeout: refresh is **background**; **start a new chat** when search quality matters |
| Prove a path flipped inclusion | Optional: **one** targeted `read` under a scan-appended path — not a tree scan |

**Forbidden:** Repo-wide `glob`, `grep`, or other “resync the codebase” rituals.

**Slice ownership:** Slice 1 — Lisp Phase 2 order includes the post-write `read`. Slice 4 — closeout bullets include new-chat guidance for indexing-ignore changes. Full rationale: [Post-init index refresh (best effort)](#post-init-index-refresh-best-effort).
