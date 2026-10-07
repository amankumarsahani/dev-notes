# zod

Useful zod patterns I picked up:

## Core principles

- Logging > debugging in production.
- Convention over configuration reduces cognitive load.

## Applied to zod

For zod, the composition approach works well: build small, focused zod utilities and combine them. A monolithic zod config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache zod results without a TTL
2. Don't share zod connections across threads without pooling
3. Don't log sensitive zod config values (seen this too many times)

_2026-10-07_
