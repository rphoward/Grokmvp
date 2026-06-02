# Client-Interactive Architecture

Status: **stub** (not selectable; research and router wiring TBD)

Organizing axis: **runtime** (UI, client state, platform APIs)

## Purpose

Use this document when the primary design tension is **how users interact**
(screens, components, render loop, client state), not domain rules or deploy
units. It is project-agnostic. Example paths appear only in sections labeled
`Example`.

This stub gives shape for continued grilling and planning. It is not a rule set
until promoted from stub.

## Definition

Client-interactive architecture organizes work around **surfaces** (routes,
screens, views) and **client runtime** (state, events, platform SDKs).

TBD:

- What counts as a surface vs shared chrome.
- How server and client split ownership for AI-generated full-stack apps.
- Proof expectations per surface (visual, a11y, interaction).

## Core Rule

```text
Planning a slice does not grant permission to bypass architecture.
```

If a slice changes surface ownership, client state boundaries, or platform
assumptions, the planner must create an architecture decision slice before
implementation. Conditions are defined in `codex-router-planner-unified.md`.

**Router note:** `architecture_contract` in the unified router still targets
domain-spoke conceptual layers until this contract is wired for selection.
Slices may use `conceptual_ownership` and `touched_surfaces` here; map physical
paths via `project_layer_mapping`.

## Shape

```text
                    [ platform / host ]
                              |
                    +---------+---------+
                    |   client runtime   |
                    |  state, navigation |
                    +---------+---------+
                              |
              +---------------+---------------+
              |         surfaces             |
              |  screen / route / view TBD   |
              +---------------+---------------+
                              |
                    [ optional BFF / API ]
```

## Required Vocabulary

Surface:
A cohesive user-facing entry (page, screen, route, panel) with explicit ownership.

Client runtime:
Framework or host that owns navigation, lifecycle, and cross-surface state TBD.

Presentation transform (borrowed term):
Maps application output to UI-specific shape; must not own durable business rules.

Platform boundary:
OS, browser, or embedded host APIs the client may call TBD.

## Runtime and Surface Rules

TBD:

- Surfaces must not silently own domain invariants (defer to domain-spoke when
  both apply).
- Shared client state: what may cross surfaces vs stay local.
- AI-generated UI: component boundaries and test hooks TBD.
- Accessibility and loading/error states as proof obligations TBD.

## Ownership Model

| Conceptual owner | Owns (TBD detail) | Must not own |
|------------------|-------------------|--------------|
| Surface | UX flow, view state, layout for one entry | Durable business policy |
| Client runtime | Navigation shell, session UX state | Domain invariants |
| Presentation transform | Formatting, transport-facing view models | Source-of-truth rules |
| Outer API / BFF | Aggregation for client | TBD |

Physical folders resolve through `project_layer_mapping` in
`codex-router-planner-unified.md`. Do not invent paths in slices until mapping
is filled for this architecture.

## Deployment Coupling

TBD: browser SPA, native mobile, desktop shell, game engine host, embedded WebView.

Deployment choice constrains surfaces and proof (build targets, E2E vs unit).

## Folder Schema

TBD. Sketch only after research. Do not create empty architecture folders.

## Architecture Records

Pseudo-Lisp records; promote to strict schema only after fields stabilize.

### Project Architecture Record

```lisp
(architecture
  (name "<project architecture name>")
  (family client_interactive)
  (status stub)
  (client_runtime
    (host TBD "<browser | native | desktop | embedded>")
    (owns TBD "<navigation, session UX>"))
  (primary_surfaces
    (surface
      (name "<surface name>")
      (user_intent TBD "<outcome>")
      (entrypoints TBD "<route | deeplink | scene>")
      (proof TBD "<test or manual proof>")))
  (architecture_tests TBD "<ownership proofs>"))
```

### Surface Record

```lisp
(surface
  (name "<surface_name>")
  (status planned | active | implemented | retired)
  (intent TBD "<user outcome>")
  (owns
    (surface_layer TBD "<view | component tree>")
    (client_state TBD "<local state scope>"))
  (forbidden_ownership TBD "<rules owned elsewhere>")
  (entrypoints TBD "<route | screen id>")
  (proof TBD))
```

### Phase, Slice, and Architecture Decision Records

Use the same `(phase …)`, `(slice …)`, and `(architecture_decision_slice …)`
packet shapes as `codex-extraction-packet-schema-sexpr.md`.

For slices under this family (stub vocabulary):

- `touched_surfaces` instead of `touched_spokes` where applicable.
- `conceptual_ownership` instead of `layer_ownership` until router wiring exists.

```lisp
(slice
  (name "<slice name>")
  (phase "<phase name>")
  (status planned | active | review_needed | passed | failed | deferred)
  (intent TBD)
  (touched_surfaces TBD)
  (conceptual_ownership TBD)
  (allowed_edits TBD)
  (forbidden_edits TBD)
  (architecture_guardrails TBD)
  (proof TBD)
  (review_question TBD))
```

## Planner Contract

Before writing a slice (stub steps; refine after research):

1. Identify the user-facing outcome and target surface.
2. Select an existing surface or propose a new one TBD.
3. State conceptual ownership for each part of the change TBD.
4. Name platform or API boundaries the slice may cross TBD.
5. Name architecture rules this slice must preserve TBD.
6. Define proof before implementation TBD.
7. Mark out-of-scope temptations (domain rules in components, etc.) TBD.

## Naming Rules

TBD. Names should reveal surface intent or user outcome, not only file type.

Naming test (same as domain-spoke):

```text
Can a capable developer or AI agent guess what belongs here without opening
the file?
```

## Architecture Test Rules

TBD, for example:

- Surfaces do not import domain centers directly TBD.
- Client runtime does not own durable business policy TBD.
- Each surface has a focused proof at its boundary TBD.

## Anti-Patterns

TBD, for example:

- Business rules living only in UI components.
- One giant global client store without boundaries.
- Architecture by documentation only.
- Slices without proof.

## Migration Path From A Messy App

1. List user-visible surfaces TBD.
2. Mark where domain meaning lives today TBD.
3. One architecture decision or slice to move one rule TBD.
4. Prove; repeat.

## Research Backlog

- Multi-surface apps vs single-SPA ownership.
- AI-generated UI component boundaries and tests.
- How this family combines with domain-spoke on the same repo.
- Router `architecture_contract` block for client-interactive selection.
