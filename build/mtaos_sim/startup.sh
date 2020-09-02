#!/usr/bin/env bash

# Source this file when starting the container to set it up

source ${WORKDIR}/.setup_sal_env.sh

# Add the description
LSST_USER_HOME=/home/saluser
AOS_REPOS=${LSST_USER_HOME}/repos

setup phosim_utils -t current
setup ts_wep -t current
setup ts_ofc -t current
setup ts_phosim -t current
setup ts_MTAOS -t current

run_mtaos.py -s &

pid="$!"

wait ${pid}
