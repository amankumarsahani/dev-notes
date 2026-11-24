# systemd

Quick systemd reference:

| Command / Pattern | Description | Notes |
|-------------------|-------------|-------|
| `init` | Initialize systemd | Run once per project |
| `status` | Check current state | Safe to run anytime |
| `apply` | Apply changes | Review diff first |
| `rollback` | Undo last change | Keep backups |
| `verify` | Validate config | Run in CI |

## Common flags

- `--verbose`: Extra output for debugging
- `--dry-run`: Preview without applying
- `--force`: Skip confirmations (use carefully)

_2026-05-11_



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

_2026-11-24_
