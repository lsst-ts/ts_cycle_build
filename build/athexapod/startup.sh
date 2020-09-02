#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATHexapod CSC"

runATHexapodCSC.py $RUN_ARG &

pid="$!"

wait ${pid}
