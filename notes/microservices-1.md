# microservices

Learned something useful about microservices today.

## Key takeaway

This interacts with concurrency in a non-obvious way.

## Details

The trick is to separate the read and write paths. microservices handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load.

## See also

- concurrency
- hexagonal

---
_2026-08-27_
