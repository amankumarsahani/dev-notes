# jwt

## Problem

Ran into an issue with jwt where the order of operations mattered more than I thought.

## Investigation

Checked the logs, nothing obvious. Enabled debug mode and found that jwt was retrying silently and eventually giving up. The retry backoff was exponential with no cap, so after a few failures it was waiting 5+ minutes between retries.

## Solution

Added retry logic with exponential backoff (capped at 30s). Works reliably now.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-08-15_
