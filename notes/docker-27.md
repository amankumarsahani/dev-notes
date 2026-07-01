# docker

## What I got wrong

Assumed it worked like the previous version. It doesn't.

## What actually works

Start with the minimal config and add only what you need.

## The deeper issue

I think the real problem was my mental model. I was thinking about docker as a synchronous process, but it's fundamentally async. Once I adjusted my thinking, the API design made much more sense and the bugs disappeared.

_2026-07-01_
