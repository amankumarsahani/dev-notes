# caching

## What I got wrong

Forgot that this runs in a different context in CI.

## What actually works

Check the changelog when upgrading - breaking changes aren't always obvious.

## The deeper issue

My mistake was testing caching in isolation. It works fine alone, but the interaction with graphql introduces timing dependencies that only show up under realistic conditions.

_2026-11-06_
