# terraform

Quick terraform reference:

| Command / Pattern | Description | Notes |
|-------------------|-------------|-------|
| `init` | Initialize terraform | Run once per project |
| `status` | Check current state | Safe to run anytime |
| `apply` | Apply changes | Review diff first |
| `rollback` | Undo last change | Keep backups |
| `verify` | Validate config | Run in CI |

## Common flags

- `--verbose`: Extra output for debugging
- `--dry-run`: Preview without applying
- `--force`: Skip confirmations (use carefully)

_2026-05-27_
