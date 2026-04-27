# docker

Common Docker operations I keep looking up.

```bash
# remove all stopped containers
docker container prune

# shell into running container
docker exec -it <container> /bin/sh

# build with no cache
docker build --no-cache -t myapp .
```

## Multi-stage builds

Keep the final image small by using multi-stage builds. Build in one stage, copy artifacts to a minimal runtime stage.

_2025-04-24_
