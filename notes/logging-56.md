# logging

Learned something useful about logging today.

## Key takeaway

The documentation is misleading on this point. Source code tells the real story.

## Details

I spent a while debugging this. The root cause was that logging caches aggressively by default, and when your queues configuration changes, the stale cache causes confusing behavior. Adding a cache-busting parameter fixed it.

## See also

- queues
- queues

---
_2026-10-15_
