# consistency

## Problem

Ran into an issue with consistency where the config wasn't being picked up from the right location.

## Investigation

Diffed the configs between staging and prod. Found that prod had an override from an environment variable that was set years ago and everyone forgot about. The consistency config file was correct, but the env var took precedence.

## Solution

Fixed the race condition by using a mutex around the pool checkout. Performance impact is negligible.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-09-28_
