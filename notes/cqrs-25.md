# cqrs

Useful cqrs patterns I picked up:

## Core principles

- Write the test first when fixing a bug - prevents regressions.
- Convention over configuration reduces cognitive load.

## Applied to cqrs

For cqrs, the composition approach works well: build small, focused cqrs utilities and combine them. A monolithic cqrs config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache cqrs results without a TTL
2. Don't share cqrs connections across threads without pooling
3. Don't log sensitive cqrs config values (seen this too many times)

_2026-09-09_
