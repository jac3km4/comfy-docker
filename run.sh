#!/usr/bin/env bash

DOCKER=$(which podman || echo "docker")
SCRIPT_DIR=$(dirname -- $( readlink -f -- "$0" ))
COMFY_VOLUME="${COMFY_VOLUME:-comfy-workspace}"

COMFY_ENV_FILE="$SCRIPT_DIR/comfy.env"
if [ -f "$COMFY_ENV_FILE" ]; then
  source "$COMFY_ENV_FILE"
fi

if [ -z "$COMFY_MODEL_DIR" ] || [ -z "$COMFY_OUT_DIR" ]; then
  echo "Please set COMFY_MODEL_DIR and COMFY_OUT_DIR environment variables"
  exit 1
fi

$DOCKER volume create "$COMFY_VOLUME" &>/dev/null || true

$DOCKER run -it --rm \
  --name comfy \
  --gpus all \
  -p 8188:8188 \
  -v "$COMFY_MODEL_DIR:/data" \
  -v "$COMFY_VOLUME:/workspace" \
  -v "$COMFY_OUT_DIR:/workspace/output" \
  --mount type=bind,source="$SCRIPT_DIR/extra_model_paths.yaml",target=/workspace/extra_model_paths.yaml \
  localhost/comfy:0.1.0 \
  "$@"
