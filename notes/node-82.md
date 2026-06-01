# node

## Details

The issue shows up when you combine node with clean-code. Need to initialize node first.

## See also

- clean-code
- prisma

_2026-03-07_

## Example

```
# Minimal reproduction of the issue
# Run with: [command here]
input = prepare_test_data()
output = process(input)
assert output.status == 'ok', f'Expected ok, got {output.status}'
```

_2026-06-01_
