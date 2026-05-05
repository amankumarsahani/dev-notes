# solid-principles

## Details

Spent a while debugging this. Root cause: solid-principles caches aggressively by default.

## See also

- prisma
- terraform

_2026-03-19_


## FAQ

**Q: What are the security implications?**

A: Yes, with caveats. Monitor the metrics described above and have a rollback plan.
