# vim notes

Quick reference for something I keep forgetting.

## Setup

```bash
# basic vim initialization
# TODO: add actual commands from my project
echo "setup vim"
```

## Common patterns

1. **Default config**: Usually fine for dev, but tighten for prod
2. **Error handling**: Always wrap in try/catch (or equivalent)
3. **Cleanup**: Don't forget teardown - leaks are subtle

## Gotchas




See also: svelte

_Updated 2026-10-30_

## Update (2026-11-09)

Added some context from a recent project. We hit the exact issue described in the 'Gotchas' section. The fix was straightforward once we identified it, but finding the root cause took hours.

_2026-11-09_
