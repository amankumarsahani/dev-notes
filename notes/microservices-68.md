# microservices - TIL

Today I learned that microservices supports streaming out of the box - no need for the workaround I was using.

## Context

Found this while reading the microservices source code to debug a debugging issue. The code is surprisingly clean - worth reading if you use microservices regularly.

## Impact

Performance improvement is marginal, but code clarity improves a lot.

_2026-06-18_

## Example

```
# Configuration template
config:
  timeout: 5000
  retries: 3
  pool_size: 10
  log_level: info
  # Override per environment via env vars
```

_2026-08-17_
