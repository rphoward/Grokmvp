# Dataflow / Stream Architecture

Status: **stub** (not selectable; research and router wiring TBD)

Organizing axis: **dataflow** (pipelines, stages, streams, batch)

## Purpose

Use this document when the primary design tension is **how data moves**
(sources, transforms, sinks, ordering, idempotency), not UI shells or domain
policy centers. Project-specific paths appear only in sections labeled `Example`.

This stub gives shape for continued grilling and planning. It is not a rule set
until promoted from stub.

## Definition

Dataflow architecture organizes work around **stages** in a directed graph:
ingest, transform, enrich, deliver. Batch and stream variants share stage
boundaries; correctness emphasizes ordering, retries, and schema contracts.

TBD:

- Stage contracts (input/output schemas).
- Exactly-once vs at-least-once expectations.
- Human-in-the-loop stages in AI pipelines (RAG, eval, speech).

## Core Rule

```text
Planning a slice does not grant permission to bypass architecture.
```

If a slice changes stage contracts, ordering guarantees, or sink ownership, the
planner must create an architecture decision slice before implementation.
Conditions are defined in `codex-router-planner-unified.md`.

**Router note:** Unified router `architecture_contract` still targets
domain-spoke until this contract is wired. Use `touched_stages` and
`conceptual_ownership` in stub slices; physical paths via
`project_layer_mapping`.

## Shape

```text
  [ source ] --> [ stage ] --> [ stage ] --> [ sink ]
                      |              |
                      +---- branch ---+ (TBD)
```

## Required Vocabulary

Stage:
A transform with explicit input contract, output contract, and failure mode TBD.

Source:
Origin of records or bytes (file, topic, API, model output) TBD.

Sink:
Terminal consumer (warehouse, index, file, downstream API) TBD.

Pipeline:
Named composition of stages with documented ordering TBD.

Backpressure:
How overload is signaled and handled TBD.

## Stage and Pipeline Rules

TBD:

- Stages are idempotent or explicitly not; document which.
- Side effects only at declared sinks.
- AI pipeline stages (embed, retrieve, generate) as first-class stages TBD.
- Observability per stage (metrics, dead-letter) TBD.

## Ownership Model

| Conceptual owner | Owns (TBD detail) | Must not own |
|------------------|-------------------|--------------|
| Stage | Transform logic, stage-local schema | End-to-end product policy |
| Pipeline | Composition, ordering, SLAs | UI presentation |
| Source adapter | Read boundary, parse | Business invariants in parser |
| Sink adapter | Write boundary, delivery | Domain center rules |

Physical paths resolve through `project_layer_mapping`.

## Deployment Coupling

TBD: batch jobs, stream processors, GPU workers, serverless steps, notebook jobs.

Deployment topology often **is** the pipeline layout.

## Folder Schema

TBD. Typical patterns (not prescriptive): `pipelines/`, `stages/`, `jobs/`.

Do not create empty architecture folders.

## Architecture Records

### Project Architecture Record

```lisp
(architecture
  (name "<project architecture name>")
  (family dataflow_stream)
  (status stub)
  (primary_pipelines
    (pipeline
      (name "<pipeline name>")
      (stages TBD "<ordered stage names>")
      (sla TBD)
      (proof TBD)))
  (architecture_tests TBD))
```

### Stage Record

```lisp
(stage
  (name "<stage_name>")
  (status planned | active | implemented | retired)
  (intent TBD "<transform purpose>")
  (input_contract TBD)
  (output_contract TBD)
  (ordering TBD "<strict | best_effort>")
  (idempotency TBD "<yes | no | conditional>")
  (forbidden_side_effects TBD)
  (proof TBD))
```

### Phase, Slice, and Architecture Decision Records

Use packet shapes from `codex-extraction-packet-schema-sexpr.md`. Stub slice
vocabulary: `touched_stages`, `conceptual_ownership`.

```lisp
(slice
  (name "<slice name>")
  (phase "<phase name>")
  (status planned | active | review_needed | passed | failed | deferred)
  (intent TBD)
  (touched_stages TBD)
  (conceptual_ownership TBD)
  (allowed_edits TBD)
  (forbidden_edits TBD)
  (architecture_guardrails TBD)
  (proof TBD)
  (review_question TBD))
```

## Planner Contract

1. Identify the data movement or contract change TBD.
2. Select pipeline and stage(s) TBD.
3. State input/output contracts affected TBD.
4. State ordering and idempotency rules TBD.
5. Name guardrails (no hidden sinks) TBD.
6. Define proof before implementation TBD.
7. Mark out-of-scope (UI ownership, etc.) TBD.

## Naming Rules

TBD. Stage and pipeline names should reveal transform role or data product.

## Architecture Test Rules

TBD:

- Stage tests with fixture inputs and expected outputs.
- Pipeline integration proof for ordering TBD.
- No silent cross-pipeline writes TBD.

## Anti-Patterns

TBD:

- God-stage that ingests, rules, and renders.
- Undocumented ordering assumptions.
- Sinks that mutate upstream contracts without ADS.

## Migration Path From A Messy App

1. Draw current data movement as stages TBD.
2. Mark implicit sinks and side effects TBD.
3. Extract one stage boundary; prove TBD.

## Research Backlog

- RAG and speech pipelines as standard stage templates.
- Stream vs batch unification in slice planning.
- Combination with agent-orchestration (control flow vs data flow).
- Router wiring for dataflow `architecture_contract`.
