# websockets - TIL

Today I learned that websockets has a built-in profiler that you can enable with a single flag.

## Context

Was working on the rust integration and stumbled onto this. The websockets docs bury this feature in the 'Advanced' section, but it should be front and center.

## Impact

Reduces our websockets boilerplate by ~40%. Going to refactor the existing handlers this week.

_2026-09-06_

