# python

Learned something useful about python today.

## Key takeaway

This interacts with cap-theorem in a non-obvious way.

## Details

The trick is to separate the read and write paths. python handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load.

## See also

- cap-theorem
- bun

---
_2026-09-12_
