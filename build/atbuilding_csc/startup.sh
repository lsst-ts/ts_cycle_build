#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATBuilding CSC"

run_atbuilding &

pid="$!"

wait ${pid}
