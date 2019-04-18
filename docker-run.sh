#!/bin/bash
set -euo pipefail

DOCKER_IMAGE=resume-build

docker run -it -v ${PWD}:/build ${DOCKER_IMAGE} "$@"