# Handoff - Grokmvp Cursor Rules Scaffolding (2026-05-29 session)

## Session Goal
Initialize a clean, consistent set of generic Cursor `.mdc` agent rules for this new prototype workspace (c:\Project\Grokmvp). Extracted/adapted from cursor-landing reference files into a house pseudo-Lisp `(def-sop ...)` style, with clear human vs. internal separation, appropriate determinism, user's repo shape preferences, and work habits enforced.

## Current State (end of session)
- **Only remote**: https://github.com/rphoward/Grokmvp (main branch, history force-pushed). No other remotes in this workspace. cursor-landing reference files are deliberately untracked or moved to docs/references/ when finished.
- **Active clean rules** (all directly in `.cursor/rules/`, consistent pseudo-Lisp form, proper Cursor frontmatter):
  - `conduct.mdc` (alwaysApply: true) — response style, work habits (checklists, TodoWrite for complex, mandatory tests+explicit report after non-trivial, surgical changes), doc tone, rule-set consistency enforcement.
  - `safety.mdc` (always) — hard limits + Protocol 0: halt + ask on any unverified safety-relevant assumption.
  - `thermonuclear.mdc` (always) — exact original pseudo-Lisp body preserved; full determinism for code changes.
  - `repo-layout.mdc` (always) — main deliverable in dedicated subfolder; root tolerant of manual docs/junk you drop by hand; supporting material in `docs/references/`, `docs/assets/`, etc.; explicit halt/permission before agent-generated material in root.
  - `mdc-authoring.mdc` (globs: `.cursor/rules/**`) — how to write Cursor-compatible .mdc files (frontmatter contracts, focused splitting, set-wide form consistency).
  - `doc-style.mdc` (globs: `README.md, docs/**, *.md`) — plain language + O'Reilly-style clarity for all human-facing docs; low reading load, no hype/slang/dense prose.
  - `internal-doc-style.mdc` (globs targeting `docs/references/**`, `docs/assets/**`, `docs/internal/**`, etc.) — Lisp-shaped architectural prompts/schemas/templates for internal use only (see below).
- **Reference material**:
  - 5 finished `cursor-landing-*.mdc` now in `docs/references/` (conduct, safety, mdc-authoring, repo-layout, doc-style).
  - Remaining 3 still in `.cursor/rules/` (dual-publish, references, skill-workflow — several open in your IDE at end of session).
