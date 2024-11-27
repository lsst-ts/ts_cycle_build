#!/usr/bin/env bash

source $HOME/.setup_sal_env.sh

if [[ -d "/net/obs-env/auto_base_packages/ts_config_mttcs" ]]; then
    export TS_CONFIG_MTTCS_DIR=/net/obs-env/auto_base_packages/ts_config_mttcs
    echo "Using obs-env MTTCS configuration @ ${TS_CONFIG_MTTCS_DIR}."
else
    echo "Using standard MTTCS configuration @ ${TS_CONFIG_MTTCS_DIR}."
fi

run_mthexapod $RUN_ARG &

pid="$!"

wait ${pid}
