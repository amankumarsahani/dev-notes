# systemd

## Problem

Ran into an issue with systemd where defaults changed between versions and broke things.

## Investigation

Diffed the configs between staging and prod. Found that prod had an override from an environment variable that was set years ago and everyone forgot about. The systemd config file was correct, but the env var took precedence.

## Solution

Had to explicitly set the option - can't rely on defaults.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-10-04_
