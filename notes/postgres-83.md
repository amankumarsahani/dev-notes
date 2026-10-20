# postgres

## Problem

Ran into an issue with postgres where environment variables were being silently ignored.

## Investigation

First thought it was a networking issue, but tcpdump showed packets arriving fine. The problem was upstream - the postgres client was dropping responses that took longer than 5s, and the server was occasionally slow due to consistency contention.

## Solution

Fixed the race condition by using a mutex around the pool checkout. Performance impact is negligible.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-10-20_
