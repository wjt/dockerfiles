#!/bin/bash -ex
if [ $# -gt 1 ]; then
  BRANCH=$1
  shift
else
  BRANCH=latest
fi

# Ensure the Endless VPN is up.
# No idempotent version of 'up'? Thanks, nmcli!
nmcli c up 0bf0fed7-519a-4e78-9d0e-23acb53d010e || :
podman build --build-arg BRANCH="${BRANCH}" --tag wjt-toolbox "$@" $(dirname "${BASH_SOURCE[0]}")
toolbox rm wjt-toolbox-latest 2>/dev/null || :
toolbox create -i localhost/wjt-toolbox:"$BRANCH"

