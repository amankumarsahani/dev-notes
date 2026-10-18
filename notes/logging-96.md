# logging

Useful logging patterns I picked up:

## Core principles

- Write the test first when fixing a bug - prevents regressions.
- Don't optimize until you've measured.

## Applied to logging

With logging, the boundary validation principle is especially important because invalid inputs can cascade through the entire pipeline before failing with a cryptic error three layers deep.

## Anti-patterns to avoid

1. Don't cache logging results without a TTL
2. Don't share logging connections across threads without pooling
3. Don't log sensitive logging config values (seen this too many times)

_2026-10-18_
