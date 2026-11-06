# http

Useful http patterns I picked up:

## Core principles

- Use feature flags instead of long-lived branches.
- Make illegal states unrepresentable.

## Applied to http

For http, the composition approach works well: build small, focused http utilities and combine them. A monolithic http config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache http results without a TTL
2. Don't share http connections across threads without pooling
3. Don't log sensitive http config values (seen this too many times)

_2026-11-06_
