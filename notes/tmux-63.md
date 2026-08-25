# tmux

Useful tmux patterns I picked up:

## Core principles

- Prefer composition over inheritance for flexibility.
- Don't optimize until you've measured.

## Applied to tmux

With tmux, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache tmux results without a TTL
2. Don't share tmux connections across threads without pooling
3. Don't log sensitive tmux config values (seen this too many times)

_2026-08-25_
