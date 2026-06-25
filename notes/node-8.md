# node

Learned something useful about node today.

## Key takeaway

Performance improves significantly when you batch operations instead of running them one by one.

## Details

The trick is to separate the read and write paths. node handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load.

## See also

- systemd
- ssl

---
_2026-06-25_
