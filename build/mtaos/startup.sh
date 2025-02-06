#!/usr/bin/env bash

# Source this file when starting the container to set it up

source ${HOME}/.setup_sal_env.sh

# Add the description
LSST_USER_HOME=/home/saluser
AOS_REPOS=${LSST_USER_HOME}/repos

setup lsst_distrib
setup obs_lsst
setup ts_wep -t current
setup ts_ofc -t current
setup ts_phosim -t current
setup ts_mtaos -t current

if [[ -d "/net/obs-env/auto_base_packages/ts_config_mttcs" ]]; then
    export TS_CONFIG_MTTCS_DIR=/net/obs-env/auto_base_packages/ts_config_mttcs
    echo "Using obs-env MTTCS configuration @ ${TS_CONFIG_MTTCS_DIR}."
else
    echo "Using standard MTTCS configuration @ ${TS_CONFIG_MTTCS_DIR}."
fi

run_mtaos $RUN_ARG &

pid="$!"

wait ${pid}
