# tmux

```
# tmux config / example
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
# Use ENV vars: TMUX_SETTING_1, TMUX_SETTING_2
```

## Notes

- Default config is fine for development
- Tighten timeouts and pool sizes for production
- Environment variables take precedence over config file

_2026-08-05_

## Update (2026-08-31)

Found a better way to think about this. Instead of treating it as a request-response pattern, model it as a stream. The API supports both, but streaming is more resilient to timeouts and partial failures.

_2026-08-31_
