# sqlite

## Problem

Ran into an issue with sqlite where connections were timing out under load.

## Investigation

Diffed the configs between staging and prod. Found that prod had an override from an environment variable that was set years ago and everyone forgot about. The sqlite config file was correct, but the env var took precedence.

## Solution

Added validation at startup so it fails fast instead of silently.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-08-07_
