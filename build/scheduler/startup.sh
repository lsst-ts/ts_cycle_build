#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

if [[ -d "/net/obs-env/auto_base_packages/ts_config_ocs" ]]; then
    export TS_CONFIG_OCS_DIR=/net/obs-env/auto_base_packages/ts_config_ocs
    git config --global --add safe.directory ${TS_CONFIG_OCS_DIR}
    echo "Using obs-env Scheduler configuration @ ${TS_CONFIG_OCS_DIR}."
else
    echo "Using standard Scheduler configuration @ ${TS_CONFIG_OCS_DIR}."
fi

echo "# Running Scheduler with index: ${INDEX}"

run_scheduler $INDEX &

pid="$!"

wait ${pid}
