# system-design

Learned something useful about system-design today.

## Key takeaway

This interacts with distributed-systems in a non-obvious way.

## Details

The issue shows up when you combine system-design with distributed-systems. Individually they work fine, but together the ordering matters. Specifically, you need to initialize system-design before setting up distributed-systems, otherwise the state gets corrupted silently.

## See also

- distributed-systems
- nextjs

---
_2026-06-11_
