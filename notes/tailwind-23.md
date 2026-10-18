# tailwind deep dive

Spent some time really understanding how tailwind works under the hood.

## Architecture

tailwind is built on an event loop model. Understanding this is crucial because blocking the loop (even briefly) cascades into latency spikes across all consumers. Keep handlers fast and defer heavy work.

## Performance characteristics

| Operation | Typical latency | Notes |
|-----------|----------------|-------|
| Read | 1-5ms | Cached path |
| Write | 5-20ms | Depends on durability setting |
| Bulk | 50-200ms | Amortized cost per item is lower |

> These are rough numbers from my testing. YMMV depending on ci-cd config.

## When to use / when to avoid

**Use when**: You need tailwind's specific guarantees and the operational overhead is justified.
**Avoid when**: A simpler solution (like plain ci-cd) works fine. Don't add tailwind just because it's trendy.

_2026-10-18_
