#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

if [[ -d "/net/obs-env/auto_base_packages/ts_config_ocs" ]]; then
    export TS_CONFIG_OCS_DIR=/net/obs-env/auto_base_packages/ts_config_ocs
    git config --global --add safe.directory ${TS_CONFIG_OCS_DIR}
    echo "Using obs-env OCS configuration @ ${TS_CONFIG_OCS_DIR}."
else
    echo "Using standard OCS configuration @ ${TS_CONFIG_OCS_DIR}."
fi

echo "# Starting Watcher CSC"

run_watcher ${RUN_ARG} &

pid="$!"

wait ${pid}
