# trpc - TIL

Today I learned that trpc automatically handles back-pressure, which explains why my manual buffering was causing issues.

## Context

Was working on the microservices integration and stumbled onto this. The trpc docs bury this feature in the 'Advanced' section, but it should be front and center.

## Impact

Reduces our trpc boilerplate by ~40%. Going to refactor the existing handlers this week.

_2026-07-26_
