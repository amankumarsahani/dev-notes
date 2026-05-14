# make

Learned something useful about make today.

## Key takeaway

This interacts with deno in a non-obvious way.

## Details

I spent a while debugging this. The root cause was that make caches aggressively by default, and when your deno configuration changes, the stale cache causes confusing behavior. Adding a cache-busting parameter fixed it.

## See also

- deno
- algorithms

---
_2026-05-08_
