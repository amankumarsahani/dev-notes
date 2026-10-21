# jwt

## Problem

Ran into an issue with jwt where environment variables were being silently ignored.

## Investigation

Reproduced locally by simulating slow deno. The issue only appears under concurrent access - single-threaded tests pass fine. Classic race condition in the connection pool manager.

## Solution

Had to explicitly set the option - can't rely on defaults.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-10-21_
