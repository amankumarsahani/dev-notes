# architecture

Useful patterns:

- Prefer composition over inheritance.
- Make illegal states unrepresentable.

_2026-04-25_

## FAQ

**Q: When should I use this vs the alternative?**

A: Tested up to ~10k concurrent connections. Beyond that, you need to shard or use a different approach.
