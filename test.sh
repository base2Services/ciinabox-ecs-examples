#!/bin/bash
set -x
for ciinabox in demo_* ; do
  printf "\n\nTesting ${ciinabox}\n\n"
  # avoid validation in PRs as aws creds are not available
  set +e
  if [[ "$TRAVIS_EVENT_TYPE" =~ ^push|api$ ]]; then
    ciinabox-ecs generate validate ${ciinabox}
  else
    ciinabox-ecs generate ${ciinabox}
  fi
  if [ $? -ne 0 ]; then
    printf "\n\nCIINABOX test configuration ${ciinabox} failed\n\n"
    exit 2
  fi
done
