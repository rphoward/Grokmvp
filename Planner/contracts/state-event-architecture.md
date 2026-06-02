# State / Event Architecture

Status: **stub** (not selectable; research and router wiring TBD)

Organizing axis: **state** (commands, events, snapshots, transitions as truth)

## Purpose

Use this document when the primary design tension is **how state changes over
time** (event log, aggregates, replay, concurrency), not layer stacks or deploy
units alone.

This stub gives shape for continued grilling and planning. It is not a rule set
until promoted from stub.

## Definition

State-event architecture treats **transitions** as the authoritative story:
commands produce events; projections and snapshots serve reads; concurrency rules
are explicit.

TBD:

- Event sourcing vs event-light CRUD.
- Snapshot strategy and replay proofs.
- Games, ledger, and collaborative sync as example domains.

## Core Rule

```text
Planning a slice does not grant permission to bypass architecture.
```

If a slice changes who may emit events, schema versioning, or snapshot truth,
the planner must create an architecture decision slice before implementation.
See `codex-router-planner-unified.md`.

**Router note:** Until wired, use `touched_partitions` and
`conceptual_ownership`; physical paths via `project_layer_mapping`.

## Shape

```text
  [ command ] --> [ aggregate / partition ] --> [ events ]
                           |                      |
                           v                      v
                    [ snapshot? ]          [ projections ]
```

## Required Vocabulary

Command:
Intent to change state; validated before append TBD.

Event:
Immutable fact appended to a log TBD.

Partition:
Boundary for serializing events (aggregate, stream, shard) TBD.

Projection:
Read model derived from events TBD.

Snapshot:
Optional cached state for fast reload TBD.

## Transition and Log Rules

TBD:

- Events are immutable; corrections are new events TBD.
- Schema evolution policy TBD.
- Concurrency: optimistic vs serial per partition TBD.
- Proof via replay and fixture event streams TBD.

## Ownership Model

| Conceptual owner | Owns (TBD detail) | Must not own |
|------------------|-------------------|--------------|
| Partition | Event stream, invariants on apply | Unrelated partition rules |
| Command handler | Validation, emit | Presentation formatting |
| Projection | Read shape | Command authority |
| Snapshot store | Performance cache | Sole source of truth without log |

## Deployment Coupling

TBD: single-node log, distributed log, DB as event store, realtime netcode host.

Storage and delivery drive partition design.

## Folder Schema

TBD: `domain/events/`, `projections/`, `snapshots/` — refine after research.

Do not create empty folders.

## Architecture Records

### Project Architecture Record

```lisp
(architecture
  (name "<project architecture name>")
  (family state_event)
  (status stub)
  (primary_partitions
    (state_partition
      (name "<partition name>")
      (commands TBD)
      (events TBD)
      (invariants TBD)
      (proof TBD)))
  (architecture_tests TBD))
```

### State Partition Record

```lisp
(state_partition
  (name "<partition_name>")
  (status planned | active | implemented | retired)
  (intent TBD)
  (commands TBD)
  (events TBD)
  (snapshot_policy TBD)
  (concurrency TBD)
  (forbidden_writes TBD)
  (proof TBD))
```

### Phase, Slice, and Architecture Decision Records

Use `(phase …)`, `(slice …)`, and `(architecture_decision_slice …)` from
`codex-extraction-packet-schema-sexpr.md`. Stub vocabulary: `touched_partitions`,
`conceptual_ownership`.

```lisp
(slice
  (name "<slice name>")
  (phase "<phase name>")
  (status planned | active | review_needed | passed | failed | deferred)
  (intent TBD)
  (touched_partitions TBD)
  (conceptual_ownership TBD)
  (allowed_edits TBD)
  (forbidden_edits TBD)
  (architecture_guardrails TBD)
  (proof TBD)
  (review_question TBD))
```

## Planner Contract

1. Identify the command or event schema change TBD.
2. Select partition(s) TBD.
3. State invariants and concurrency TBD.
4. Name projection or snapshot impact TBD.
5. Define replay or migration proof TBD.
6. Define proof before implementation TBD.
7. Mark out-of-scope (UI-only changes) TBD.

## Naming Rules

TBD. Commands and events name domain facts, not framework roles.

## Architecture Test Rules

TBD:

- Given-when-then on event sequences.
- Replay matches snapshot TBD.
- Partitions do not share mutable state without contract TBD.

## Anti-Patterns

TBD:

- Mutable history.
- Projections that become write paths for business rules.
- Dual sources of truth (DB row + event log) without ADS.

## Migration Path From A Messy App

1. Find where state actually changes TBD.
2. Introduce one command/event pair TBD.
3. One projection; prove replay TBD.

## Research Backlog

- CQRS vs pragmatic event-light.
- Overlap with deployable-unit (per-partition services).
- Games and realtime sync patterns.
- Router `architecture_contract` for state-event selection.
