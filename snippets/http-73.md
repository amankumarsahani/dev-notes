# http - code patterns

## Pattern 1: Initialization with cleanup

```
// pseudocode - adapt to your language
resource = http.init(config)
try {
    result = resource.process(input)
    return result
} finally {
    resource.close()
}
```

## Pattern 2: Retry with backoff

```
// pseudocode
for attempt in range(max_retries):
    try:
        return http.execute(params)
    except RetryableError:
        sleep(backoff * 2^attempt)
raise MaxRetriesExceeded
```

## Pattern 3: Circuit breaker

```
// pseudocode
if circuit.is_open():
    return fallback_value
try:
    result = http.call(args)
    circuit.record_success()
    return result
except:
    circuit.record_failure()
    if circuit.should_open():
        circuit.open()
    raise
```

_2026-05-21_
