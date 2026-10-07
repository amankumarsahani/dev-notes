# jq

Learned something useful about jq today.

## Key takeaway

The default behavior is not what I expected - need to be explicit about configuration.

## Details

The issue shows up when you combine jq with tailwind. Individually they work fine, but together the ordering matters. Specifically, you need to initialize jq before setting up tailwind, otherwise the state gets corrupted silently.

## See also

- tailwind
- monitoring

---
_2026-06-06_


## FAQ

**Q: What are the security implications?**

A: Yes, with caveats. Monitor the metrics described above and have a rollback plan.
