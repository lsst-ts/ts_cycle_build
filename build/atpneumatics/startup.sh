#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATPneumatics CSC"

run_atpneumatics $RUN_ARG &

pid="$!"

wait ${pid}
