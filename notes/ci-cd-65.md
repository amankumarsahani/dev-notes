# ci-cd

Useful ci-cd patterns I picked up:

## Core principles

- Keep the hot path simple - push complexity to the edges.
- Timeouts should always be explicit, never infinite.

## Applied to ci-cd

For ci-cd, the composition approach works well: build small, focused ci-cd utilities and combine them. A monolithic ci-cd config file is a maintenance nightmare.

## Anti-patterns to avoid

1. Don't cache ci-cd results without a TTL
2. Don't share ci-cd connections across threads without pooling
3. Don't log sensitive ci-cd config values (seen this too many times)

_2026-09-29_

## Example

```
# Minimal reproduction of the issue
# Run with: [command here]
input = prepare_test_data()
output = process(input)
assert output.status == 'ok', f'Expected ok, got {output.status}'
```

_2026-09-30_
