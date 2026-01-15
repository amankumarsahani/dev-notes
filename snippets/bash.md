# bash

## String operations

```bash
# substring
${var:offset:length}

# replace first match
${var/pattern/replacement}

# replace all matches
${var//pattern/replacement}

# default value
${var:-default}
```

## Arrays

```bash
arr=(one two three)
echo ${arr[0]}       # first element
echo ${#arr[@]}      # length
echo ${arr[@]}       # all elements
```

_2025-04-23_




- TODO: add example
