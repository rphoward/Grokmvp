It's almost portable. The S-expression content is project-agnostic — the phase and slice machinery, the gates, the authority hierarchy, all of it describes a workflow not a project.

Two things bind it currently:

**The `paths` block at the top:**
```lisp
(paths
  (self    "Planner/contracts/codex-router-planner-unified.md")
  (schema  "Planner/contracts/codex-extraction-packet-schema-sexpr.md")
  (arch    "Planner/contracts/domain-spoke-architecture.md"))
```
These are hardcoded repo-relative paths. In a new project you'd update these three lines to wherever you put the files.

**The `create_phase_map` write path:**
```lisp
(path "docs/architecture-intake/<short-topic>-phase-map.md")
```
That's a convention path. Same fix — update it to match the new project's folder structure.

Everything else — the phase tier, the classification gates, the review gate, the architecture contract, the authority hierarchy — is pure workflow logic with no project references. `domain-spoke-architecture.md` is already explicitly written to be project-agnostic, which is why it lives as a separate file rather than being fully inlined.

So the portability pattern is: copy three files to the new repo (`codex-router-planner-unified.md`, `codex-extraction-packet-schema-sexpr.md`, `domain-spoke-architecture.md`), update the five path references, done.