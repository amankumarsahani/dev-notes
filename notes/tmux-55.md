# tmux

Useful tmux patterns I picked up:

## Core principles

- Prefer composition over inheritance for flexibility.
- Timeouts should always be explicit, never infinite.

## Applied to tmux

In practice, this means your tmux setup should have a clear initialization phase and a clear shutdown phase. Mixing concerns leads to resource leaks that only show up in long-running processes.

## Anti-patterns to avoid

1. Don't cache tmux results without a TTL
2. Don't share tmux connections across threads without pooling
3. Don't log sensitive tmux config values (seen this too many times)

_2026-08-07_
