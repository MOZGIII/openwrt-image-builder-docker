#!/bin/bash
set -euo pipefail

REPO="${1:?"Specify image repo as the first argument"}"
RUN_ID="${2:?"Specify the run ID as the second argument"}"

DATE="$(date --iso)"

IMAGES=(
  "$REPO:nightly"
  "$REPO:nightly-$DATE"
  "$REPO:nightly-$DATE-$RUN_ID"
)

DOCKER_BUILD_ARGS=()
for IMAGE in "${IMAGES[@]}"; do
  DOCKER_BUILD_ARGS+=(-t "$IMAGE")
done
docker build "${DOCKER_BUILD_ARGS[@]}" .

for IMAGE in "${IMAGES[@]}"; do
  docker push "$IMAGE"
done
