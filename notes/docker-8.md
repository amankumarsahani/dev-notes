# docker - bookmark

Found a good explanation.

**TL;DR**: Mental model > API memorization.

Related: caching

_2026-04-23_

## Example

```
# Minimal reproduction of the issue
# Run with: [command here]
input = prepare_test_data()
output = process(input)
assert output.status == 'ok', f'Expected ok, got {output.status}'
```

_2026-05-29_
