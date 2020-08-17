#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting Watcher CSC"

run_watcher.py && \
echo "# Watcher exited ok..." || \
(echo "# Error in Watcher execution." && exit 1)
