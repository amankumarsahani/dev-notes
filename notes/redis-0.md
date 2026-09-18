# redis

Useful redis patterns I picked up:

## Core principles

- Keep the hot path simple - push complexity to the edges.
- Make illegal states unrepresentable.

## Applied to redis

For redis, the composition approach works well: build small, focused redis utilities and combine them. A monolithic redis config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache redis results without a TTL
2. Don't share redis connections across threads without pooling
3. Don't log sensitive redis config values (seen this too many times)

_2026-09-18_
