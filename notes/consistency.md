# consistency

## Details

The issue shows up when you combine consistency with networking. Need to initialize consistency first.

## See also

- networking
- cqrs

_2026-03-23_

- Worth revisiting

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

_2026-05-06_

