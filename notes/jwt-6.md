# jwt - bookmark

Found a really good explanation of this concept.

## Summary

The mental model matters more than memorizing the API. Think of jwt as a state machine with well-defined transitions, and most of the edge cases become obvious.

## Key points

- jwt and kubernetes are often used together, but they solve different problems
- The ecosystem is mature - prefer well-maintained libraries over rolling your own
- Community plugins vary wildly in quality - check maintenance status before depending on them

Related: kubernetes, deno

_2026-06-26_

## FAQ

**Q: How does this scale?**

A: Follow the principle of least privilege. The default permissions are too broad for production.
