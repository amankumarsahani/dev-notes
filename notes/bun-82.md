# bun

## Problem

Ran into an issue with bun where defaults changed between versions and broke things.

## Investigation

Diffed the configs between staging and prod. Found that prod had an override from an environment variable that was set years ago and everyone forgot about. The bun config file was correct, but the env var took precedence.

## Solution

Turned out to be a path resolution issue. Use absolute paths.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-10-04_
