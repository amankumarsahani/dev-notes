# make deep dive

Spent some time really understanding how make works under the hood.

## Architecture

At its core, make uses a pipeline architecture. Data flows through stages, each responsible for one transformation. The beauty is that stages are composable and independently testable.

## Performance characteristics

| Operation | Typical latency | Notes |
|-----------|----------------|-------|
| Read | 1-5ms | Cached path |
| Write | 5-20ms | Depends on durability setting |
| Bulk | 50-200ms | Amortized cost per item is lower |

> These are rough numbers from my testing. YMMV depending on concurrency config.

## When to use / when to avoid

**Use when**: You need make's specific guarantees and the operational overhead is justified.
**Avoid when**: A simpler solution (like plain concurrency) works fine. Don't add make just because it's trendy.

_2026-11-20_
