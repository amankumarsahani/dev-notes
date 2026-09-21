# hexagonal

Useful hexagonal patterns I picked up:

## Core principles

- Always validate inputs at the boundary, not deep inside.
- Timeouts should always be explicit, never infinite.

## Applied to hexagonal

In practice, this means your hexagonal setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes.

## Anti-patterns to avoid

1. Don't cache hexagonal results without a TTL
2. Don't share hexagonal connections across threads without pooling
3. Don't log sensitive hexagonal config values (seen this too many times)

_2026-09-21_
