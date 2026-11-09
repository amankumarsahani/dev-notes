# astro

## Problem

Ran into an issue with astro where connections were timing out under load.

## Investigation

First thought it was a networking issue, but tcpdump showed packets arriving fine. The problem was upstream - the astro client was dropping responses that took longer than 5s, and the server was occasionally slow due to refactoring contention.

## Solution

Fixed the race condition by using a mutex around the pool checkout. Performance impact is negligible.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-11-09_
