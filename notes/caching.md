# caching

Useful caching patterns I picked up:

## Core principles

- Write the test first when fixing a bug - prevents regressions.
- Make illegal states unrepresentable.

## Applied to caching

With caching, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache caching results without a TTL
2. Don't share caching connections across threads without pooling
3. Don't log sensitive caching config values (seen this too many times)

_2026-06-01_
