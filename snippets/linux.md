# linux cheatsheet

Common linux operations I use:

## 1. Setup / init

```bash
# initialize a new linux project
# typically: install, configure, verify
```

## 2. Daily workflow

```bash
# check status
# make changes
# verify changes
# commit/apply
```

## 3. Troubleshooting

```bash
# check logs
# verify config
# test connectivity
# restart if needed
```

## 4. Production

- Always use `--dry-run` first
- Check rollback procedure before applying
- Monitor metrics after changes

> Will fill in actual commands as I use them.

_2026-08-05_

## Update (2026-08-06)

Revisited this - the approach still holds up. Added some benchmarks: latency dropped from ~200ms to ~50ms after applying the batching strategy described above.

_2026-08-06_
