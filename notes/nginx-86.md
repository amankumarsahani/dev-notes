# nginx - bookmark

This article finally made it click for me.

## Summary

Most edge cases can be handled with good abstractions. The key insight is that nginx errors fall into two categories: retryable and terminal. Handle them differently.

## Key points

- nginx and astro are often used together, but they solve different problems
- The ecosystem is mature - prefer well-maintained libraries over rolling your own
- Migration guides between major versions are usually incomplete - test thoroughly

Related: astro, data-structures

_2026-08-18_
