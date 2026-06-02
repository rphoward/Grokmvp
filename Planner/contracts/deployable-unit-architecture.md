# Deployable-Unit Architecture

Status: **stub** (not selectable; research and router wiring TBD)

Organizing axis: **deployable** (services, modules, serverless units)

## Purpose

Use this document when the primary design tension is **what ships and scales
independently** (service, function, container, plugin), not folder layers inside
one process. Examples are labeled `Example`.

This stub gives shape for continued grilling and planning. It is not a rule set
until promoted from stub.

## Definition

Deployable-unit architecture organizes work around **units** with explicit
APIs, versioning, and failure isolation. A monorepo may hold many units; each
unit has one deployment artifact and one public contract surface.

TBD:

- Unit granularity (microservice vs modular monolith module).
- Shared libraries vs duplicated boundaries.
- Contract testing between units.

## Core Rule

```text
Planning a slice does not grant permission to bypass architecture.
```

If a slice changes public API, deployment boundary, or cross-unit dependency
direction, the planner must create an architecture decision slice before
implementation. See `codex-router-planner-unified.md`.

**Router note:** Until wired, use `touched_units` and `conceptual_ownership`;
physical paths via `project_layer_mapping`.

## Shape

```text
  +-------------+     contract      +-------------+
  |  unit A     | <--------------> |  unit B     |
  |  (deploy)   |                   |  (deploy)   |
  +-------------+                   +-------------+
        |                                   |
        v                                   v
   [ runtime / platform TBD ]         [ data store TBD ]
```

## Required Vocabulary

Deployable unit:
Artifact that builds, deploys, and scales on its own TBD.

Public contract:
API, event schema, or CLI surface other units may depend on TBD.

Internal module:
Code inside a unit that is not a public contract TBD.

Platform:
Orchestrator or host (K8s, Lambda, PaaS) TBD.

## Service Boundary Rules

TBD:

- Units communicate only through declared contracts.
- No shared mutable database across units without documented pattern TBD.
- Versioning and breaking-change policy TBD.
- Modular monolith: units as modules with compile-time boundaries TBD.

## Ownership Model

| Conceptual owner | Owns (TBD detail) | Must not own |
|------------------|-------------------|--------------|
| Unit | Its contract, internal modules, deploy config | Another unit's internals |
| Shared library | Types/utilities without policy | Feature workflows |
| Platform adapter | Infra binding for a unit | Business rules |

## Deployment Coupling

This family **is** deployment architecture. Unit boundaries should match how the
team ships and rolls back.

TBD: containers, functions, static+API pairs.

## Folder Schema

TBD: `services/<name>/`, `packages/<name>/`, or monorepo package roots.

Do not create empty unit folders.

## Architecture Records

### Project Architecture Record

```lisp
(architecture
  (name "<project architecture name>")
  (family deployable_unit)
  (status stub)
  (primary_units
    (deployable_unit
      (name "<unit name>")
      (contract_surface TBD "<http | events | cli>")
      (version_policy TBD)
      (proof TBD)))
  (architecture_tests TBD))
```

### Deployable Unit Record

```lisp
(deployable_unit
  (name "<unit_name>")
  (status planned | active | implemented | retired)
  (intent TBD "<capability this unit exposes>")
  (public_contract TBD)
  (forbidden_dependencies TBD "<other units or dirs>")
  (internal_modules TBD)
  (proof TBD))
```

### Phase, Slice, and Architecture Decision Records

Use `(phase …)`, `(slice …)`, and `(architecture_decision_slice …)` from
`codex-extraction-packet-schema-sexpr.md`. Stub vocabulary: `touched_units`,
`conceptual_ownership`.

```lisp
(slice
  (name "<slice name>")
  (phase "<phase name>")
  (status planned | active | review_needed | passed | failed | deferred)
  (intent TBD)
  (touched_units TBD)
  (conceptual_ownership TBD)
  (allowed_edits TBD)
  (forbidden_edits TBD)
  (architecture_guardrails TBD)
  (proof TBD)
  (review_question TBD))
```

## Planner Contract

1. Identify the capability and target unit TBD.
2. State contract changes (if any) TBD.
3. List cross-unit calls allowed or forbidden TBD.
4. Name deployment and rollback proof TBD.
5. Guardrails for shared state TBD.
6. Define proof before implementation TBD.
7. Mark out-of-scope (UI-only refactors in wrong unit) TBD.

## Naming Rules

TBD. Unit and contract names should reveal capability, not only technology.

## Architecture Test Rules

TBD:

- Contract tests at unit boundaries.
- No imports from sibling unit internals TBD.
- Deploy smoke per unit TBD.

## Anti-Patterns

TBD:

- Distributed monolith (chatty units, shared DB, no contracts).
- Breaking API without ADS.
- One repo folder per layer instead of per unit when units are the axis.

## Migration Path From A Messy App

1. Inventory what actually deploys TBD.
2. Draw current dependencies TBD.
3. Extract one contract; prove consumers TBD.

## Research Backlog

- Modular monolith vs microservices selection in seed.
- How domain-spoke layers map inside a single unit.
- Factory reference product as one unit vs many TBD.
- Router `architecture_contract` for deployable selection.
