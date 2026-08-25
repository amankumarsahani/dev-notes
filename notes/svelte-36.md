# svelte

Useful svelte patterns I picked up:

## Core principles

- Keep the hot path simple - push complexity to the edges.
- Idempotency saves you when retries happen.

## Applied to svelte

For svelte, the composition approach works well: build small, focused svelte utilities and combine them. A monolithic svelte config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache svelte results without a TTL
2. Don't share svelte connections across threads without pooling
3. Don't log sensitive svelte config values (seen this too many times)

_2026-08-25_
