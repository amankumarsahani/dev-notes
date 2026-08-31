# event-driven

## Problem

Ran into an issue with event-driven where the order of operations mattered more than I thought.

## Investigation

Checked the logs, nothing obvious. Enabled debug mode and found that event-driven was retrying silently and eventually giving up. The retry backoff was exponential with no cap, so after a few failures it was waiting 5+ minutes between retries.

## Solution

Added validation at startup so it fails fast instead of silently.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-08-31_
