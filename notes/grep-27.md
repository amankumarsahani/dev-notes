# grep

## What I got wrong

Forgot that this runs in a different context in CI.

## What actually works

Start with the minimal config and add only what you need.

## The deeper issue

My mistake was testing grep in isolation. It works fine alone, but the interaction with htmx introduces timing dependencies that only show up under realistic conditions.

_2026-09-11_
