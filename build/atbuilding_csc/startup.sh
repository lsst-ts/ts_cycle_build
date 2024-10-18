#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATBuilding CSC"

run_atbuilding $RUN_ARG &

pid="$!"

wait ${pid}
