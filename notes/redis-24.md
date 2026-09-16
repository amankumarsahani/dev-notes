# redis

Useful redis patterns I picked up:

## Core principles

- Always validate inputs at the boundary, not deep inside.
- Idempotency saves you when retries happen.

## Applied to redis

In practice, this means your redis setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes.

## Anti-patterns to avoid

1. Don't cache redis results without a TTL
2. Don't share redis connections across threads without pooling
3. Don't log sensitive redis config values (seen this too many times)

_2026-09-16_
