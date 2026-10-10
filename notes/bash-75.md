# bash

## What I got wrong

Was overcomplicating it. The simple approach is fine.

## What actually works

Check the changelog when upgrading - breaking changes aren't always obvious.

## The deeper issue

I think the real problem was my mental model. I was thinking about bash as a synchronous process, but it's fundamentally async. Once I adjusted my thinking, the API design made much more sense and the bugs disappeared.

_2026-05-05_


## Update (2026-10-10)

Added some context from a recent project. We hit the exact issue described in the 'Gotchas' section. The fix was straightforward once we identified it, but finding the root cause took hours.

_2026-10-10_
