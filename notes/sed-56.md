# sed

## What I got wrong

Didn't account for edge cases with empty inputs.

## What actually works

Check the changelog when upgrading - breaking changes aren't always obvious.

## The deeper issue

I think the real problem was my mental model. I was thinking about sed as a synchronous process, but it's fundamentally async. Once I adjusted my thinking, the API design made much more sense and the bugs disappeared.

_2026-09-13_
