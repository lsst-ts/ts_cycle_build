#!/usr/bin/env bash

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# If running with obsenv sidecar, wait until the environment file exists.
TIMEOUT=180
${OBS_ENV_PATH}/auto_env_setup.sh

if [[ -n "${OBSENV_SIDECAR:-}" ]]; then
    echo "Running with obsenv sidecar. Waiting up to $TIMEOUT seconds for the environment file to be created..."

    start=$(date +%s)

    while [[ ! -e "${OBS_ENV_PATH}/auto_env_setup.sh" ]]; do
        sleep 1
        now=$(date +%s)
        if (( now - start >= TIMEOUT )); then
            echo "Timeout after $TIMEOUT seconds waiting for ${OBS_ENV_PATH}/auto_env_setup.sh"
            exit 1
        fi
    done

    echo "File '${OBS_ENV_PATH}/auto_env_setup.sh' has been created!"
else
    echo "Obsenv sidecar disabled, continuing..."
fi

# setup handlers
# on callback, kill the last background process and execute term_handler
trap 'kill ${!}; term_handler' SIGTERM

source ${WORKDIR}/miniconda/bin/activate
