# nextjs

## Problem

Ran into an issue with nextjs where the config wasn't being picked up from the right location.

## Investigation

First thought it was a networking issue, but tcpdump showed packets arriving fine. The problem was upstream - the nextjs client was dropping responses that took longer than 5s, and the server was occasionally slow due to git contention.

## Solution

Fixed the race condition by using a mutex around the pool checkout. Performance impact is negligible.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-11-13_
