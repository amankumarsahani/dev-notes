# architecture

Useful patterns:

- Prefer composition over inheritance.
- Make illegal states unrepresentable.

_2026-04-25_

## FAQ

**Q: When should I use this vs the alternative?**

A: Tested up to ~10k concurrent connections. Beyond that, you need to shard or use a different approach.

## Update (2026-08-18)

Found a better way to think about this. Instead of treating it as a request-response pattern, model it as a stream. The API supports both, but streaming is more resilient to timeouts and partial failures.

_2026-08-18_
