# postgres

Learned something useful about postgres today.

## Key takeaway

Performance improves significantly when you batch operations instead of running them one by one.

## Details

The trick is to separate the read and write paths. postgres handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load.

## See also

- ssl
- htmx

---
_2026-05-14_
