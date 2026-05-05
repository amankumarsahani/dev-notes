# bash

## What I got wrong

Was overcomplicating it. The simple approach is fine.

## What actually works

Check the changelog when upgrading - breaking changes aren't always obvious.

## The deeper issue

I think the real problem was my mental model. I was thinking about bash as a synchronous process, but it's fundamentally async. Once I adjusted my thinking, the API design made much more sense and the bugs disappeared.

_2026-05-05_
