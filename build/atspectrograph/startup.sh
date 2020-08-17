#!/usr/bin/env bash

source ${HOME}/.setup_sal_env.sh

echo "# Starting ATSpectrograph CSC"

atspec_csc.py $RUN_ARG &

pid="$!"

wait ${pid}
