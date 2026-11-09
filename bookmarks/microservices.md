# microservices

## Problem

Ran into an issue with microservices where the order of operations mattered more than I thought.

## Investigation

First thought it was a networking issue, but tcpdump showed packets arriving fine. The problem was upstream - the microservices client was dropping responses that took longer than 5s, and the server was occasionally slow due to grep contention.

## Solution

Pinned the version. Will revisit when we upgrade to the next major.

## Lessons

- Always check for env var overrides when config seems to be ignored
- Add connection timeout logging, not just error logging
- Test under concurrent load, not just sequential

_2026-11-08_
