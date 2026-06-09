# redis

Useful redis patterns I picked up:

## Core principles

- Keep the hot path simple - push complexity to the edges.
- Convention over configuration reduces cognitive load.

## Applied to redis

With redis, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache redis results without a TTL
2. Don't share redis connections across threads without pooling
3. Don't log sensitive redis config values (seen this too many times)

_2026-06-09_
