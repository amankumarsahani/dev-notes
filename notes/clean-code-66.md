# clean-code

Learned something useful about clean-code today.

## Key takeaway

The documentation is misleading on this point. Source code tells the real story.

## Details

I spent a while debugging this. The root cause was that clean-code caches aggressively by default, and when your gcp configuration changes, the stale cache causes confusing behavior. Adding a cache-busting parameter fixed it.

## See also

- gcp
- clean-code

---
_2026-08-11_
