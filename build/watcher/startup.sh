#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Starting Watcher CSC"

run_watcher ${RUN_ARG} &

pid="$!"

wait ${pid}
