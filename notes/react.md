# react

Useful react patterns I picked up:

## Core principles

- Always validate inputs at the boundary, not deep inside.
- Timeouts should always be explicit, never infinite.

## Applied to react

With react, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache react results without a TTL
2. Don't share react connections across threads without pooling
3. Don't log sensitive react config values (seen this too many times)

_2026-09-04_
