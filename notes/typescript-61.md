# typescript notes

Quick reference for something I keep forgetting.

## Setup

```bash
# basic typescript initialization
# TODO: add actual commands from my project
echo "setup typescript"
```

## Common patterns

1. **Default config**: Usually fine for dev, but tighten for prod
2. **Error handling**: Always wrap in try/catch (or equivalent)
3. **Cleanup**: Don't forget teardown - leaks are subtle

## Gotchas




See also: astro

_Updated 2026-06-07_

## Update (2026-06-30)

Found a better way to think about this. Instead of treating it as a request-response pattern, model it as a stream. The API supports both, but streaming is more resilient to timeouts and partial failures.

_2026-06-30_
