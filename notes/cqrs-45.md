# cqrs

Useful cqrs patterns I picked up:

## Core principles

- Always validate inputs at the boundary, not deep inside.
- Idempotency saves you when retries happen.

## Applied to cqrs

With cqrs, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache cqrs results without a TTL
2. Don't share cqrs connections across threads without pooling
3. Don't log sensitive cqrs config values (seen this too many times)

_2026-11-23_
