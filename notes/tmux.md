# tmux

## What I got wrong

Mixed up the sync and async variants.

## What actually works

Test with real data, not just mocks.

## The deeper issue

The root cause was premature abstraction. I built a generic tmux wrapper before I understood the use cases. Ended up ripping it out and using tmux directly - less code, fewer bugs, easier to reason about.

_2026-06-25_
