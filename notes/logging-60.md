# logging

Learned something useful about logging today.

## Key takeaway

This interacts with tar in a non-obvious way.

## Details

I spent a while debugging this. The root cause was that logging caches aggressively by default, and when your tar configuration changes, the stale cache causes confusing behavior. Adding a cache-busting parameter fixed it.

## See also

- tar
- concurrency

---
_2026-07-09_
