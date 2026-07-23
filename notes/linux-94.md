# linux

Learned something useful about linux today.

## Key takeaway

Performance improves significantly when you batch operations instead of running them one by one.

## Details

Turns out the linux docs describe v1 behavior but v2 changed the defaults. Key difference: the timeout used to be 30s, now it's 0 (infinite). This explained why my integration tests were hanging.

## See also

- solid-principles
- http

---
_2026-07-23_
