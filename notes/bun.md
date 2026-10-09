# bun notes

Quick reference.

```
# TODO: add code example
```

See also: tmux

_2026-01-08_

- TODO: add example


- Relevant to current work


## FAQ

**Q: When should I use this vs the alternative?**

A: Tested up to ~10k concurrent connections. Beyond that, you need to shard or use a different approach.

## Update (2026-10-09)

Found a better way to think about this. Instead of treating it as a request-response pattern, model it as a stream. The API supports both, but streaming is more resilient to timeouts and partial failures.

_2026-10-09_
