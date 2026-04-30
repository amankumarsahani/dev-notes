# rest-api

## Problem

Ran into an issue with rest-api where defaults changed between versions and broke things.

## Investigation

Checked the logs, nothing obvious. Enabled debug mode and found that rest-api was retrying silently and eventually giving up. The retry backoff was exponential with no cap, so after a few failures it was waiting 5+ minutes between retries.

## Solution

Had to explicitly set the option - can't rely on defaults.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-04-30_
