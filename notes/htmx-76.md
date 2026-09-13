# htmx

Learned something useful about htmx today.

## Key takeaway

This interacts with postgres in a non-obvious way.

## Details

The trick is to separate the read and write paths. htmx handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load.

## See also

- postgres
- trpc

---
_2026-09-13_
