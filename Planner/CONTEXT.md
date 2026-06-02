# Planner kit (portable factory)

Shared vocabulary for the portable `Planner/` tree, Cursor rules that attach to
it, and how this factory steers agents without duplicating normative contracts.

## Language

**Planner-routed work**:
Any task driven by the active planner run: bookkeeping in `Planner/` (router
state, STATUS, slices, proofs) and implementation under the repo product home.
_Avoid_: "planner-only work" (implies no product coding).

**Disk state**:
The authoritative record of where a run is; lives in `Planner/router-state.md`,
per-run `STATUS.md`, and related run files—not chat memory.
_Avoid_: "session state", "context window".

**Allowed architecture**:
An architecture whose full definition exists as a contract file under
`Planner/contracts/` and is declared part of the allowed set in planner
contracts.
_Avoid_: "the architecture we like", "best fit architecture".

**Default architecture**:
`domain-spoke-architecture.md`; used when the router and project configuration
do not select another allowed architecture.
_Avoid_: "the only architecture", "universal architecture".

**Architecture contract gate**:
The rule that operating under or deviating from the default architecture is
permitted only when that architecture is an allowed contract in
`Planner/contracts/` and is explicitly selected through
`codex-router-planner-unified.md` and project configuration. No ad-hoc or
in-slice invention.
_Avoid_: "pick an architecture", "switch patterns mid-slice".

**Normative architecture**:
The binding rules and vocabulary inside the selected architecture contract
(e.g. `domain-spoke-architecture.md`), not summaries in `Planner/AGENTS.md`.
_Avoid_: "architecture echo", "AGENTS architecture section".

**Planner/AGENTS.md**:
Portable guardrail file for precedence, read order, write boundaries, and
verification habits on planner-routed work. Force-read by the agent host; not
the normative architecture source.
_Avoid_: duplicating contract prose here.

**planner-artifacts rule** (`.cursor/rules/planner-artifacts.mdc`):
Path-scoped rule for `Planner/**/*.md`: artifact registry, packet schema,
Lisp shape (via `internal-doc-style.mdc`), and explicit exclusion of
thermonuclear product-implementation protocols.
_Avoid_: treating it as the full planner-routed discipline.

**Artifact registry**:
Table in `Planner/contracts/README.md` mapping artifact types (router_state,
run_status, slice lists, etc.) to canonical schema locations. Agent must halt
if the type is not listed.
_Avoid_: inventing keys or parallel status files.

**Product home**:
Top-level folder whose name is the project slug; implementation code lives only
there (per `repo-layout.mdc`). In this repo, `Grokmvp/`.
_Avoid_: "app folder", code at repo root.

**Machine records home**:
`assets/` at repo root for Lisp-shaped internal schemas and machine artifacts,
distinct from planner run ledgers under `Planner/`.
_Avoid_: mixing run STATUS into `assets/`.

**Read order (planner-local)**:
`router-state.md` → active `STATUS.md` → `Planner/AGENTS.md` →
`contracts/README.md` → `context-index.md`. Matches unified router
`active_run_pointer`; not interchangeable with ad-hoc file order.
_Avoid_: reading contracts before resolving the active run.

## Relationships

- **Planner-routed work** uses **disk state** resolved via **read order
  (planner-local)** before planning or implementing.
- **Normative architecture** comes from the **allowed architecture** selected
  for the project; **default architecture** applies when none other is selected.
- **Architecture contract gate** is the only path to use or deviate from
  **default architecture**.
- **planner-artifacts rule** applies when editing files under `Planner/`; product
  coding under **product home** still follows **Planner-routed work** via the
  unified router contract, not via planner-artifacts globs alone.
- **Artifact registry** governs Lisp-shaped edits in **Planner/**; **machine
  records home** is separate from run ledgers.

## Example dialogue

> **Dev:** "Can we use event-sourcing folders for this slice? It fits better."
> **Lead:** "Only if event-sourcing is an **allowed architecture** in
> `Planner/contracts/` and the router selects it. Otherwise we stay on
> **domain-spoke** (**default architecture**) and use an architecture decision
> slice if ownership changes."

> **Dev:** "I'll update STATUS and code `Grokmvp/`—do I need planner-artifacts?"
> **Lead:** "STATUS is **disk state** under **Planner/**—follow the **artifact
> registry** and packet schema. Coding in **product home** is still
> **planner-routed work**; the unified contract already bound you to the active
> slice before you opened `hello.py`."

## Flagged ambiguities

- "Architecture summary in AGENTS.md" — resolved: removed; **normative
  architecture** lives only in contracts; AGENTS states **architecture contract
  gate** and pointers.
- "Read order in AGENTS vs context-index" — resolved: same sequence; AGENTS is
  authoritative for planner-local order; context-index adds phase-map and intake
  steps after contracts.
- "Planner-routed = only Planner/ files" — resolved: includes product home
  implementation when driven by the active slice; **planner-artifacts rule** is
  narrower (Lisp artifacts only).

## Grill closeout (2026-06-02)

Decisions locked during this session:

| Topic | Decision |
|-------|----------|
| Read order | Corrected in `Planner/AGENTS.md`; aligned with unified router |
| Architecture section | Pointer + **architecture contract gate**; multi-arch allowed in contracts; domain-spoke default |
| Architecture echo | Removed from AGENTS; one router cross-ref added to domain-spoke Core Rule |
| Project layer mapping | Scoped to domain-spoke default; other archs via their contracts |
| Write boundaries / out of scope / verification / work style | Kept as-is |
| planner-artifacts.mdc | Stays narrow; does not replace AGENTS or unified contract |
| New intent-scoped planner-routed.mdc | Not needed; normal workflow uses unified contract |

**Follow-up (not done here):** Declare the allowed-architectures list explicitly
in `Planner/contracts/README.md` (or unified `(paths …)` block) when a second
architecture contract is added.
