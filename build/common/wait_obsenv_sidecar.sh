#!/bin/bash

# If running with obsenv sidecar, wait until the environment file exists.
TIMEOUT=180

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


