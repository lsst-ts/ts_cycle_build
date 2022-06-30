#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

echo "# Starting ATSpectrograph CSC"

run_atspectrograph_csc $RUN_ARG &

pid="$!"

wait ${pid}
