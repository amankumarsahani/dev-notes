# websockets - TIL

Today I learned that websockets has a built-in profiler that you can enable with a single flag.

## Context

Was working on the concurrency integration and stumbled onto this. The websockets docs bury this feature in the 'Advanced' section, but it should be front and center.

## Impact

This fixes a subtle bug we've had for months. The workaround was masking the real issue.

_2026-09-07_
