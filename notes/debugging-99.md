# debugging

Learned something useful about debugging today.

## Key takeaway

Error handling here is subtle - silent failures can cause hard-to-debug issues downstream.

## Details

The trick is to separate the read and write paths. debugging handles reads well out of the box, but writes need explicit transaction management. Without it, you get partial updates under concurrent load.

## See also

- postgres
- twelve-factor

---
_2026-08-20_
