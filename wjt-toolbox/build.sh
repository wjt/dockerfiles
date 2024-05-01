#!/bin/bash -ex
BRANCH=latest
IMAGE=wjt-toolbox:$BRANCH
CONTAINER=${IMAGE/:/-}
podman build --tag "$IMAGE" "$@" $(dirname "${BASH_SOURCE[0]}")
if podman ps -a --filter "name=$CONTAINER" --format "{{.Names}}" | grep -q "$CONTAINER"
then
  podman stop "$CONTAINER"
fi
if podman container exists "$CONTAINER"
then
    toolbox rm "$CONTAINER"
fi
toolbox create -i localhost/"$IMAGE"

