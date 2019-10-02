#!/bin/bash -ex
BRANCH=${1:latest}
shift

podman build --build-arg BRANCH="${BRANCH}" --tag wjt-toolbox "$@" $(dirname "${BASH_SOURCE[0]}")
toolbox rm wjt-toolbox-latest 2>/dev/null || :
toolbox create -i localhost/wjt-toolbox:"$BRANCH"

