# sqlite cheatsheet

Common operations:

1. Setup / init
2. Basic usage
3. Advanced patterns

> Filling in details as I go.

_2026-05-21_


## FAQ

**Q: Is this production-ready?**

A: Follow the principle of least privilege. The default permissions are too broad for production.

## Update (2026-11-18)

Added some context from a recent project. We hit the exact issue described in the 'Gotchas' section. The fix was straightforward once we identified it, but finding the root cause took hours.

_2026-11-18_
