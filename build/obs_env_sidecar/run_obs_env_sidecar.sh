#!/usr/bin/env bash

if [[ -n "${OBSENV_SIDECAR_CONFIG_PATH:-}" ]]; then
  echo "Running observing environment sidecar daemon with ${OBSENV_SIDECAR_CONFIG_PATH} configuration."
  /usr/local/bin/obs_env_sidecar --obs-env-config-path ${OBSENV_SIDECAR_CONFIG_PATH}
else
  /usr/local/bin/obs_env_sidecar
fi
