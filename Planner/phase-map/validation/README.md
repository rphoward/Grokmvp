# Phase map validation (optional on-disk)

The **authoritative** phase-map validation step is the chat-only prompt in
`Planner/contracts/phase_map_review_prompt.md` (`(forbid writing_files)`).

This directory is reserved for **optional** artifacts, for example:

- A dated human verdict pasted as `YYYY-MM-DD-verdict.sx`, or
- Future automation that records solver-backed checks **without** changing the
  default prompt’s output contract.

Nothing here is required for v4 routing in a greenfield repo.
