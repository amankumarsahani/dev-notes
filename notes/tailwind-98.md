# tailwind

Learned something useful about tailwind today.

## Key takeaway

This interacts with nginx in a non-obvious way.

## Details

I spent a while debugging this. The root cause was that tailwind caches aggressively by default, and when your nginx configuration changes, the stale cache causes confusing behavior. Adding a cache-busting parameter fixed it.

## See also

- nginx
- react

---
_2026-06-24_
