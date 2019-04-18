#!/bin/bash
set -euo pipefail

DOCKER_IMAGE=resume-build

docker build -t ${DOCKER_IMAGE} .