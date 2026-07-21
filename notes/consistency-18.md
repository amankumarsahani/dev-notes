# consistency

Learned something useful about consistency today.

## Key takeaway

The documentation is misleading on this point. Source code tells the real story.

## Details

Turns out the consistency docs describe v1 behavior but v2 changed the defaults. Key difference: the timeout used to be 30s, now it's 0 (infinite). This explained why my integration tests were hanging.

## See also

- deno
- git

---
_2026-07-21_
