#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATPneumatics Simulator CSC"

run_atpneumatics_simulator $RUN_ARG &

pid="$!"

wait ${pid}
