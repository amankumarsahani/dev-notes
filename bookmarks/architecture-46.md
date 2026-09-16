<!-- Last major revision: 2026-09-03 -->
# architecture

## Problem

Ran into an issue with architecture where the config wasn't being picked up correctly.

## Solution

Added retry logic with exponential backoff.

_2026-04-10_

## Update (2026-09-16)

Revisited this - the approach still holds up. Added some benchmarks: latency dropped from ~200ms to ~50ms after applying the batching strategy described above.

_2026-09-16_
