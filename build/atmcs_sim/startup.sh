#!/usr/bin/env bash


source ${HOME}/.setup_sal_env.sh

echo "# Starting ATMCS Simulator CSC"

run_atmcs_simulator $RUN_ARG &

pid="$!"

wait ${pid}
