# queues

Useful queues patterns I picked up:

## Core principles

- Keep the hot path simple - push complexity to the edges.
- Make illegal states unrepresentable.

## Applied to queues

For queues, the composition approach works well: build small, focused queues utilities and combine them. A monolithic queues config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache queues results without a TTL
2. Don't share queues connections across threads without pooling
3. Don't log sensitive queues config values (seen this too many times)

_2026-05-23_
