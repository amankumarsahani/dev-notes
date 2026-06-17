# caching

Useful caching patterns I picked up:

## Core principles

- Prefer composition over inheritance for flexibility.
- Idempotency saves you when retries happen.

## Applied to caching

In practice, this means your caching setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes.

## Anti-patterns to avoid

1. Don't cache caching results without a TTL
2. Don't share caching connections across threads without pooling
3. Don't log sensitive caching config values (seen this too many times)

_2026-06-17_
