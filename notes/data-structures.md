# data-structures

## What I got wrong

Was overcomplicating it.

## What works

Start with minimal config.

_2026-01-07_

- Need to benchmark this

## Update (2026-02-24)

Clarified some vague points.

_2026-02-24_


## FAQ

**Q: What are the security implications?**

A: Tested up to ~10k concurrent connections. Beyond that, you need to shard or use a different approach.

## Update (2026-09-05)

Updated after running into this again in a different project. The pattern is consistent: always validate config at startup, not at first use. Fail fast saves debugging time.

_2026-09-05_