- **Supporting folders**: `.cursor/rules/assets/` (empty, available per your preference); `docs/references/` (finished refs + future internal Lisp artifacts).
- **No tests/**, pytest.ini, pyproject.toml, package.json, Makefile, README.md, or AGENTS.md yet. Per `conduct.mdc`: after any non-trivial change, run whatever test command exists (currently none) and report explicitly before claiming done.
- **Git**: main branch only.

## Key Decisions & Rationale
- Consistent house style across clean rules: pseudo-Lisp `(def-sop ...)` with central invariant, numbered protocols, `enforce/assert/halt/when`, explicit separation of concerns. Enforced by `mdc-authoring.mdc` (Protocol 5) and `conduct.mdc` (Protocol 4).
- Determinism for internals: architectural Lisp shape (S-expressions, symbols, decision trees, labels/hooks/triggers doing the prompting work, flat structures preferred, ~5 nesting limit, XML tags for central ideas, lightweight/JSON-schema-like schemas). Selective thermonuclear practices (data-structures/shape first, halt on ambiguity before proceeding, structural subtraction, explicit boundaries, anti-ad-hoc, spotlighting) without full code-mutation rigor. These are prompts/schemas/templates that "bear repeating," not executable programs.
- Strict separation:
  - Human-facing docs → `doc-style.mdc` (plain language, O'Reilly clarity, easy reading).
  - Internal machine-facing → `internal-doc-style.mdc` (Lisp-shaped, never leaks to humans).
  - Code changes → `thermonuclear.mdc`.
- Repo shape (enforced by `repo-layout.mdc`): dedicated subfolder for main deliverable; root OK for your manual docs/junk; supporting in `docs/...` subfolders. Never pollute root with generated/ship output without explicit user permission.
- Remotes & tracking: this workspace is Grokmvp-only. cursor-landing refs are pure reference/inspiration and stay untracked or moved to `docs/references/` when finished.
- Work habits (baked into `conduct.mdc`): surgical minimum changes, numbered checklists for >2-3 steps (updated live), `TodoWrite` for complex/non-trivial, match existing tone, plain direct language, full attendance (not yolo), halt on ambiguity especially for safety.

## Open / Next Steps (suggested)
- Filter remaining open references (you had `cursor-landing-skill-workflow.mdc`, `cursor-landing-dual-publish.mdc`, and `cursor-landing-references.mdc` open in IDE at end of session). Use `internal-doc-style.mdc` + `mdc-authoring.mdc` + `conduct.mdc` + `repo-layout.mdc` for consistency. Extract only generic/non-project-specific content. Move finished ones to `docs/references/`.
- Frontmatter tuning pass (as discussed): refine globs/conditions across the set so scoped rules (doc-style, internal-doc-style, mdc-authoring) activate precisely and don't overlap/conflict on the same files. Update conditions for "writing internal flat files" etc.
- When writing more internal artifacts (schemas, decision structures, etc.): follow `internal-doc-style.mdc` exactly. These are internal-only.
- Structure work: continue organizing per `repo-layout.mdc` and the folders you are creating (docs/references, docs/assets, etc.).
- Eventually: add tests/ per your standing rules in `conduct.mdc`.
- Future: actual project development using the now-active rule set.

## How to Work Effectively With This Set
- **Cross-check everything**: new/edited rules or internal docs against the 7 clean ones for duplication, drift, mismatched assumptions, or activation conflicts.
- **Internal Lisp-shaped docs**: `internal-doc-style.mdc` is now the authority (relaxed architectural Lisp + selected determinism practices; labels/hooks/triggers/XML do the work; flat preferred; never human-facing).
- **Human docs**: `doc-style.mdc`.
- **Repo discipline**: `repo-layout.mdc` is non-negotiable here.
- **Remotes**: only push/pull to Grokmvp. Keep cursor-landing refs untracked or in docs/references/.
- **Testing**: mandatory explicit run + report after non-trivial work (even if "no tests present yet").
- **User context**: full attendance, surgical, checklists/TodoWrite, plain direct language, halt on real ambiguity/risk.

## Suggested Skills / Approach for Next Session
- The 7 clean `.mdc` rules themselves (especially `internal-doc-style.mdc`, `mdc-authoring.mdc`, `conduct.mdc`, `repo-layout.mdc`) are the primary guidance.
- `handoff` skill (if handing off again).
- If batch-filtering more references or planning structure: consider `brainstorming` or `writing-plans` from superpowers if the task grows complex.
- Always read the relevant clean rule(s) + the specific reference file being filtered before editing.

## Artifacts to Reference (do not duplicate content here)
- The 7 clean `.mdc` files in `.cursor/rules/` (primary source of truth).
- Moved references in `docs/references/`: cursor-landing-conduct.mdc, cursor-landing-safety.mdc, cursor-landing-mdc-authoring.mdc, cursor-landing-repo-layout.mdc, cursor-landing-doc-style.mdc (plus this handoff).
- Recent commits (see `git log`): 8a3f7d4 (internal-doc-style), b2d3ba3 (doc-style), 3dfd613 (repo-layout wording fix), fc241c4 (thermonuclear promote + .mdc), 6d43d6e (repo-layout add), etc.
- GitHub: https://github.com/rphoward/Grokmvp
- This handoff document (in docs/references/).
- Folder state at end of session: `.cursor/rules/` (active rules + 3 remaining refs + empty assets/), `docs/references/` (finished refs + this handoff + future internal Lisp artifacts).

Session ended after adding `internal-doc-style.mdc`, moving the finished `cursor-landing-doc-style.mdc` to docs/references/ (now 5 total finished references in docs/references/, only 3 cursor-landing refs remaining in .cursor/rules/), writing this handoff to references, with `cursor-landing-dual-publish.mdc`, `cursor-landing-references.mdc` (and skill-workflow earlier) still open in your IDE, and you actively organizing the `docs/` subfolders per the new rules.

Fresh agent: start by reading the 7 clean `.mdc` files (especially the three scoped ones and repo-layout + internal-doc-style), then the remaining open reference file(s), then propose the next filtered generic extraction or frontmatter adjustment. Keep everything consistent with the internal Lisp-shaped style for internals and plain/O'Reilly for humans.

Ready for continuation.