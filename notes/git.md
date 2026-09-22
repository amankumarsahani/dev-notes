# git

Learned something useful about git today.

## Key takeaway

The default behavior is not what I expected - need to be explicit about configuration.

## Details

Turns out the git docs describe v1 behavior but v2 changed the defaults. Key difference: the timeout used to be 30s, now it's 0 (infinite). This explained why my integration tests were hanging.

## See also

- astro
- gcp

---
_2026-09-22_
