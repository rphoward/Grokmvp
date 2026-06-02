# Agent / Orchestration Architecture

Status: **stub** (not selectable; research and router wiring TBD)

Organizing axis: **agent** (tool loops, plan-act-observe, human gates)

## Purpose

Use this document when the primary design tension is **how autonomous or
semi-autonomous agents run** (prompts, tools, memory, halts), distinct from
domain business rules, UI surfaces, or batch data pipelines.

This stub gives shape for continued grilling and planning. It is not a rule set
until promoted from stub.

## Definition

Agent-orchestration architecture organizes work around **loops**: perceive,
plan, act (tools), observe, halt or escalate. Tools and context boundaries are
explicit; non-determinism is expected and bounded by policy.

TBD:

- Single vs multi-agent roles.
- Tool allowlists and credential boundaries.
- Human-in-the-loop gates vs silent automation.

## Core Rule

```text
Planning a slice does not grant permission to bypass architecture.
```

If a slice changes tool exposure, memory scope, halt policy, or escalation paths,
the planner must create an architecture decision slice before implementation.
See `codex-router-planner-unified.md`.

**Router note:** Until wired, use `touched_loops` and `conceptual_ownership`;
physical paths via `project_layer_mapping`. Factory planner/router work often
stays domain-spoke; this family targets AI-native products built in or on the
factory.

## Shape

```text
  [ human gate? ] --> [ orchestrator ]
                           |
            +--------------+--------------+
            |              |              |
        [ tool A ]     [ tool B ]     [ memory scope ]
            |              |              |
            +--------------+--------------+
                           |
                     [ observe / halt ]
```

## Required Vocabulary

Agent loop:
A bounded plan-act-observe cycle with explicit stop conditions TBD.

Tool:
Callable capability with schema, auth scope, and failure mode TBD.

Orchestrator:
Component that selects tools and enforces policy TBD.

Memory scope:
What context may persist across turns or slices TBD.

Halt gate:
Condition that stops generation and asks a human TBD.

## Loop and Tool Rules

TBD:

- Tools are allowlisted; no ad-hoc shell without policy.
- Secrets never enter prompts or logs TBD.
- One recommendation per halt TBD (align with workspace conduct).
- Planner mode vs implementation mode isolation for routed factory work TBD.

## Ownership Model

| Conceptual owner | Owns (TBD detail) | Must not own |
|------------------|-------------------|--------------|
| Orchestrator | Loop policy, tool routing | Domain invariants (defer to domain-spoke) |
| Tool adapter | One outside capability | Cross-tool business rules |
| Memory store | Scoped retention | Authoritative business truth |
| Human gate | Escalation UX | Silent failure |

## Deployment Coupling

TBD: IDE agent, server worker, queue consumer, embedded copilot.

Runtime affects tool availability and proof (local vs cloud).

## Folder Schema

TBD: `agents/`, `tools/`, `prompts/` — refine after research.

Do not create empty folders.

## Architecture Records

### Project Architecture Record

```lisp
(architecture
  (name "<project architecture name>")
  (family agent_orchestration)
  (status stub)
  (primary_loops
    (agent_loop
      (name "<loop name>")
      (tools_allowed TBD)
      (memory_scope TBD)
      (halt_gates TBD)
      (proof TBD)))
  (architecture_tests TBD))
```

### Agent Loop Record

```lisp
(agent_loop
  (name "<loop_name>")
  (status planned | active | implemented | retired)
  (intent TBD "<outcome>")
  (tools_allowed TBD)
  (tools_forbidden TBD)
  (memory_scope TBD)
  (halt_policy TBD)
  (human_gate TBD "<when required>")
  (proof TBD))
```

### Phase, Slice, and Architecture Decision Records

Use `(phase …)`, `(slice …)`, and `(architecture_decision_slice …)` from
`codex-extraction-packet-schema-sexpr.md`. Stub vocabulary: `touched_loops`,
`conceptual_ownership`.

```lisp
(slice
  (name "<slice name>")
  (phase "<phase name>")
  (status planned | active | review_needed | passed | failed | deferred)
  (intent TBD)
  (touched_loops TBD)
  (conceptual_ownership TBD)
  (allowed_edits TBD)
  (forbidden_edits TBD)
  (architecture_guardrails TBD)
  (proof TBD)
  (review_question TBD))
```

## Planner Contract

1. Identify the loop and user-visible outcome TBD.
2. List tools touched and allowlist changes TBD.
3. State memory and context boundaries TBD.
4. Define halt and escalation TBD.
5. Name guardrails (safety, secrets) TBD.
6. Define proof before implementation TBD.
7. Mark out-of-scope (domain refactors without ADS) TBD.

## Naming Rules

TBD. Loop and tool names should reveal capability and trust boundary.

## Architecture Test Rules

TBD:

- Tool calls mocked or sandboxed in tests.
- Halt paths verified without silent continue.
- No credential leakage in fixtures TBD.

## Anti-Patterns

TBD:

- Unbounded tool access.
- Chat memory as system of record for business truth.
- Mixing planner and implement modes in one agent step.

## Migration Path From A Messy App

1. Inventory existing automations and prompts TBD.
2. Draw tool and data boundaries TBD.
3. Add one allowlist and one halt; prove TBD.

## Research Backlog

- MCP and external tool registration patterns.
- Overlap with dataflow (RAG stages) vs control flow (this family).
- How factory router maps to agent products without conflating Planner Lisp artifacts.
- Router `architecture_contract` for agent selection.
