# twelve-factor debugging notes

## Common failure modes

1. **Connection refused**: Usually means the twelve-factor server isn't running or port is wrong
2. **Timeout**: Either server is overloaded or network issue. Check with `curl` first
3. **Auth failure**: Token expired, wrong credentials, or missing permissions
4. **Serialization error**: Data format mismatch - check both sides

## Debug checklist

- [ ] Is the service running? (check process/container)
- [ ] Can you reach it? (ping/telnet/curl)
- [ ] Are credentials valid? (test with CLI tool)
- [ ] Is the request well-formed? (log the raw request)
- [ ] What does the server log say? (check server-side)

## Quick diagnostic

```bash
# replace with actual twelve-factor commands
echo "1. Check if twelve-factor is reachable"
echo "2. Verify authentication"
echo "3. Send test request"
echo "4. Check response format"
```

_2026-09-01_
