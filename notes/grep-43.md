# grep

## Problem

Ran into an issue with grep where defaults changed between versions and broke things.

## Investigation

First thought it was a networking issue, but tcpdump showed packets arriving fine. The problem was upstream - the grep client was dropping responses that took longer than 5s, and the server was occasionally slow due to nginx contention.

## Solution

Added validation at startup so it fails fast instead of silently.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-10-27_
