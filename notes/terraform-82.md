# terraform

Learned something useful about terraform today.

## Key takeaway

This interacts with trpc in a non-obvious way.

## Details

Turns out the terraform docs describe v1 behavior but v2 changed the defaults. Key difference: the timeout used to be 30s, now it's 0 (infinite). This explained why my integration tests were hanging.

## See also

- trpc
- ddd

---
_2026-10-21_
