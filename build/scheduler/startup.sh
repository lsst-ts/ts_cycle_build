#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

echo "# Running Scheduler with index: ${INDEX}"

run_scheduler $INDEX &

pid="$!"

wait ${pid}
