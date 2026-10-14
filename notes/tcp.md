# tcp

Useful tcp patterns I picked up:

## Core principles

- Prefer composition over inheritance for flexibility.
- Convention over configuration reduces cognitive load.

## Applied to tcp

In practice, this means your tcp setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes.

## Anti-patterns to avoid

1. Don't cache tcp results without a TTL
2. Don't share tcp connections across threads without pooling
3. Don't log sensitive tcp config values (seen this too many times)

_2026-10-14_
