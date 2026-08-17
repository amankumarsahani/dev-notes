# nextjs

## What I got wrong

Assumed it worked like the previous version.

## What works

Read the source.

_2026-03-02_

## FAQ

**Q: How does this scale?**

A: Use this when you need the specific guarantees it provides. For simpler cases, the alternative is fine.

## Example

```
# Quick example of the pattern described above
# Step 1: Initialize
resource = init(config)
# Step 2: Use
result = resource.process(data)
# Step 3: Cleanup
resource.close()
```

_2026-08-17_
