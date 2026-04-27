# git

## Useful commands

```bash
# interactive rebase last N commits
git rebase -i HEAD~N

# search commit messages
git log --grep="keyword"

# show what changed in a file
git log -p -- path/to/file
```

## Tips

- Use `git stash` before switching branches with uncommitted work
- `git reflog` is a lifesaver for recovering lost commits

_2025-04-25_
