# rest-api

Useful rest-api patterns I picked up:

## Core principles

- Logging > debugging in production.
- Don't optimize until you've measured.

## Applied to rest-api

For rest-api, the composition approach works well: build small, focused rest-api utilities and combine them. A monolithic rest-api config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache rest-api results without a TTL
2. Don't share rest-api connections across threads without pooling
3. Don't log sensitive rest-api config values (seen this too many times)

_2026-08-28_
