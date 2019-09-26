#!/bin/bash -ex
BRANCH=${1:-latest}
podman build --build-arg BRANCH="${BRANCH}" --tag wjt-toolbox $(dirname "${BASH_SOURCE[0]}")
toolbox rm wjt-toolbox-latest || echo "never mind then"
toolbox create -i localhost/wjt-toolbox:"$BRANCH"

