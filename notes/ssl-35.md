# ssl

Useful ssl patterns I picked up:

## Core principles

- Prefer composition over inheritance for flexibility.
- Timeouts should always be explicit, never infinite.

## Applied to ssl

With ssl, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache ssl results without a TTL
2. Don't share ssl connections across threads without pooling
3. Don't log sensitive ssl config values (seen this too many times)

_2026-07-07_
