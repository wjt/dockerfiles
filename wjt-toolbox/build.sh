#!/bin/bash -ex
args=$(getopt -o h -l "branch:,help" -n "$0" -- "$@")
eval set -- "$args"

BRANCH=master

while true
do
  case "$1" in
    --branch)
      shift
      BRANCH="$1"
      shift
      ;;

    -h|--help)
      cat <<EOF
Usage: $0 [--branch BRANCH] [-- [podman build args]]

--pull is an argument you might want to pass
EOF
      exit 0
      ;;
    --)
      shift
      break
  esac
done

podman build --build-arg BRANCH="${BRANCH}" --tag wjt-toolbox:$BRANCH "$@" $(dirname "${BASH_SOURCE[0]}")
podman stop wjt-toolbox-$BRANCH || :
toolbox rm wjt-toolbox-$BRANCH || :
toolbox create -i localhost/wjt-toolbox:"$BRANCH"

