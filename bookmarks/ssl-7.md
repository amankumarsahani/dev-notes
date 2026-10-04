# ssl - links

## Resources

- [ssl reference](https://jvns.ca/ssl) - Best explanation I've found
- [ssl in practice](https://overreacted.io/ssl-guide) - Production patterns

## Notes

Pairs well with the jq notes.

## Key quotes

> "The first 90% of the code takes 90% of the time. The remaining 10% takes the other 90%."

_2026-09-29_

## Update (2026-10-04)

Clarified a few points that were vague. Specifically, the initialization order matters: configure logging first, then connections, then start the worker pool. Doing it out of order causes silent failures.

_2026-10-04_
