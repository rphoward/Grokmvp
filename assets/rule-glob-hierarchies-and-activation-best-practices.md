---
title: Rule Glob Hierarchies and Activation Best Practices
date: 2026-05-29
status: current-house-convention
---

(def-record rule-glob-hierarchies-and-activation-best-practices
  (context
    (target "any-agent-working-with-rules-or-placing-internal-artifacts")
    (related-rules (repo-layout internal-doc-style doc-style)))

  <central_idea>
  (center-of-gravity
    (invariant "Human-facing prose lives under docs/references/ (and root *.md + explicit human subdirs). Machine-only Lisp-shaped records, schemas, prompts, decision artifacts, and generated flat files live at root assets/ (plus assets/internal/**, schemas/**, internal/**). This is the deliberate house partition. The 7 clean .mdc rules are the activation surface; root assets/ machine files activate via assets/** glob (plus explicit links for deeper trees)."))
  </central_idea>

  (current-partition
    (human-prose "docs/references/** + selected root *.md + future explicit human trees (e.g. docs/guides/**)")
    (machine-only-lisp "assets/ (root-level home) + assets/internal/** + schemas/** + internal/**")
    (notes
      (grokmvp "Grokmvp/ is the dedicated final deliverable subfolder. It contains its own .git and will have its own remote.")
      (root-assets "User-directed exception to the subfolder preference in repo-layout.mdc for machine-only material.")))

  (activation-matrix
    (always-apply (conduct safety thermonuclear repo-layout))
    (glob-scoped
      (mdc-authoring ".cursor/rules/**")
      (doc-style "README.md, docs/**, *.md")
      (internal-doc-style "assets/**, docs/assets/**, docs/internal/**, internal/**, schemas/**")))

  (verification-habits
    (v1 "Classify every new artifact as human-prose or machine-lisp before placing it. Use the partition above.")
    (v2 "After any structural classification change or move involving rules/docs/assets: run the project's test command (currently N/A) and report the exact result before claiming complete.")
    (v3 "Any claim about Cursor .mdc glob semantics must append 'verify locally with the installed version' and cite the concrete release/docs used.")))

