# 06 - Reviewer And Integration Gate

## Goal

Create a review gate that can evaluate worker handbacks and integrated slice
state without planning the next slice in the same pass.

## Why this matters

Review is the trust boundary between implementation and durable run records.
For multi-agent work, review must check both individual worker packages and the
integrated result before appending `PROOF-LOG.md`.

## Inputs

- selected `RUN_DIR/STATUS.md`
- active `NEXT-SLICE.md`
- work-package handbacks
- integration summary
- changed files
- proof outputs
- architecture contract
- ownership and write-set records

## Outputs

- pass/fail/partial result
- findings
- required repairs
- proof summary
- `PROOF-LOG.md` append only on pass or pass-with-debt
- `STATUS.md` transition
- no next-slice plan

## Required behavior

- Verify each worker stayed inside its write set.
- Verify integration did not introduce forbidden files or ownership changes.
- Verify required proof ran in the right scope.
- Preserve slice type.
- Do not plan the next slice during review.
- Do not close a corrective item unless `resolution_id` matches a flagged item.

## Planning questions

- Should worker package review happen before integration, after integration, or
  both?
- Should the reviewer call the router simulator after writing review results?
- How should review findings bind to specific work packages?
- Can review be parallelized by package, with final coordinator review?

## Search/research items

- Code review automation patterns for multi-branch work.
- Test evidence provenance and artifact recording.
- Static diff ownership validation.
- Multi-agent reviewer/coordinator workflows.

## First useful slice

Define a `work_package_handback` schema and a `review_integration_gate` packet.
Make the gate read-only at first, producing a recommended review result without
writing `PROOF-LOG.md`.

