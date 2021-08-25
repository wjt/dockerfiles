#!/bin/bash -ex
if [ $# -ge 1 ]; then
  BRANCH=$1
  shift
else
  BRANCH=latest
fi

podman build --build-arg BRANCH="${BRANCH}" --tag wjt-toolbox:$BRANCH "$@" $(dirname "${BASH_SOURCE[0]}")
podman stop wjt-toolbox-$BRANCH || :
toolbox rm wjt-toolbox-$BRANCH || :
toolbox create -i localhost/wjt-toolbox:"$BRANCH"

