# grep

Useful patterns:

- Always validate inputs at the boundary.
- Don't optimize until you've measured.

_2026-04-10_

- Relevant to current work


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

_2026-11-19_
