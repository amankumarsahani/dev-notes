# linux

## What I got wrong

Forgot that this runs in a different context in CI.

## What actually works

Test with real data, not just mocks.

## The deeper issue

I think the real problem was my mental model. I was thinking about linux as a synchronous process, but it's fundamentally async. Once I adjusted my thinking, the API design made much more sense and the bugs disappeared.

_2026-07-10_
