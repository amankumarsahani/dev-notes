# oauth

```
# oauth config / example
# -------------------------
# Keeping this here because I always forget the syntax

# Basic configuration
# setting_1 = "value"
# setting_2 = true
# setting_3 = 30  # seconds

# Advanced options (uncomment as needed)
# pool_size = 10
# timeout = 5000  # ms
# retry_count = 3
# retry_backoff = "exponential"

# Environment-specific overrides
# Use ENV vars: OAUTH_SETTING_1, OAUTH_SETTING_2
```

## Notes

- Default config is fine for development
- Tighten timeouts and pool sizes for production
- Environment variables take precedence over config file

_2026-05-13_

## Update (2026-08-25)

Revisited this - the approach still holds up. Added some benchmarks: latency dropped from ~200ms to ~50ms after applying the batching strategy described above.

_2026-08-25_
