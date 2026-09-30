# cqrs

Useful cqrs patterns I picked up:

## Core principles

- Prefer composition over inheritance for flexibility.
- Make illegal states unrepresentable.

## Applied to cqrs

In practice, this means your cqrs setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes.

## Anti-patterns to avoid

1. Don't cache cqrs results without a TTL
2. Don't share cqrs connections across threads without pooling
3. Don't log sensitive cqrs config values (seen this too many times)

_2026-07-21_

## Update (2026-09-30)

Clarified a few points that were vague. Specifically, the initialization order matters: configure logging first, then connections, then start the worker pool. Doing it out of order causes silent failures.

_2026-09-30_
