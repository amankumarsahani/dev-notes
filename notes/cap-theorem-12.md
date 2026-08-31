# cap-theorem

## Problem

Ran into an issue with cap-theorem where connections were timing out under load.

## Investigation

Reproduced locally by simulating slow make. The issue only appears under concurrent access - single-threaded tests pass fine. Classic race condition in the connection pool manager.

## Solution

Turned out to be a path resolution issue. Use absolute paths.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-08-31_
